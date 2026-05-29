import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../services/active_account_service.dart';
import 'add_school_modal.dart';

/// Teams-style left-edge account switcher. Top shows the signed-in identity
/// (profile picture + name + email), followed by the list of connected school
/// accounts with a checkmark on the active one, then "Add school account" and
/// "Sign out".
///
/// The sheet owns the add-account flow: it shows the system picker, pushes the
/// connect screen on the *parent* navigator (so it survives sheet dismissal),
/// and on success refreshes the accounts list and selects the new account.
class AccountsSidebar extends StatelessWidget {
  /// Parent navigator — needed for pushing the connect screen, since this
  /// widget is mounted inside a modal sheet route.
  final NavigatorState parentNavigator;
  final VoidCallback? onSignOut;
  final String? userName;
  final String? userEmail;
  final String? pictureUrl;

  const AccountsSidebar({
    super.key,
    required this.parentNavigator,
    this.onSignOut,
    this.userName,
    this.userEmail,
    this.pictureUrl,
  });

  Future<void> _add(BuildContext context) async {
    final svc = ActiveAccountService.instance;
    final before = svc.schools.map((s) => s.id).toSet();
    final connected = await runAddSchoolFlow(context, parentNavigator);
    if (connected == null) return;
    // The connect flow returns a Schulware account id, not a school id; find
    // the school that newly appeared in my-schools and make it active.
    await svc.refresh();
    final added = svc.schools.where((s) => !before.contains(s.id));
    if (added.isNotEmpty) await svc.setActive(added.first.id);
    if (context.mounted) Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return DecoratedBox(
      // Opaque surface + trailing border so the dashboard doesn't bleed
      // through the sheet. showFSheet does not supply a background itself.
      decoration: BoxDecoration(
        color: colors.background,
        border: Border(right: BorderSide(color: colors.border)),
      ),
      child: AnimatedBuilder(
        animation: ActiveAccountService.instance,
        builder: (context, _) {
          final svc = ActiveAccountService.instance;
          final active = svc.active;

          // showFSheet strips MediaQuery.padding, so SafeArea is a no-op here.
          // viewPadding survives, so pad the content with it manually — keeps
          // the background full-bleed while clearing the status bar / nav bar.
          final viewPadding = MediaQuery.viewPaddingOf(context);
          return Padding(
            padding: EdgeInsets.only(
              top: viewPadding.top,
              bottom: viewPadding.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _IdentityHeader(
                  name: userName,
                  email: userEmail,
                  pictureUrl: pictureUrl,
                ),
                FDivider(style: (s) => s.copyWith(padding: EdgeInsets.zero)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
                  child: Text(
                    'Schools'.toUpperCase(),
                    style: typography.xs.copyWith(
                      color: colors.mutedForeground,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      for (final s in svc.schools)
                        FTile(
                          prefix: _SchoolAvatar(logoUrl: s.logoUrl, fallbackAsset: s.logoAsset),
                          title: Text(s.name),
                          subtitle: (s.fullName?.isNotEmpty ?? false)
                              ? Text(s.fullName!)
                              : (s.email?.isNotEmpty ?? false)
                                  ? Text(s.email!)
                                  : null,
                          suffix: s.id == active?.id
                              ? Icon(FIcons.check, color: colors.primary)
                              : null,
                          onPress: () async {
                            await svc.setActive(s.id);
                            if (context.mounted) {
                              Navigator.of(context).maybePop();
                            }
                          },
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FTile(
                        prefix: const Icon(FIcons.plus),
                        title: const Text('Add school account'),
                        onPress: () => _add(context),
                      ),
                      if (onSignOut != null) ...[
                        const SizedBox(height: 4),
                        FTile(
                          prefix: const Icon(FIcons.logOut),
                          title: const Text('Sign out'),
                          onPress: () {
                            Navigator.of(context).maybePop();
                            onSignOut!();
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Rounded-square avatar for a school account, à la Teams' org tiles. Shows
/// the provider's logo on a muted surface. Today every account is Schulnetz;
/// once other providers exist this should pick the asset by provider.
class _SchoolAvatar extends StatelessWidget {
  static const double size = 40;
  final String? logoUrl;
  final String fallbackAsset;
  const _SchoolAvatar({required this.logoUrl, required this.fallbackAsset});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fallback = Image.asset(fallbackAsset, fit: BoxFit.contain);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(7),
      child: (logoUrl == null)
          ? fallback
          : Image.network(logoUrl!, fit: BoxFit.contain,
              errorBuilder: (_, _, _) => fallback),
    );
  }
}

class _IdentityHeader extends StatelessWidget {
  final String? name;
  final String? email;
  final String? pictureUrl;
  const _IdentityHeader({this.name, this.email, this.pictureUrl});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final displayName = (name?.isNotEmpty ?? false) ? name! : 'Signed in';
    final initial = displayName.characters.first.toUpperCase();
    final fallback = Text(
      initial,
      style: TextStyle(color: colors.mutedForeground, fontWeight: FontWeight.w600),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          (pictureUrl == null || pictureUrl!.isEmpty)
              ? FAvatar.raw(size: 48, child: fallback)
              : FAvatar(size: 48, image: NetworkImage(pictureUrl!), fallback: fallback),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  displayName,
                  style: typography.base.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                if (email?.isNotEmpty ?? false)
                  Text(
                    email!,
                    style: typography.sm.copyWith(color: colors.mutedForeground),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Convenience wrapper that opens the sidebar as a left-side modal sheet.
Future<void> openAccountsSidebar(
  BuildContext context, {
  VoidCallback? onSignOut,
  String? userName,
  String? userEmail,
  String? pictureUrl,
}) {
  final parentNavigator = Navigator.of(context);
  return showFSheet<void>(
    context: context,
    side: FLayout.ltr,
    mainAxisMaxRatio: 0.78,
    builder: (sheetCtx) => AccountsSidebar(
      parentNavigator: parentNavigator,
      onSignOut: onSignOut,
      userName: userName,
      userEmail: userEmail,
      pictureUrl: pictureUrl,
    ),
  );
}
