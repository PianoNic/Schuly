import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../services/school_data_service.dart';

/// Timetable: a horizontal day strip (FLineCalendar) and the selected day's
/// agenda entries, colour-coded by type.
class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  DateTime? _selected; // null until the user picks or we auto-anchor
  bool _userPicked = false;

  @override
  void initState() {
    super.initState();
    SchoolDataService.instance.addListener(_autoAnchor);
    _autoAnchor();
  }

  @override
  void dispose() {
    SchoolDataService.instance.removeListener(_autoAnchor);
    super.dispose();
  }

  /// Once agenda data is available (it loads after this page mounts), anchor
  /// the calendar on the nearest day with entries — unless the user already
  /// picked a day.
  void _autoAnchor() {
    if (_userPicked || _selected != null) return;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = _nearestEntryDay(SchoolDataService.instance.agenda, today);
    if (day != null && mounted) setState(() => _selected = day);
  }

  static DateTime? _nearestEntryDay(List<dynamic> agenda, DateTime today) {
    final days = <DateTime>{
      for (final a in agenda) DateTime(a.date.year, a.date.month, a.date.day),
    }.toList()
      ..sort();
    if (days.isEmpty) return null;
    for (final d in days) {
      if (!d.isBefore(today)) return d; // soonest upcoming (incl. today)
    }
    return days.last; // everything is in the past → most recent
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final svc = SchoolDataService.instance;
    final now = DateTime.now();
    final selected = _selected ?? DateTime(now.year, now.month, now.day);

    bool sameDay(DateTime d) =>
        d.year == selected.year && d.month == selected.month && d.day == selected.day;

    final entries = svc.agenda.where((a) => sameDay(a.date)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FLineCalendar(
            // Remount once when the anchor is first set, so initialScroll
            // jumps the strip to the day with data.
            key: ValueKey(_selected != null),
            start: DateTime(now.year - 1),
            end: DateTime(now.year + 2),
            today: now,
            initialScroll: selected,
            control: FLineCalendarControl.lifted(
              date: selected,
              onChange: (d) {
                if (d != null) {
                  setState(() {
                    _userPicked = true;
                    _selected = d;
                  });
                }
              },
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: svc.refresh,
            child: entries.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 320,
                        child: Center(
                          child: Text('Nothing scheduled',
                              style: TextStyle(color: colors.mutedForeground)),
                        ),
                      ),
                    ],
                  )
                : ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    children: [
                      for (final e in entries)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _EntryTile(entry: e),
                        ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

class _EntryTile extends StatelessWidget {
  final AgendaEntryDto entry;
  const _EntryTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = _typeMeta(context, entry.entryType);
    final time = _timeRange(entry.date);
    return FTile(
      prefix: Icon(icon, color: color),
      title: Text(entry.title?.isNotEmpty == true ? entry.title! : label),
      subtitle: Text([time, entry.place].whereType<String>().where((s) => s.isNotEmpty).join(' · ')),
      suffix: _TypeBadge(label: label, color: color),
    );
  }

  static String _timeRange(DateTime d) {
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  static (String, Color, IconData) _typeMeta(BuildContext context, AgendaEntryType? t) {
    final colors = context.theme.colors;
    switch (t) {
      case AgendaEntryType.test:
        return ('Test', const Color(0xFFEF4444), FIcons.clipboardList);
      case AgendaEntryType.event:
        return ('Event', const Color(0xFF22C55E), FIcons.calendarHeart);
      case AgendaEntryType.holiday:
        return ('Holiday', const Color(0xFFF59E0B), FIcons.treePalm);
      case AgendaEntryType.lesson:
      default:
        return ('Lesson', colors.primary, FIcons.bookOpen);
    }
  }
}

class _TypeBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _TypeBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12)),
      );
}
