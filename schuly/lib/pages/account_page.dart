import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/info_row.dart';
import '../widgets/profile_header.dart';
import '../widgets/help_support_modal.dart';
import '../widgets/account_switcher.dart';
import '../providers/theme_provider.dart';
import '../providers/api_store.dart';
import '../utils/url_launcher_helper.dart';
import 'app_settings_page.dart';
import 'student_card_page.dart';
import 'logs_viewer_page.dart';
import 'microsoft_auth_page.dart';
import '../main.dart';
import '../l10n/app_localizations.dart';

class AccountPage extends StatelessWidget {
  final ThemeProvider themeProvider;

  const AccountPage({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    final apiStore = Provider.of<ApiStore>(context);
    final localizations = AppLocalizations.of(context)!;
    final userEmails = apiStore.userEmails;
    final activeUserEmail = apiStore.activeUserEmail;
    final userInfo = apiStore.userInfo;

    // No account added
    if (userEmails.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person_off, size: 64, color: Colors.grey),
              const SizedBox(height: 24),
              Text(
                localizations.noAccountAdded,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => _showAddAccountDialog(context, apiStore),
                icon: const Icon(Icons.add),
                label: Text(localizations.addAccount),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person_search, size: 64, color: Colors.grey),
              const SizedBox(height: 24),
              Text(
                localizations.noActiveAccount,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => _showAccountSwitcher(context),
                icon: const Icon(Icons.swap_horiz),
                label: Text(localizations.selectAccount),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await apiStore.fetchUserInfo(forceRefresh: true);
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
                isMicrosoftAuth: apiStore.activeUser?['is_microsoft_auth'] == true,
                onStudentCardPressed: () => _showStudentCard(context),
                onSwitchAccountPressed: () => _showAccountSwitcher(context),
              ),
            if (userInfo != null) ...[
              const SizedBox(height: 8),
              // Personal Information
              Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.personalInformation,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      InfoRow(
                        label: localizations.name,
                        value: '${userInfo.firstName} ${userInfo.lastName}',
                      ),
                      InfoRow(
                        label: localizations.street,
                        value: userInfo.street,
                      ),
                      InfoRow(
                        label: localizations.zipCity,
                        value: '${userInfo.zip} ${userInfo.city}',
                      ),
                      InfoRow(
                        label: localizations.birthDate,
                        value: userInfo.birthday,
                      ),
                      InfoRow(
                        label: localizations.phone,
                        value: userInfo.phone,
                      ),
                      InfoRow(
                        label: localizations.email,
                        value: userInfo.email,
                      ),
                      InfoRow(
                        label: localizations.nationality,
                        value: userInfo.nationality,
                      ),
                      InfoRow(
                        label: localizations.hometown,
                        value: userInfo.hometown,
                      ),
                      InfoRow(
                        label: localizations.mobile,
                        value: userInfo.mobile,
                      ),
                      InfoRow(
                        label: localizations.profile1,
                        value: userInfo.profil1,
                      ),
                      if (userInfo.profil2 != null)
                        InfoRow(
                          label: localizations.profile2,
                          value: userInfo.profil2!,
                        ),
                    ],
                  ),
                ),
              ),
            ],
            // Quick Actions Card (always shown if user is logged in)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.quickActions,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: Text(localizations.appSettings),
                      subtitle: Text(localizations.designAndSettings),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                AppSettingsPage(themeProvider: themeProvider),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.terminal),
                      title: Text(localizations.consoleLogs),
                      subtitle: Text(localizations.viewAppDebugLogs),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LogsViewerPage(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.help_outline),
                      title: Text(localizations.helpAndSupport),
                      subtitle: Text(localizations.getHelpAndSupport),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => const HelpSupportModal(),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: Text(localizations.logout),
                      subtitle: Text(localizations.signOutFromApp),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.refresh),
                      title: Text(localizations.getNewToken),
                      subtitle: Text(localizations.getNewTokenSubtitle),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final apiStore = Provider.of<ApiStore>(
                          context,
                          listen: false,
                        );
                        final email = apiStore.activeUserEmail;
                        final user = apiStore.activeUser;
                        if (email != null && user != null) {
                          // Check if this is a Microsoft-authenticated user
                          if (user['is_microsoft_auth'] == true) {
                            // Re-authenticate with Microsoft using the fixed cookie storage
                            final result = await Navigator.of(context).push<bool>(
                              MaterialPageRoute(
                                builder: (ctx) => MicrosoftAuthPage(
                                  apiBaseUrl: apiBaseUrl,
                                  existingUserEmail: email, // This will restore cookies
                                  onAuthSuccess: (token, refreshToken, userEmail) async {
                                    // Update the user's tokens
                                    await apiStore.addMicrosoftUser(token, refreshToken, email);
                                    await apiStore.fetchAll();
                                  },
                                ),
                              ),
                            );
                            if (result == true && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(localizations.tokenUpdated),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          } else {
                            // Traditional email/password re-authentication
                            final ok = await apiStore.addUser(
                              email,
                              user['password'],
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(ok ?? localizations.tokenUpdated),
                                  backgroundColor: ok == null
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              );
                            }
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(localizations.noActiveAccountSnack),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(Icons.coffee, color: Colors.amber.shade600),
                      title: Text(localizations.buyMeACoffee),
                      subtitle: Text(localizations.supportDevelopment),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () {
                        _launchBuyMeACoffee(context);
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
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const StudentCardPage()));
  }

  void _launchBuyMeACoffee(BuildContext context) async {
    final success = await UrlLauncherHelper.launchUrl('https://buymeacoffee.com/pianonic');
    if (!success && context.mounted) {
      final localizations = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.couldNotOpenBuyMeACoffee),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAccountSwitcher(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (BuildContext context) => const AccountSwitcher(),
    );
  }

  void _showAddAccountDialog(BuildContext context, ApiStore apiStore) {
    final localizations = AppLocalizations.of(context)!;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isLoading = false;
    bool showPassword = false;
    showDialog(
      context: context,
      barrierDismissible: !isLoading,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final localizations = AppLocalizations.of(context)!;
            return PopScope(
              canPop: !isLoading,
              child: AlertDialog(
                title: Text(localizations.addAccountTitle),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: localizations.emailLabel,
                        ),
                        validator: (v) => v == null || v.isEmpty
                            ? localizations.enterEmail
                            : null,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: localizations.passwordLabel,
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () =>
                                setState(() => showPassword = !showPassword),
                          ),
                        ),
                        obscureText: !showPassword,
                        validator: (v) => v == null || v.isEmpty
                            ? localizations.enterPassword
                            : null,
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
                          onPressed: isLoading ? null : () async {

                            // Navigate to Microsoft auth page
                            if (context.mounted) {
                              final result = await Navigator.of(context).push<bool>(
                                MaterialPageRoute(
                                  builder: (ctx) => MicrosoftAuthPage(
                                    apiBaseUrl: apiBaseUrl,
                                    existingUserEmail: null, // New account
                                    onAuthSuccess: (token, refreshToken, email) async {
                                      // Add the Microsoft user with tokens
                                      final error = await apiStore.addMicrosoftUser(token, refreshToken);

                                      // Fetch user data
                                      await apiStore.fetchAll();
                                    },
                                  ),
                                ),
                              );

                              if (result == true && context.mounted) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(localizations.accountAdded),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            }
                          },
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
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(localizations.cancel),
                  ),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (!formKey.currentState!.validate()) return;
                            setState(() => isLoading = true);
                            final ok = await apiStore.addUser(
                              emailController.text.trim(),
                              passwordController.text,
                            );
                            setState(() => isLoading = false);
                            if (ok == null) {
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(localizations.accountAdded),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(ok),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(localizations.add),
                  ),
                ],
              ),
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
        final localizations = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(localizations.logoutTitle),
          content: Text(localizations.logoutConfirm),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(localizations.cancel),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await apiStore.clearAll();
                await themeProvider.clearThemePrefs();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(localizations.loggedOut),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  // Pop to root/login
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
              child: Text(localizations.logout),
            ),
          ],
        );
      },
    );
  }
}
