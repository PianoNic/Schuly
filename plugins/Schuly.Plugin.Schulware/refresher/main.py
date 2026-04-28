import asyncio
import os
import httpx
from contextlib import asynccontextmanager
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Optional, Dict
from playwright.async_api import async_playwright, Browser, BrowserContext
from urllib.parse import urlencode, urlparse, parse_qs

SCHULNETZ_CLIENT_ID = os.getenv("SCHULNETZ_CLIENT_ID", "ppyybShnMerHdtBQ")

browser: Optional[Browser] = None
contexts: Dict[str, BrowserContext] = {}


@asynccontextmanager
async def lifespan(app: FastAPI):
    global browser
    pw = await async_playwright().start()
    browser = await pw.chromium.launch(headless=True)
    yield
    await browser.close()
    await pw.stop()


app = FastAPI(title="Schulware Token Refresher", version="1.0.0", lifespan=lifespan)


class RefreshRequest(BaseModel):
    schulnetz_base_url: str
    user_id: str
    email: Optional[str] = None
    password: Optional[str] = None


class RefreshResponse(BaseModel):
    success: bool
    access_token: Optional[str] = None
    refresh_token: Optional[str] = None
    session_id: Optional[str] = None
    web_session_user_id: Optional[str] = None
    web_session_trans_id: Optional[str] = None
    message: Optional[str] = None


async def get_or_create_context(user_id: str) -> BrowserContext:
    if user_id not in contexts:
        storage_dir = f"/tmp/schulware_contexts/{user_id}"
        os.makedirs(storage_dir, exist_ok=True)
        storage_path = f"{storage_dir}/state.json"

        if os.path.exists(storage_path):
            contexts[user_id] = await browser.new_context(storage_state=storage_path)
        else:
            contexts[user_id] = await browser.new_context()

    return contexts[user_id]


async def save_context(user_id: str, context: BrowserContext):
    storage_dir = f"/tmp/schulware_contexts/{user_id}"
    os.makedirs(storage_dir, exist_ok=True)
    await context.storage_state(path=f"{storage_dir}/state.json")


