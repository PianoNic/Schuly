import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../l10n/app_localizations.dart';
import '../../absences/widgets/absences_screen.dart';
import '../../account/widgets/account_screen.dart';
import '../../agenda/widgets/agenda_screen.dart';
import '../../grades/widgets/grades_screen.dart';
import '../../home/widgets/home_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final _controller = PlatformTabController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final cupertino = isCupertino(context);

    BottomNavigationBarItem item(IconData material, IconData cupertinoIcon, String label) {
      return BottomNavigationBarItem(
        icon: Icon(cupertino ? cupertinoIcon : material),
        label: label,
      );
    }

    return PlatformTabScaffold(
      tabController: _controller,
      items: [
        item(Icons.home_outlined, CupertinoIcons.house, t.tabStart),
        item(Icons.calendar_today_outlined, CupertinoIcons.calendar, t.tabAgenda),
        item(Icons.grade_outlined, CupertinoIcons.star, t.tabGrades),
        item(Icons.event_busy_outlined, CupertinoIcons.calendar_badge_minus, t.tabAbsences),
        item(Icons.person_outline, CupertinoIcons.person, t.tabAccount),
      ],
      bodyBuilder: (context, index) => switch (index) {
        0 => const HomeScreen(),
        1 => const AgendaScreen(),
        2 => const GradesScreen(),
        3 => const AbsencesScreen(),
        _ => const AccountScreen(),
      },
    );
  }
}
