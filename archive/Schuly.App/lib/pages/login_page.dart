import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../l10n/app_localizations.dart';
import '../providers/api_store.dart';
import '../main.dart';
import 'microsoft_auth_page.dart';

class LoginPage extends StatefulWidget {
  final void Function(String)? onApiBaseUrlChanged;
  final String? initialApiBaseUrl;
  const LoginPage({super.key, this.onApiBaseUrlChanged, this.initialApiBaseUrl});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiBaseUrlController = TextEditingController();
  bool _isLoading = false;
  bool _showPassword = false;
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _apiBaseUrlController.text = widget.initialApiBaseUrl ?? apiBaseUrl;
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          _appVersion = 'v${packageInfo.version}';
        });
      }
    } catch (e) {
      // Keep empty string if package info fails
    }
  }

  Future<void> _performLogin() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      final apiStore = Provider.of<ApiStore>(context, listen: false);
      
      if (widget.onApiBaseUrlChanged != null) {
        widget.onApiBaseUrlChanged!(_apiBaseUrlController.text.trim());
      }
      
      final error = await apiStore.addUser(_emailController.text.trim(), _passwordController.text);
      
      if (mounted) {
        if (error == null) {
          await apiStore.fetchAll();
          // Login successful - navigation is handled by main app
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.unexpectedError(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                    Text(
                      AppLocalizations.of(context)!.login,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _apiBaseUrlController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.apiBaseUrl,
                        prefixIcon: const Icon(Icons.cloud_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                      validator: (v) => v == null || v.isEmpty ? AppLocalizations.of(context)!.enterApiEndpoint : null,
                      onChanged: (value) async {
                        await setApiBaseUrl(value.trim());
                        if (widget.onApiBaseUrlChanged != null) {
                          widget.onApiBaseUrlChanged!(value.trim());
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return AppLocalizations.of(context)!.enterEmailAddress;
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                          return AppLocalizations.of(context)!.enterValidEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.password,
                        prefixIcon: const Icon(Icons.lock_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _showPassword = !_showPassword),
                        ),
                      ),
                      obscureText: !_showPassword,
                      textInputAction: TextInputAction.done,
                      validator: (v) => v == null || v.isEmpty ? AppLocalizations.of(context)!.enterPassword : null,
                      onFieldSubmitted: (_) {
                        if (!_isLoading && _formKey.currentState!.validate()) {
                          _performLogin();
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isLoading ? null : _performLogin,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20, 
                                height: 20, 
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(AppLocalizations.of(context)!.login),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(localizations.or),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _isLoading ? null : () async {
                          logDebug('Microsoft sign-in button pressed', source: 'LoginPage');

                          // Navigate to Microsoft auth page
                          final result = await Navigator.of(context).push<bool>(
                            MaterialPageRoute(
                              builder: (context) => MicrosoftAuthPage(
                                apiBaseUrl: _apiBaseUrlController.text.trim(),
                                existingUserEmail: null, // New account
                                onAuthSuccess: (token, refreshToken, email) async {
                                  logDebug('Microsoft auth successful', source: 'LoginPage');
                                  logDebug('Received token: $token', source: 'LoginPage');
                                  logDebug('Received refresh token: $refreshToken', source: 'LoginPage');

                                  // Store the tokens and update the app state
                                  final apiStore = Provider.of<ApiStore>(context, listen: false);

                                  // Store the API base URL
                                  if (widget.onApiBaseUrlChanged != null) {
                                    widget.onApiBaseUrlChanged!(_apiBaseUrlController.text.trim());
                                  }

                                  // Add the Microsoft user with tokens
                                  await apiStore.addMicrosoftUser(token, refreshToken);

                                  // Fetch user data
                                  await apiStore.fetchAll();
                                },
                              ),
                            ),
                          );

                          if (result == true && mounted) {
                            logDebug('Microsoft authentication completed successfully', source: 'LoginPage');
                            // Authentication successful - navigation handled by main app
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/4/44/Microsoft_logo.svg',
                          width: 20,
                          height: 20,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.business, size: 20),
                        ),
                        label: Text(localizations.signInWithMicrosoft),
                      ),
                    ),
                  ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Version display at the bottom
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedOpacity(
                opacity: _appVersion.isNotEmpty ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  _appVersion,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
