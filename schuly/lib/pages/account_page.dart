import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/info_row.dart';
import '../widgets/profile_header.dart';
import '../providers/theme_provider.dart';
import '../providers/api_store.dart';
import 'app_settings_page.dart';
import 'student_card_page.dart';

class AccountPage extends StatelessWidget {
  final ThemeProvider themeProvider;

  const AccountPage({
    super.key,
    required this.themeProvider,
  });

  @override
  Widget build(BuildContext context) {
    final apiStore = Provider.of<ApiStore>(context);
    final userEmails = apiStore.userEmails;
    final activeUserEmail = apiStore.activeUserEmail;
    final userInfo = apiStore.userInfo;

    // No account added
    if (userEmails.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person_off, size: 64, color: Colors.grey),
              const SizedBox(height: 24),
              const Text(
                'Noch kein Account hinzugefügt.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => _showAddAccountDialog(context, apiStore),
                icon: const Icon(Icons.add),
                label: const Text('Account hinzufügen'),
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              ),
            ],
          ),
        ),
      );
    }

    // No active user selected
    if (activeUserEmail == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person_search, size: 64, color: Colors.grey),
              const SizedBox(height: 24),
              const Text(
                'Kein aktiver Account ausgewählt.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => _showAccountSwitcher(context),
                icon: const Icon(Icons.swap_horiz),
                label: const Text('Account auswählen'),
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await apiStore.fetchUserInfo();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (userInfo != null)
              ProfileHeader(
                name: '${userInfo.firstName} ${userInfo.lastName}',
                email: userInfo.email,
                onStudentCardPressed: () => _showStudentCard(context),
                onSwitchAccountPressed: () => _showAccountSwitcher(context),
              ),
            if (userInfo != null) ...[
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              // Personal Information
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Persönliche Angaben',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      InfoRow(label: 'Name', value: '${userInfo.firstName} ${userInfo.lastName}'),
                      InfoRow(label: 'Strasse', value: userInfo.street),
                      InfoRow(label: 'PLZ Ort', value: '${userInfo.zip} ${userInfo.city}'),
                      InfoRow(label: 'Geburtsdatum', value: userInfo.birthday),
                      InfoRow(label: 'Telefon', value: userInfo.phone),
                      InfoRow(label: 'E-Mail', value: userInfo.email),
                      InfoRow(label: 'Nationalität', value: userInfo.nationality),
                      InfoRow(label: 'Heimatort', value: userInfo.hometown),
                      InfoRow(label: 'Handy', value: userInfo.mobile),
                      InfoRow(label: 'Profil 1', value: userInfo.profil1),
                      InfoRow(label: 'Profil 2', value: userInfo.profil2),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            // Quick Actions Card (always shown if user is logged in)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Schnellaktionen',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('App Einstellungen'),
                      subtitle: const Text('Design und Einstellungen anpassen'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AppSettingsPage(
                              themeProvider: themeProvider,
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.help_outline),
                      title: const Text('Hilfe & Support'),
                      subtitle: const Text('Häufige Fragen und Kontakt'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Hilfe & Support - Coming Soon!'),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Abmelden'),
                      subtitle: const Text('Von der App abmelden'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.refresh),
                      title: const Text('Get new token'),
                      subtitle: const Text('Hole ein neues Token für den aktiven Account'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final apiStore = Provider.of<ApiStore>(context, listen: false);
                        final email = apiStore.activeUserEmail;
                        final user = apiStore.activeUser;
                        if (email != null && user != null) {
                          final ok = await apiStore.addUser(email, user['password']);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(ok == null ? 'Token aktualisiert!' : ok),
                              backgroundColor: ok == null ? Colors.green : Colors.red,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Kein aktiver Account!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStudentCard(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const StudentCardPage(),
      ),
    );
  }

  void _showAccountSwitcher(BuildContext context) {
    final apiStore = Provider.of<ApiStore>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        final users = apiStore.userEmails;
        final activeEmail = apiStore.activeUserEmail;
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text('Account wechseln', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 20),
              if (users.isEmpty)
                const Text('Noch kein Account hinzugefügt.'),
              for (final email in users)
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: email == activeEmail
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.person,
                        color: email == activeEmail
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    title: Text(email, style: TextStyle(fontWeight: email == activeEmail ? FontWeight.bold : FontWeight.normal)),
                    subtitle: email == activeEmail ? const Text('Aktiv') : null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (email != activeEmail)
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            tooltip: 'Account entfernen',
                            onPressed: () async {
                              await apiStore.removeUser(email);
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Account entfernt: $email'), backgroundColor: Colors.red),
                              );
                            },
                          ),
                        if (email != activeEmail)
                          IconButton(
                            icon: const Icon(Icons.check_circle, color: Colors.green),
                            tooltip: 'Account aktivieren',
                            onPressed: () async {
                              await apiStore.switchUser(email);
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Account gewechselt: $email'), backgroundColor: Colors.green),
                              );
                            },
                          ),
                        if (email == activeEmail)
                          const Icon(Icons.check_circle, color: Colors.green),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showAddAccountDialog(context, apiStore),
                  icon: const Icon(Icons.add),
                  label: const Text('Account hinzufügen'),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  void _showAddAccountDialog(BuildContext context, ApiStore apiStore) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isLoading = false;
    bool showPassword = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Account hinzufügen'),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'E-Mail'),
                      validator: (v) => v == null || v.isEmpty ? 'E-Mail eingeben' : null,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Passwort',
                        suffixIcon: IconButton(
                          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => showPassword = !showPassword),
                        ),
                      ),
                      obscureText: !showPassword,
                      validator: (v) => v == null || v.isEmpty ? 'Passwort eingeben' : null,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Abbrechen'),
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) return;
                          setState(() => isLoading = true);
                          final ok = await apiStore.addUser(emailController.text.trim(), passwordController.text);
                          setState(() => isLoading = false);
                          if (ok == null) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Account hinzugefügt!'), backgroundColor: Colors.green),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(ok), backgroundColor: Colors.red),
                            );
                          }
                        },
                  child: isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Hinzufügen'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final apiStore = Provider.of<ApiStore>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Abmelden'),
          content: const Text(
            'Sind Sie sicher, dass Sie sich abmelden möchten?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await apiStore.clearAll();
                await themeProvider.clearThemePrefs();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Abgemeldet!'),
                    backgroundColor: Colors.orange,
                  ),
                );
                // Pop to root/login
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Abmelden'),
            ),
          ],
        );
      },
    );
  }
}