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

  @override
  Widget build(BuildContext context) {
    final apiStore = Provider.of<ApiStore>(context, listen: false);
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
                    Text('Login', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _apiBaseUrlController,
                      decoration: const InputDecoration(
                        labelText: 'API Base URL',
                      ),
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
                      decoration: const InputDecoration(labelText: 'E-Mail'),
                      validator: (v) => v == null || v.isEmpty ? 'E-Mail eingeben' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Passwort',
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _showPassword = !_showPassword),
                        ),
                      ),
                      obscureText: !_showPassword,
                      validator: (v) => v == null || v.isEmpty ? 'Passwort eingeben' : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState == null || !_formKey.currentState!.validate()) return;
                                setState(() => _isLoading = true);
                                if (widget.onApiBaseUrlChanged != null) {
                                  widget.onApiBaseUrlChanged!(_apiBaseUrlController.text.trim());
                                }
                                final error = await apiStore.addUser(_emailController.text.trim(), _passwordController.text);
                                if (error == null) {
                                  await apiStore.fetchAll();
                                  // ignore: use_build_context_synchronously
                                  // Navigator.of(context).pushReplacementNamed('/');
                                } else {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error), backgroundColor: Colors.red),
                                  );
                                }
                                if (!mounted) return;
                                setState(() => _isLoading = false);
                              },
                        child: _isLoading
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Text('Login'),
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
