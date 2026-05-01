import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../l10n/app_localizations.dart';
import '../../absences/widgets/absences_screen.dart';
import '../../account/widgets/account_screen.dart';
import '../../agenda/widgets/agenda_screen.dart';
import '../../grades/widgets/grades_screen.dart';
import '../../home/widgets/home_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return PlatformTabScaffold(
      items: [
        BottomNavigationBarItem(icon: const Icon(Icons.home_outlined), label: t.tabStart),
        BottomNavigationBarItem(icon: const Icon(Icons.calendar_today_outlined), label: t.tabAgenda),
        BottomNavigationBarItem(icon: const Icon(Icons.grade_outlined), label: t.tabGrades),
        BottomNavigationBarItem(icon: const Icon(Icons.event_busy_outlined), label: t.tabAbsences),
        BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: t.tabAccount),
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
