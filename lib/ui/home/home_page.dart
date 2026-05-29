import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

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
    DateTime dayOf(DateTime d) => DateTime(d.year, d.month, d.day);

    final todayEntries = svc.agenda.where((a) => sameDay(a.date)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    final upcoming = svc.agenda.where((a) => dayOf(a.date).isAfter(today)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    final myGrades = svc.myGradesByExam;
    final examName = {for (final e in svc.exams) e.id: e.name};
    // Only real grades on the latest-grades card (drop ungraded 0 placeholders).
    final recentGrades = myGrades.entries
        .where((e) => isGraded(e.value.score))
        .toList()
        .reversed
        .take(5)
        .toList();

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
          emptyText: 'Nothing scheduled today',
          tiles: [
            for (final l in todayEntries)
              FTile(
                prefix: const Icon(FIcons.calendarDays),
                title: Text(l.title?.isNotEmpty == true ? l.title! : 'Entry'),
                subtitle: Text([_time(l.date), l.place].whereType<String>().where((s) => s.isNotEmpty).join(' · ')),
              ),
          ],
        ),
        const SizedBox(height: 16),
        _Section(
          title: 'Upcoming',
          emptyText: 'Nothing upcoming',
          tiles: [
            for (final t in upcoming.take(5))
              FTile(
                prefix: const Icon(FIcons.calendarDays),
                title: Text(t.title?.isNotEmpty == true ? t.title! : 'Entry'),
                subtitle: Text('${_dateLabel(t.date)} · ${_time(t.date)}'),
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
                suffix: GradePill(entry.value.score),
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
