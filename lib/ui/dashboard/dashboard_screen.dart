import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

import '../../services/active_account_service.dart';
import '../../services/auth_service.dart';
import '../../services/school_data_service.dart';
import '../absences/absences_page.dart';
import '../account/account_page.dart';
import '../grades/grades_page.dart';
import '../home/home_page.dart';
import '../timetable/timetable_page.dart';
import 'widgets/accounts_sidebar.dart';
import 'widgets/add_school_modal.dart';

/// Post-sign-in shell: a 5-tab bottom-navigation app. The top bar carries the
/// profile avatar (opens the account switcher) and the active school name.
class DashboardScreen extends StatefulWidget {
  final VoidCallback onSignOut;
  const DashboardScreen({super.key, required this.onSignOut});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _pictureUrl;
  String? _userName;
  String? _userEmail;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    ActiveAccountService.instance.addListener(_onActiveChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  @override
  void dispose() {
    ActiveAccountService.instance.removeListener(_onActiveChanged);
    super.dispose();
  }

  String? _lastSchoolId;
  void _onActiveChanged() {
    final id = ActiveAccountService.instance.active?.id;
    if (id != _lastSchoolId) {
      _lastSchoolId = id;
      // Drop the previous school's cached data so we don't show stale content
      // during the switch, then load the new school.
      SchoolDataService.instance.clear();
      SchoolDataService.instance.refresh();
    }
  }

  Future<void> _bootstrap() async {
    final claims = await AuthService.getIdTokenClaims();
    if (mounted && claims != null) {
      setState(() {
        _pictureUrl = claims['picture'] as String?;
        _userName = claims['name'] as String?;
        _userEmail = claims['email'] as String?;
      });
    }

    final svc = ActiveAccountService.instance;
    await svc.refresh();
    if (!mounted) return;
    if (svc.schools.isEmpty) {
      await _addSchool();
    } else {
      _lastSchoolId = svc.active?.id;
      await SchoolDataService.instance.refresh();
    }
  }

  Future<void> _addSchool() async {
    final svc = ActiveAccountService.instance;
    final before = svc.schools.map((s) => s.id).toSet();
    final connected = await runAddSchoolFlow(context, Navigator.of(context));
    if (connected == null) return;
    await svc.refresh();
    final added = svc.schools.where((s) => !before.contains(s.id));
    if (added.isNotEmpty) await svc.setActive(added.first.id);
  }

  void _openSidebar() {
    openAccountsSidebar(
      context,
      onSignOut: widget.onSignOut,
      userName: _userName,
      userEmail: _userEmail,
      pictureUrl: _pictureUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return AnimatedBuilder(
      animation: Listenable.merge([
        ActiveAccountService.instance,
        SchoolDataService.instance,
      ]),
      builder: (context, _) {
        final account = ActiveAccountService.instance;
        final data = SchoolDataService.instance;
        final active = account.active;

        final pages = [
          const HomePage(),
          const TimetablePage(),
          const GradesPage(),
          const AbsencesPage(),
          AccountPage(
            pictureUrl: _pictureUrl,
            userName: _userName,
            onOpenSwitcher: _openSidebar,
            onSignOut: widget.onSignOut,
          ),
        ];

        Widget body;
        if (data.loading && data.me == null) {
          body = const Center(child: CircularProgressIndicator());
        } else if (data.error != null && data.me == null) {
          body = Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SelectableText('Failed to load: ${data.error}',
                  style: TextStyle(color: colors.destructive)),
            ),
          );
        } else {
          body = IndexedStack(index: _index, children: pages);
        }

        return FScaffold(
          header: _TopBar(
            title: active?.name ?? 'Schuly',
            subtitle: active?.fullName,
            pictureUrl: _pictureUrl,
            userName: _userName,
            onAvatar: _openSidebar,
          ),
          footer: SafeArea(
            top: false,
            // Keep the nav labels clear of the Android gesture/nav bar.
            child: FBottomNavigationBar(
              index: _index,
              onChange: (i) {
                if (i != _index) HapticFeedback.selectionClick();
                setState(() => _index = i);
              },
              children: const [
                FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home')),
                FBottomNavigationBarItem(icon: Icon(FIcons.calendarDays), label: Text('Timetable')),
                FBottomNavigationBarItem(icon: Icon(FIcons.chartColumn), label: Text('Grades')),
                FBottomNavigationBarItem(icon: Icon(FIcons.calendarOff), label: Text('Absences')),
                FBottomNavigationBarItem(icon: Icon(FIcons.user), label: Text('Account')),
              ],
            ),
          ),
          childPad: false,
          child: body,
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? pictureUrl;
  final String? userName;
  final VoidCallback onAvatar;
  const _TopBar({
    required this.title,
    required this.subtitle,
    required this.pictureUrl,
    required this.userName,
    required this.onAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final initial = (userName?.isNotEmpty ?? false) ? userName!.characters.first.toUpperCase() : '?';
    final fallback = Text(initial,
        style: TextStyle(color: colors.mutedForeground, fontWeight: FontWeight.w600));

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onAvatar,
                  child: (pictureUrl == null || pictureUrl!.isEmpty)
                      ? FAvatar.raw(size: 40, child: fallback)
                      : FAvatar(size: 40, image: NetworkImage(pictureUrl!), fallback: fallback),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title,
                          style: typography.lg.copyWith(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis),
                      if (subtitle?.isNotEmpty ?? false)
                        Text(subtitle!,
                            style: typography.sm.copyWith(color: colors.mutedForeground),
                            overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Default divider padding is vertical: 20 (huge gap); tighten it.
          FDivider(style: (s) => s.copyWith(padding: EdgeInsets.zero)),
        ],
      ),
    );
  }
}
