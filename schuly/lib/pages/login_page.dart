import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/api_store.dart';
import '../main.dart';

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

  @override
  void initState() {
    super.initState();
    _apiBaseUrlController.text = widget.initialApiBaseUrl ?? apiBaseUrl;
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
            content: Text('Unerwarteter Fehler: $e'),
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
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Anmelden',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _apiBaseUrlController,
                      decoration: InputDecoration(
                        labelText: 'API Base URL',
                        prefixIcon: const Icon(Icons.cloud_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                      validator: (v) => v == null || v.isEmpty ? 'API Endpoint eingeben' : null,
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
                        labelText: 'E-Mail-Adresse',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Bitte geben Sie eine E-Mail-Adresse ein';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                          return 'Bitte geben Sie eine gültige E-Mail-Adresse ein';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Passwort',
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
                      validator: (v) => v == null || v.isEmpty ? 'Bitte geben Sie Ihr Passwort ein' : null,
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
                            : const Text('Anmelden'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