@app.post("/refresh", response_model=RefreshResponse)
async def refresh_tokens(request: RefreshRequest):
    try:
        context = await get_or_create_context(request.user_id)
        page = await context.new_page()

        code = None
        state = None

        try:
            # Navigate to Schulnetz — triggers Microsoft SSO
            await page.goto(request.schulnetz_base_url, wait_until="load", timeout=60000)

            current_url = page.url

            # Check if we landed on Microsoft login (SSO session expired)
            if "login.microsoftonline.com" in current_url:
                if not request.email or not request.password:
                    return RefreshResponse(
                        success=False,
                        message="Microsoft SSO session expired. Email and password required for re-authentication."
                    )

                # Enter email
                email_input = 'input[type="email"], input[name="loginfmt"]'
                await page.wait_for_selector(email_input, timeout=10000)
                await page.fill(email_input, request.email)
                await page.click("#idSIButton9")

                # Enter password
                password_input = 'input[type="password"], input[name="passwd"]'
                await page.wait_for_selector(password_input, timeout=10000)
                await page.fill(password_input, request.password)
                await page.click("#idSIButton9")

                # Handle "Stay signed in?" prompt
                try:
                    stay_signed_in = page.locator("#idSIButton9")
                    await stay_signed_in.wait_for(state="visible", timeout=5000)
                    await stay_signed_in.click()
                except:
                    pass

                # Wait for redirect back to Schulnetz
                await page.wait_for_url(f"{request.schulnetz_base_url}*", timeout=30000)

            current_url = page.url

            # Extract code from URL
            if "code=" in current_url:
                parsed = urlparse(current_url)
                params = parse_qs(parsed.query)
                code = params.get("code", [None])[0]
                state = params.get("state", [None])[0]

            if not code:
                # Try getting a second code by navigating again
                await page.goto(request.schulnetz_base_url, wait_until="load", timeout=30000)
                current_url = page.url
                if "code=" in current_url:
                    parsed = urlparse(current_url)
                    params = parse_qs(parsed.query)
                    code = params.get("code", [None])[0]
                    state = params.get("state", [None])[0]

            if not code:
                return RefreshResponse(success=False, message="Failed to obtain authorization code")

            # Save browser context for future use
            await save_context(request.user_id, context)

        finally:
            await page.close()

        # Exchange code for mobile tokens
        access_token = None
        refresh_token = None

        async with httpx.AsyncClient() as client:
            # We need PKCE params — generate them
            import hashlib, base64, secrets, string

            code_verifier = ''.join(secrets.choice(string.ascii_letters + string.digits) for _ in range(128))
            s256 = hashlib.sha256(code_verifier.encode()).digest()
            code_challenge = base64.urlsafe_b64encode(s256).decode().rstrip("=")

            # Get a fresh code with PKCE via authorize.php
            auth_params = {
                "response_type": "code",
                "client_id": SCHULNETZ_CLIENT_ID,
                "state": secrets.token_hex(16),
                "redirect_uri": "",
                "scope": "openid ",
                "code_challenge": code_challenge,
                "code_challenge_method": "S256",
                "nonce": secrets.token_hex(16),
            }

            page2 = await context.new_page()
            pkce_code = None
            try:
                captured = {"code": None}

                async def intercept_callback(route):
                    url = route.request.url
                    if "code=" in url:
                        parsed_url = urlparse(url)
                        params = parse_qs(parsed_url.query)
                        captured["code"] = params.get("code", [None])[0]
                    await route.abort()

                await page2.route("**/schulnetz.web.app/**", intercept_callback)
                await page2.route("**/callback*code=*", intercept_callback)

                auth_url = f"{request.schulnetz_base_url}/authorize.php?{urlencode(auth_params)}"

                try:
                    await page2.goto(auth_url, wait_until="load", timeout=30000)
                except Exception:
                    pass

                pkce_code = captured["code"]

                if not pkce_code and "code=" in page2.url:
                    parsed = urlparse(page2.url)
                    pkce_code = parse_qs(parsed.query).get("code", [None])[0]
            finally:
                await page2.close()

            if pkce_code:
                token_res = await client.post(
                    f"{request.schulnetz_base_url}/token.php",
                    data={
                        "grant_type": "authorization_code",
                        "code": pkce_code,
                        "redirect_uri": "",
                        "code_verifier": code_verifier,
                        "client_id": SCHULNETZ_CLIENT_ID,
                    },
                    headers={"Content-Type": "application/x-www-form-urlencoded"},
                )

                if token_res.status_code == 200:
                    token_data = token_res.json()
                    access_token = token_data.get("access_token")
                    refresh_token = token_data.get("refresh_token")

        # Capture web session using the original code
        session_id = None
        web_user_id = None
        web_trans_id = None

        async with httpx.AsyncClient(follow_redirects=True, timeout=30.0) as client:
            login_url = f"{request.schulnetz_base_url}/loginto.php"
            params = {"code": code, "state": state or "", "mode": "4", "lang": ""}
            res = await client.get(login_url, params=params)

            cookies = {}
            for resp in res.history + [res]:
                cookies.update(dict(resp.cookies))

            session_id = cookies.get("PHPSESSID")

            # Extract session params from landing page
            import re
            html = res.text
            id_match = re.search(r'[?&]id=([a-f0-9]{10,})', html)
            transid_match = re.search(r'[?&]transid=([a-f0-9]+)', html)
            web_user_id = id_match.group(1) if id_match else None
            web_trans_id = transid_match.group(1) if transid_match else None

        await save_context(request.user_id, context)

        return RefreshResponse(
            success=True,
            access_token=access_token,
            refresh_token=refresh_token,
            session_id=session_id,
            web_session_user_id=web_user_id,
            web_session_trans_id=web_trans_id,
            message="Tokens and session refreshed successfully",
        )

    except Exception as e:
        return RefreshResponse(success=False, message=f"Refresh failed: {str(e)}")


class SeedRequest(BaseModel):
    user_id: str
    cookies: list[Dict]


@app.post("/seed")
async def seed_session(request: SeedRequest):
    """Seed a Playwright browser context with cookies from the mobile app's WebView."""
    try:
        if request.user_id in contexts:
            await contexts[request.user_id].close()
            del contexts[request.user_id]

        context = await browser.new_context()

        playwright_cookies = []
        for c in request.cookies:
            cookie = {
                "name": c.get("name", ""),
                "value": c.get("value", ""),
                "domain": c.get("domain", ""),
                "path": c.get("path", "/"),
            }
            if cookie["name"] and cookie["value"] and cookie["domain"]:
                if not cookie["domain"].startswith(".") and not cookie["domain"].startswith("http"):
                    cookie["domain"] = "." + cookie["domain"]
                playwright_cookies.append(cookie)

        if playwright_cookies:
            await context.add_cookies(playwright_cookies)

        contexts[request.user_id] = context
        await save_context(request.user_id, context)

        return {"success": True, "cookies_set": len(playwright_cookies), "message": "Session seeded"}
    except Exception as e:
        return {"success": False, "message": f"Seed failed: {str(e)}"}


@app.get("/health")
async def health():
    return {"status": "ok", "contexts": len(contexts)}


@app.delete("/contexts/{user_id}")
async def delete_context(user_id: str):
    if user_id in contexts:
        await contexts[user_id].close()
        del contexts[user_id]
    return {"deleted": user_id}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8001)
