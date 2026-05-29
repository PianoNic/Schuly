import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/oidc_config.dart';
import '../../services/active_account_service.dart';
import '../../services/api_client.dart';
import '../../services/school_data_service.dart';
import '../classes/class_detail_screen.dart';

/// Account tab — profile details, enrolled classes, app info, and the account
/// switcher + sign out.
class AccountPage extends StatefulWidget {
  final String? pictureUrl;
  final String? userName;
  final VoidCallback onOpenSwitcher;
  final VoidCallback onSignOut;
  const AccountPage({
    super.key,
    required this.pictureUrl,
    required this.userName,
    required this.onOpenSwitcher,
    required this.onSignOut,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? _version;
  bool _syncing = false;
  String? _syncMsg;

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final res = await ApiClient.instance.api.getAppApi().apiAppGet();
      if (mounted) setState(() => _version = res.data?.version);
    } catch (_) {/* non-critical */}
  }

  /// Triggers an actual provider re-fetch for the active account, then reloads
  /// the local data. Unlike pull-to-refresh (which only re-reads the backend),
  /// this pulls fresh data from Schulnetz / OdaOrg.
  Future<void> _syncNow() async {
    final active = ActiveAccountService.instance.active;
    final accountId = active?.pluginAccountId;
    if (accountId == null) {
      setState(() => _syncMsg = 'No connected account to sync');
      return;
    }
    setState(() {
      _syncing = true;
      _syncMsg = null;
    });
    try {
      final sync = ApiClient.instance.api.getSyncApi();
      if (active!.provider == 'odaorg') {
        await sync.apiPluginsOdaorgAccountsAccountIdSyncPost(accountId: accountId);
      } else {
        await sync.apiPluginsSchulwareAccountsAccountIdSyncPost(accountId: accountId);
      }
      await SchoolDataService.instance.refresh();
      if (mounted) setState(() => _syncMsg = 'Synced just now');
    } on DioException catch (e) {
      if (mounted) setState(() => _syncMsg = 'Sync failed (${e.response?.statusCode ?? 'network'})');
    } catch (e) {
      if (mounted) setState(() => _syncMsg = 'Sync failed');
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final me = SchoolDataService.instance.me;
    final classes = me?.classes ?? const <UserClassDto>[];

    String fmtDate(Date? d) => d == null ? '—' : '${d.day}.${d.month}.${d.year}';
    final fullName = me == null
        ? (widget.userName ?? '—')
        : '${me.firstName ?? ''} ${me.lastName ?? ''}'.trim();
    final initial = fullName.isNotEmpty ? fullName.characters.first.toUpperCase() : '?';
    final fallback = Text(initial,
        style: TextStyle(color: colors.mutedForeground, fontWeight: FontWeight.w600));
    // Prefer the school provider's photo (may be relative), fall back to OIDC.
    final providerPfp = OidcConfig.resolveUrl(me?.profilePictureUrl);
    final avatarUrl = providerPfp ?? widget.pictureUrl;

    return RefreshIndicator(
      onRefresh: () async {
        await SchoolDataService.instance.refresh();
        await _loadVersion();
      },
      child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        // Identity header
        Row(
          children: [
            (avatarUrl == null || avatarUrl.isEmpty)
                ? FAvatar.raw(size: 56, child: fallback)
                : FAvatar(size: 56, image: NetworkImage(avatarUrl), fallback: fallback),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fullName.isEmpty ? 'Account' : fullName,
                      style: typography.lg.copyWith(fontWeight: FontWeight.w700)),
                  if (me?.role != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: _Badge(_roleLabel(me!.role)),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SectionLabel('Profile'),
        _InfoTile(icon: FIcons.mail, label: 'Email', value: me?.email),
        _InfoTile(icon: FIcons.phone, label: 'Phone', value: me?.phoneNumber),
        _InfoTile(
          icon: FIcons.mapPin,
          label: 'Address',
          value: [me?.street, [me?.zip, me?.city].where((s) => (s ?? '').isNotEmpty).join(' ')]
              .where((s) => (s ?? '').isNotEmpty)
              .join(', '),
        ),
        _InfoTile(icon: FIcons.cake, label: 'Birthday', value: fmtDate(me?.birthday)),
        _InfoTile(icon: FIcons.logIn, label: 'Joined', value: fmtDate(me?.entryDate)),
        const SizedBox(height: 20),
        if (classes.isNotEmpty) ...[
          _SectionLabel('My classes'),
          for (final c in classes)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FTile(
                prefix: const Icon(FIcons.users),
                title: Text(c.className ?? 'Class'),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ClassDetailScreen(
                    classId: c.classId,
                    title: c.className ?? 'Class',
                  ),
                )),
              ),
            ),
          const SizedBox(height: 12),
        ],
        if (SchoolDataService.instance.teachers.isNotEmpty) ...[
          _SectionLabel('Teachers'),
          for (final t in SchoolDataService.instance.teachers)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FTile(
                prefix: const Icon(FIcons.user),
                title: Text('${t.firstName ?? ''} ${t.lastName ?? ''}'.trim()),
                subtitle: (t.code?.isNotEmpty ?? false) ? Text(t.code!) : null,
                suffix: (t.email?.isNotEmpty ?? false) ? const Icon(FIcons.mail) : null,
                onPress: (t.email?.isNotEmpty ?? false)
                    ? () => launchUrl(Uri(scheme: 'mailto', path: t.email))
                    : null,
              ),
            ),
          const SizedBox(height: 12),
        ],
        if (SchoolDataService.instance.documents.isNotEmpty) ...[
          _SectionLabel('Documents'),
          for (final dDoc in SchoolDataService.instance.documents)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FTile(
                prefix: const Icon(FIcons.fileText),
                title: Text(dDoc.title?.isNotEmpty == true ? dDoc.title! : (dDoc.fileName ?? 'Document')),
                subtitle: Text([
                  dDoc.category,
                  if (dDoc.fileSizeBytes != null) _fmtSize(dDoc.fileSizeBytes!),
                ].whereType<String>().where((s) => s.isNotEmpty).join(' · ')),
              ),
            ),
          const SizedBox(height: 12),
        ],
        _SectionLabel('App'),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: FTile(
            prefix: _syncing
                ? const SizedBox(
                    width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(FIcons.refreshCw),
            title: const Text('Sync now'),
            subtitle: _syncMsg != null
                ? Text(_syncMsg!)
                : const Text('Fetch fresh data from the provider'),
            onPress: _syncing ? null : _syncNow,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: FTile(
            prefix: const Icon(FIcons.repeat),
            title: const Text('Switch account'),
            onPress: widget.onOpenSwitcher,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: FTile(
            prefix: const Icon(FIcons.info),
            title: const Text('Version'),
            suffix: Text(_version ?? '—', style: TextStyle(color: colors.mutedForeground)),
          ),
        ),
        const SizedBox(height: 4),
        FButton(
          prefix: const Icon(FIcons.logOut),
          onPress: widget.onSignOut,
          child: const Text('Sign out'),
        ),
      ],
      ),
    );
  }

  static String _fmtSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  static String _roleLabel(Roles? r) => switch (r) {
        Roles.teacher => 'Teacher',
        Roles.administrator => 'Administrator',
        _ => 'Student',
      };
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) {
    final c = context.theme.colors;
    final t = context.theme.typography;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: Text(text.toUpperCase(),
          style: t.xs.copyWith(color: c.mutedForeground, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  const _InfoTile({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: FTile(
          prefix: Icon(icon),
          title: Text(label),
          details: Text((value?.isNotEmpty ?? false) ? value! : '—'),
        ),
      );
}

class _Badge extends StatelessWidget {
  final String text;
  const _Badge(this.text);
  @override
  Widget build(BuildContext context) {
    final c = context.theme.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: c.secondary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text, style: TextStyle(color: c.secondaryForeground, fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }
}
