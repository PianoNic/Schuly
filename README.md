# <p align="center">Schuly</p>
<p align="center">
  <img src="https://raw.githubusercontent.com/schulydev/Schuly/main/assets/app_icon.png" width="160" alt="Schuly Logo">
</p>
<p align="center">
  <strong>The better Schulnetz app — Flutter mobile client</strong>
</p>
<p align="center">
  <a href="https://github.com/schulydev/Schuly/stargazers"><img src="https://img.shields.io/github/stars/schulydev/Schuly?style=flat&color=3da8ff" alt="GitHub stars"/></a>
  <a href="https://github.com/schulydev/Schuly/releases"><img src="https://img.shields.io/github/v/release/schulydev/Schuly?include_prereleases&color=3da8ff&label=Release" alt="Latest Release"/></a>
  <a href="https://schuly.dev"><img src="https://img.shields.io/badge/site-schuly.dev-3da8ff" alt="Website"/></a>
</p>

A modern Flutter mobile app providing a superior alternative to the official Schulnetz client. Intuitive interface, multi-user support, and seamless access to grades, schedules, and student information.

> [!IMPORTANT]
> This project is **NOT** affiliated with, endorsed by, or connected to Schulnetz or Centerboard AG in any way.

## The Schuly ecosystem

| Repo | Purpose |
|---|---|
| [**Schuly**](https://github.com/schulydev/Schuly) | Flutter mobile app *(this repo)* |
| [**SchulyBackend**](https://github.com/schulydev/SchulyBackend) | ASP.NET Core API backend |
| [**SchulyPluginAbstractions**](https://github.com/schulydev/SchulyPluginAbstractions) | Plugin contract (NuGet) |
| [**SchulyPlugins**](https://github.com/schulydev/SchulyPlugins) | Official plugins monorepo |
| [**SchulyWebsite**](https://github.com/schulydev/SchulyWebsite) | Landing site ([schuly.dev](https://schuly.dev)) |

## Run / build

```sh
flutter run --flavor dev
flutter run --flavor prod
flutter build apk --flavor prod --release
flutter build ios --flavor prod --no-codesign
```

Flavors: `dev` (`com.schuly.app.dev`, "Schuly DEV") and `prod` (`com.schuly.app`, "Schuly"). Targets Android and iOS only.

## Regenerate the API client

The Dart client at `lib/api/` is generated from [SchulyBackend](https://github.com/schulydev/SchulyBackend)'s OpenAPI spec. See `CLAUDE.md` for the exact commands.

## App icons

Source: `assets/app_icon.png`. Regenerate with `dart run flutter_launcher_icons`.
