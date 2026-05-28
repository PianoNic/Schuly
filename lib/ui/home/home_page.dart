import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../services/school_data_service.dart';
import '../core/grade_color.dart';

/// Glanceable dashboard: today's lessons, upcoming tests, latest grades, and
/// recent absences. Reads everything from [SchoolDataService].
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final svc = SchoolDataService.instance;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    bool sameDay(DateTime d) => d.year == today.year && d.month == today.month && d.day == today.day;

    final todayLessons = svc.agenda
        .where((a) => a.entryType == AgendaEntryType.lesson && sameDay(a.date))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    final upcomingTests = svc.agenda.where((a) {
      final d = a.date;
      return a.entryType == AgendaEntryType.test &&
          !d.isBefore(today) &&
          d.isBefore(today.add(const Duration(days: 7)));
    }).toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    final myGrades = svc.myGradesByExam;
    final examName = {for (final e in svc.exams) e.id: e.name};
    final recentGrades = myGrades.entries.toList().reversed.take(5).toList();

    final recentAbsences = svc.absences.toList()
      ..sort((a, b) => b.from.compareTo(a.from));

    return RefreshIndicator(
      onRefresh: svc.refresh,
      child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        _Section(
          title: 'Today',
          emptyText: 'No lessons today',
          tiles: [
            for (final l in todayLessons)
              FTile(
                prefix: const Icon(FIcons.bookOpen),
                title: Text(l.title ?? 'Lesson'),
                subtitle: Text([_time(l.date), l.place].whereType<String>().join(' · ')),
              ),
          ],
        ),
        const SizedBox(height: 16),
        _Section(
          title: 'Upcoming tests',
          emptyText: 'Nothing in the next 7 days',
          tiles: [
            for (final t in upcomingTests)
              FTile(
                prefix: const Icon(FIcons.clipboardList),
                title: Text(t.title ?? 'Test'),
                subtitle: Text(_dateLabel(t.date)),
              ),
          ],
        ),
        const SizedBox(height: 16),
        _Section(
          title: 'Latest grades',
          emptyText: 'No grades yet',
          tiles: [
            for (final entry in recentGrades)
              FTile(
                title: Text(examName[entry.key] ?? 'Exam'),
                suffix: _GradePill(entry.value.score ?? 0),
              ),
          ],
        ),
        const SizedBox(height: 16),
        _Section(
          title: 'Recent absences',
          emptyText: 'No absences',
          tiles: [
            for (final a in recentAbsences.take(4))
              FTile(
                prefix: const Icon(FIcons.calendarOff),
                title: Text(a.reason?.isNotEmpty == true ? a.reason! : 'Absence'),
                subtitle: Text(_rangeLabel(a.from, a.until)),
              ),
          ],
        ),
      ],
      ),
    );
  }

  static String _time(DateTime d) {
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  static String _dateLabel(DateTime d) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${days[d.weekday - 1]} ${d.day}.${d.month}.';
  }

  static String _rangeLabel(DateTime from, DateTime? until) {
    final f = _dateLabel(from);
    if (until == null || until.difference(from).inDays.abs() < 1) return f;
    return '$f – ${_dateLabel(until)}';
  }
}

/// A plain section: a header label followed by spaced tiles — matching the
/// Grades page (no enclosing card; the tiles carry their own borders).
class _Section extends StatelessWidget {
  final String title;
  final List<Widget> tiles;
  final String emptyText;
  const _Section({required this.title, required this.tiles, required this.emptyText});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
          child: Text(title, style: typography.base.copyWith(fontWeight: FontWeight.w600)),
        ),
        if (tiles.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: Text(emptyText, style: TextStyle(color: colors.mutedForeground)),
          )
        else
          for (final t in tiles)
            Padding(padding: const EdgeInsets.only(bottom: 8), child: t),
      ],
    );
  }
}

class _GradePill extends StatelessWidget {
  final num score;
  const _GradePill(this.score);
  @override
  Widget build(BuildContext context) {
    final c = gradeColor(context, score);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: c.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(8)),
      child: Text(formatGrade(score), style: TextStyle(color: c, fontWeight: FontWeight.w700)),
    );
  }
}
