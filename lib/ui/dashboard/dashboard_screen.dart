import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../services/active_account_service.dart';
import '../../services/api_client.dart';
import '../schulnetz/connect_account_screen.dart';
import 'widgets/accounts_sidebar.dart';

/// Post-sign-in shell. Owns the avatar in the top-left, opens the sidebar on
/// tap, and routes to the connect flow when the user has zero accounts.
///
/// The actual dashboard content is intentionally a stub for now — once the
/// agenda/exam/absence endpoints are wired in we'll fill out the body.
class DashboardScreen extends StatefulWidget {
  final VoidCallback onSignOut;
  const DashboardScreen({super.key, required this.onSignOut});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _syncing = false;
  String? _syncMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  Future<void> _bootstrap() async {
    final svc = ActiveAccountService.instance;
    await svc.refresh();
    if (!mounted) return;
    if (svc.accounts.isEmpty) {
      await _pushConnect();
    }
  }

  Future<void> _pushConnect() async {
    final newId = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const ConnectAccountScreen()),
    );
    if (newId != null) {
      await ActiveAccountService.instance.refresh();
      await ActiveAccountService.instance.setActive(newId);
    }
  }

  Future<void> _forceSync() async {
    final svc = ActiveAccountService.instance;
    final active = svc.active;
    if (active == null) return;
    setState(() {
      _syncing = true;
      _syncMessage = null;
    });
    try {
      await ApiClient.instance.api
          .getSyncApi()
          .apiPluginsSchulwareAccountsAccountIdSyncPost(accountId: active.id);
      setState(() => _syncMessage = 'Sync triggered for ${active.displayName}');
    } on DioException catch (e) {
      setState(() => _syncMessage =
          'Sync failed: HTTP ${e.response?.statusCode} ${e.response?.data}');
    } catch (e) {
      setState(() => _syncMessage = 'Sync failed: $e');
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  void _openSidebar() {
    openAccountsSidebar(context, onSignOut: widget.onSignOut);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return AnimatedBuilder(
      animation: ActiveAccountService.instance,
      builder: (context, _) {
        final svc = ActiveAccountService.instance;
        final active = svc.active;
        final initial = (active?.displayName.isNotEmpty ?? false)
            ? active!.displayName.characters.first.toUpperCase()
            : '?';

        return FScaffold(
          header: FHeader(
            title: Text(active?.displayName ?? 'Schuly'),
            suffixes: [
              FHeaderAction(
                icon: const Icon(FIcons.refreshCw),
                onPress: _syncing ? null : _forceSync,
              ),
            ],
            // FHeader doesn't expose a left-prefix slot; instead we use the
            // title widget. Tappable avatar lives in a leading position via
            // a Row below — see the body's first child.
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _openSidebar,
                    child: FAvatar.raw(
                      child: Text(
                        initial,
                        style: TextStyle(color: colors.primaryForeground),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      active?.schulnetzBaseUrl ?? 'No account connected',
                      style: TextStyle(color: colors.mutedForeground),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (svc.loading)
                const Center(child: CircularProgressIndicator())
              else if (svc.accounts.isEmpty)
                FCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 12,
                      children: [
                        const Text('No school accounts yet.'),
                        FButton(
                          onPress: _pushConnect,
                          child: const Text('Connect your first school'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                FCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 12,
                      children: [
                        Text('Active: ${active?.displayName ?? '—'}'),
                        Text(active?.schulnetzBaseUrl ?? '',
                            style: TextStyle(color: colors.mutedForeground)),
                        FButton(
                          onPress: _syncing ? null : _forceSync,
                          child: Text(_syncing ? 'Syncing…' : 'Force sync'),
                        ),
                        if (_syncMessage != null)
                          SelectableText(_syncMessage!,
                              style: TextStyle(color: colors.mutedForeground)),
                      ],
                    ),
                  ),
                ),
              if (svc.error != null)
                SelectableText('Load error: ${svc.error}',
                    style: TextStyle(color: colors.destructive)),
            ],
          ),
        );
      },
    );
  }
}
