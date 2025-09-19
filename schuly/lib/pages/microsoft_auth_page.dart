import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:schuly/api/lib/api.dart';
import '../utils/logger.dart';

class MicrosoftAuthPage extends StatefulWidget {
  final String apiBaseUrl;
  final String? existingUserEmail; // For re-authentication
  final Function(String token, String refreshToken, String email) onAuthSuccess;

  const MicrosoftAuthPage({
    super.key,
    required this.apiBaseUrl,
    this.existingUserEmail,
    required this.onAuthSuccess,
  });

  @override
  State<MicrosoftAuthPage> createState() => _MicrosoftAuthPageState();
}

class _MicrosoftAuthPageState extends State<MicrosoftAuthPage> {
  WebViewController? _controller;
  String? _codeVerifier;
  String? _authUrl;
  bool _isLoading = true;
  bool _isWebViewReady = false;
  String _statusMessage = 'Initializing Microsoft authentication...';

  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }


  Future<void> _initializeAuth() async {
    try {
      setState(() {
        _statusMessage = 'Fetching Microsoft OAuth URL...';
      });

      final apiClient = ApiClient(basePath: widget.apiBaseUrl);
      final authApi = AuthApi(apiClient);

      logDebug('Calling authenticateOauthMobileUrl endpoint', source: 'MicrosoftAuthPage');
      final response = await authApi.authenticateOauthMobileUrl();

      if (response == null) {
        throw Exception('Failed to get OAuth URL from server');
      }

      // Extract the authorization URL and code verifier from response
      _authUrl = response.authorizationUrl;
      _codeVerifier = response.codeVerifier;

      logInfo('Received OAuth URL and code verifier', source: 'MicrosoftAuthPage');
      logDebug('OAuth URL: $_authUrl', source: 'MicrosoftAuthPage');

      setState(() {
        _statusMessage = 'Preparing fresh browser session...';
      });

      // Initialize WebView with fresh session
      await _initializeWebView();

      // Mark WebView as ready and update UI
      if (mounted) {
        setState(() {
          _statusMessage = 'Loading Microsoft login page...';
          _isWebViewReady = true;
          _isLoading = false; // Hide loading overlay to show WebView
        });
      }

    } catch (e) {
      logError('Failed to initialize OAuth', source: 'MicrosoftAuthPage', error: e);
      setState(() {
        _isLoading = false;
        _statusMessage = 'Failed to initialize: ${e.toString()}';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to initialize Microsoft authentication: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _initializeWebView() async {
    // Don't clear cookies - keep the WebView session persistent
    // This allows users to stay logged in to Microsoft
    logDebug('Using shared WebView session', source: 'MicrosoftAuthPage');

    if (widget.existingUserEmail != null) {
      logInfo('Re-authentication for user: ${widget.existingUserEmail}', source: 'MicrosoftAuthPage');
    }

    // Create platform-specific parameters for better isolation
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    // Create a new WebView controller with fresh instance
    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent('Schuly Mobile App ${DateTime.now().millisecondsSinceEpoch}') // Unique user agent per session
      ..enableZoom(false) // Disable zoom for cleaner UI
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            logDebug('Page started loading: $url', source: 'MicrosoftAuthPage');
            if (mounted) {
              setState(() {
                _statusMessage = 'Loading Microsoft login...';
              });
            }
          },
          onPageFinished: (String url) {
            logDebug('Page finished loading', source: 'MicrosoftAuthPage');
            if (mounted) {
              setState(() {
                _isLoading = false;
                _statusMessage = '';
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            logDebug('Navigation request to: ${request.url}', source: 'MicrosoftAuthPage');

            // Check for redirect with authorization code
            final uri = Uri.parse(request.url);

            // Check if this is a redirect (302) with callback URL
            if (request.url.contains('/callback?code=') ||
                request.url.contains('schulnetz.web.app/callback')) {

              logInfo('Detected callback URL with authorization code', source: 'MicrosoftAuthPage');

              // Extract code and state from URL
              final code = uri.queryParameters['code'];
              final state = uri.queryParameters['state'];

              logDebug('Extracted code: ${code?.substring(0, 10)}...', source: 'MicrosoftAuthPage');
              logDebug('State: $state', source: 'MicrosoftAuthPage');

              if (code != null) {
                // Don't navigate to the callback URL
                _handleAuthorizationCode(code, state);
                return NavigationDecision.prevent;
              }
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            logError('WebView error: ${error.description}', source: 'MicrosoftAuthPage');
            if (mounted) {
              setState(() {
                _statusMessage = 'Error: ${error.description}';
              });
            }
          },
          onHttpError: (HttpResponseError error) {
            logWarning('HTTP error: ${error.response?.statusCode}', source: 'MicrosoftAuthPage');
            if (error.response?.statusCode == 302) {
              logDebug('302 redirect detected', source: 'MicrosoftAuthPage');
              // The navigation delegate should handle this
            }
          },
        ),
      );

    if (_authUrl != null) {
      logDebug('Loading OAuth URL in WebView', source: 'MicrosoftAuthPage');
      _controller?.loadRequest(Uri.parse(_authUrl!));
    }
  }

  // No need to save cookies - WebView maintains its own session

  Future<void> _handleAuthorizationCode(String code, String? state) async {
    logInfo('Handling authorization code', source: 'MicrosoftAuthPage');

    setState(() {
      _isLoading = true;
      _statusMessage = 'Processing authentication...';
    });

    try {
      // Call the callback endpoint with the code and verifier
      final apiClient = ApiClient(basePath: widget.apiBaseUrl);
      final authApi = AuthApi(apiClient);

      final callbackRequest = MobileCallbackRequestDto(
        code: code,
        codeVerifier: _codeVerifier!,
        state: state,
      );

      logDebug('Calling authenticateOauthMobileCallback', source: 'MicrosoftAuthPage');
      logDebug('Code verifier length: ${_codeVerifier?.length}', source: 'MicrosoftAuthPage');

      final response = await authApi.authenticateOauthMobileCallback(callbackRequest);

      if (response != null) {
        logInfo('Authentication successful', source: 'MicrosoftAuthPage');
        logDebug('Received access and refresh tokens', source: 'MicrosoftAuthPage');

        // Get user email - use existing or will be determined by parent
        String userEmail = widget.existingUserEmail ?? '';

        // For new users, we need to get the email from the token/API
        // The parent will handle this, but we need to save cookies after
        // So we'll save cookies after calling onAuthSuccess

        // Call success callback with email
        widget.onAuthSuccess(response.accessToken, response.refreshToken, userEmail);

        // Close the WebView page
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      } else {
        throw Exception('No response from authentication callback');
      }

    } catch (e) {
      logError('Failed to complete OAuth callback', source: 'MicrosoftAuthPage', error: e);
      setState(() {
        _isLoading = false;
        _statusMessage = 'Authentication failed';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Authentication failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in with Microsoft'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ),
      body: Stack(
        children: [
          if (_isWebViewReady && _controller != null)
            WebViewWidget(controller: _controller!),

          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.9),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      _statusMessage,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}