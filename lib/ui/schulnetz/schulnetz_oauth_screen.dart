import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// Result of the Schulnetz OAuth WebView flow. Mirrors what the Kotlin
/// test-app captures (see C:\Coding\SchulwareAPI\test-app\…\MainActivity.kt):
/// the final `code`/`state` plus a Playwright-format `storage_state` JSON
/// blob built from cookies + per-origin localStorage, plus the WebView's UA.
/// The plugin persists context_state + user_agent so the stateless refresh
/// endpoint can replay the SSO chain without prompting.
class SchulnetzOAuthResult {
  final String code;
  final String? state;
  final String contextState;
  final String userAgent;
  SchulnetzOAuthResult({
    required this.code,
    required this.state,
    required this.contextState,
    required this.userAgent,
  });
}

class SchulnetzOAuthScreen extends StatefulWidget {
  final String authorizationUrl;
  const SchulnetzOAuthScreen({super.key, required this.authorizationUrl});

  @override
  State<SchulnetzOAuthScreen> createState() => _SchulnetzOAuthScreenState();
}

class _SchulnetzOAuthScreenState extends State<SchulnetzOAuthScreen> {
  // origin (scheme://host) → list of {name, value} maps scraped from window.localStorage
  final Map<String, List<Map<String, String>>> _capturedLocalStorage = {};
  bool _captured = false;

  // Real Chrome UA so MS doesn't fall into edge fallback paths.
  static const _userAgent =
      'Mozilla/5.0 (Linux; Android 14; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36';

  // Every host the SSO chain plausibly touches. Cookie manager only returns
  // cookies that would be sent for the queried URL, so we union over all of
  // these. Same list as the Kotlin tester.
  static const _originsToProbe = <String>[
    'https://schulnetz.bbbaden.ch',
    'https://schulnetz.web.app',
    'https://login.microsoftonline.com',
    'https://login.microsoft.com',
    'https://login.live.com',
    'https://login.windows.net',
    'https://account.live.com',
    'https://account.microsoft.com',
    'https://aadcdn.msauth.net',
    'https://aadcdn.msftauth.net',
    'https://device.login.microsoftonline.com',
  ];

  Future<NavigationActionPolicy> _shouldOverride(
      InAppWebViewController c, NavigationAction action) async {
    final uri = action.request.url;
    if (_captured || uri == null) return NavigationActionPolicy.CANCEL;

    // MS also redirects with a code= param, but the FINAL Schulnetz-issued
    // code lives only at schulnetz.web.app/callback. Strictly host-gate.
    if (uri.host == 'schulnetz.web.app' &&
        uri.path == '/callback' &&
        uri.queryParameters['code'] != null) {
      _captured = true;
      final code = uri.queryParameters['code']!;
      final state = uri.queryParameters['state'];

      final contextState = await _buildContextState();
      if (!mounted) return NavigationActionPolicy.CANCEL;
      Navigator.of(context).pop(SchulnetzOAuthResult(
        code: code,
        state: state,
        contextState: contextState,
        userAgent: _userAgent,
      ));
      return NavigationActionPolicy.CANCEL;
    }
    return NavigationActionPolicy.ALLOW;
  }

  Future<void> _onPageFinished(InAppWebViewController c, WebUri? url) async {
    if (url == null) return;
    final scheme = url.scheme;
    final host = url.host;
    if (scheme.isEmpty || host.isEmpty) return;
    final origin = '$scheme://$host';
    try {
      final raw = await c.evaluateJavascript(source: '''
        (function(){var o=[];try{for(var i=0;i<localStorage.length;i++){var k=localStorage.key(i);o.push({name:k,value:localStorage.getItem(k)});}}catch(e){}return JSON.stringify(o);})()
      ''');
      if (raw is String && raw.isNotEmpty) {
        final decoded = jsonDecode(raw);
        if (decoded is List && decoded.isNotEmpty) {
          _capturedLocalStorage[origin] = decoded
              .whereType<Map>()
              .map((e) => {
                    'name': e['name']?.toString() ?? '',
                    'value': e['value']?.toString() ?? '',
                  })
              .toList();
        }
      }
    } catch (_) {
      // origin had no accessible localStorage; ignore.
    }
  }

  /// Snapshot cookies (across all SSO origins) + localStorage into a
  /// Playwright `storage_state` JSON blob.
  Future<String> _buildContextState() async {
    final cm = CookieManager.instance();
    final cookies = <Map<String, String>>[];
    final seen = <String>{}; // dedupe domain|name|value

    final origins =
        {..._originsToProbe, ..._capturedLocalStorage.keys}.toList();

    for (final origin in origins) {
      final uri = WebUri(origin);
      final host = uri.host;
      if (host.isEmpty) continue;
      final cookieDomain = host.startsWith('.') ? host : '.$host';
      final list = await cm.getCookies(url: uri);
      for (final cookie in list) {
        final name = cookie.name;
        final value = cookie.value.toString();
        if (name.isEmpty) continue;
        final dedupeKey = '$cookieDomain|$name|$value';
        if (!seen.add(dedupeKey)) continue;
        cookies.add({
          'name': name,
          'value': value,
          'domain': cookieDomain,
          'path': '/',
        });
      }
    }

    final originsArr = <Map<String, Object>>[];
    _capturedLocalStorage.forEach((origin, ls) {
      originsArr.add({'origin': origin, 'localStorage': ls});
    });

    return jsonEncode({'cookies': cookies, 'origins': originsArr});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schulnetz Login')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.authorizationUrl)),
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          useShouldOverrideUrlLoading: true,
          domStorageEnabled: true,
          databaseEnabled: true,
          thirdPartyCookiesEnabled: true,
          userAgent: _userAgent,
        ),
        shouldOverrideUrlLoading: _shouldOverride,
        onLoadStop: _onPageFinished,
      ),
    );
  }
}
