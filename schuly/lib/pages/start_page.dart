import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/lesson_tile.dart';
import '../widgets/holiday_tile.dart';
import '../widgets/grade_tile.dart';
import '../providers/api_store.dart';
import '../providers/homepage_config_provider.dart';
import '../pages/absenzen_page.dart';
import 'package:schuly/api/lib/api.dart';

class StartPage extends StatefulWidget {
  final VoidCallback? onNavigateToAbsenzen;

  const StartPage({super.key, this.onNavigateToAbsenzen});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer2<ApiStore, HomepageConfigProvider>(
      builder: (context, apiStore, homepageConfig, _) {
        // Show loading indicator if homepage config is not loaded yet
        if (!homepageConfig.isLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final agenda = apiStore.agenda;
        final grades = apiStore.grades;
        final absences = apiStore.absences;
        final sections = homepageConfig.sections;
        return RefreshIndicator(
          onRefresh: () async {
            await apiStore.fetchAll();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                for (final section in sections)
                  if (section.isVisible)
                    _buildSection(context, section.id, agenda, grades, absences, apiStore, widget.onNavigateToAbsenzen),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(BuildContext context, String sectionId, dynamic agenda, dynamic grades, dynamic absences, ApiStore apiStore, VoidCallback? onNavigateToAbsenzen) {
    switch (sectionId) {
      case 'lessons':
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nächste Lektionen',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedDay = _selectedDay.subtract(const Duration(days: 1));
                            });
                          },
                          icon: const Icon(Icons.chevron_left),
                          tooltip: 'Vorheriger Tag',
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedDay = _selectedDay.add(const Duration(days: 1));
                            });
                          },
                          icon: const Icon(Icons.chevron_right),
                          tooltip: 'Nächster Tag',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (agenda == null)
                  const Center(child: CircularProgressIndicator())
                else if (agenda.isEmpty)
                  const Center(child: Text('Keine Lektionen gefunden.'))
                else ...[
                  ...(() {
                    final lessons = agenda
                        .where((item) => item.eventType == 'Timetable')
                        .toList();
                    lessons.sort((a, b) {
                      final aStart = DateTime.tryParse(a.startDate) ?? DateTime.fromMillisecondsSinceEpoch(0);
                      final bStart = DateTime.tryParse(b.startDate) ?? DateTime.fromMillisecondsSinceEpoch(0);
                      return aStart.compareTo(bStart);
                    });
                    if (lessons.isEmpty) return <Widget>[const Center(child: Text('Keine Lektionen gefunden.'))];
                    final sameDayLessons = lessons.where((item) {
                      final start = DateTime.tryParse(item.startDate)?.toLocal();
                      return start != null &&
                          start.year == _selectedDay.year &&
                          start.month == _selectedDay.month &&
                          start.day == _selectedDay.day;
                    }).toList();
                    if (sameDayLessons.isEmpty) return <Widget>[Center(child: Text('Keine Lektionen für ${_selectedDay.day}.${_selectedDay.month}.${_selectedDay.year}'))];
                    return sameDayLessons.map<Widget>((item) {
                      final start = DateTime.tryParse(item.startDate);
                      final end = DateTime.tryParse(item.endDate);
                      final dayStr = start != null ?
                          '${_weekdayShort(start.weekday)} ${start.day.toString().padLeft(2, '0')}.${start.month.toString().padLeft(2, '0')}' :
                          '';
                      final timeStr = (start != null && end != null)
                          ? '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')} - '
                              '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}'
                          : '';
                      final subject = item.text;
                      final room = item.roomToken;
                      final teacher = item.teachers.isNotEmpty ? item.teachers.join(', ') : '';
                      return LessonTile(
                        day: dayStr,
                        time: timeStr,
                        subject: subject,
                        room: room,
                        teacher: teacher,
                      );
                    }).toList();
                  })(),
                ],
              ],
            ),
          ),
        );
      case 'holidays':
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nächste Ferien',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                if (agenda == null)
                  const Center(child: CircularProgressIndicator())
                else ...[
                  ...agenda
                      .where((item) => item.eventType.toLowerCase().contains('holiday') || item.eventType.toLowerCase().contains('ferien'))
                      .toList()
                      .map((item) {
                        final from = item.startDate.substring(0, 10).split('-').reversed.join('.');
                        final to = item.endDate.substring(0, 10).split('-').reversed.join('.');
                        return HolidayTile(
                          name: item.text,
                          from: from,
                          to: to,
                        );
                      }),
                  if (agenda.where((item) => item.eventType.toLowerCase().contains('holiday') || item.eventType.toLowerCase().contains('ferien')).isEmpty)
                    const Center(child: Text('Keine Ferien gefunden.')),
                ],
              ],
            ),
          ),
        );
      case 'grades':
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Letzte Noten',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                if (grades == null)
                  const Center(child: CircularProgressIndicator())
                else if (grades.isEmpty)
                  const Center(child: Text('Keine Noten gefunden.'))
                else ...[
                  ...(() {
                    final List<GradeDto> gradesList = grades.cast<GradeDto>().toList();
                    gradesList.sort((a, b) => b.date.compareTo(a.date));
                    return gradesList.take(3).map((gradeData) => GradeTile(
                      grade: gradeData,
                    ));
                  })(),
                ],
              ],
            ),
          ),
        );
      case 'absences':
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Offene Absenzen',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton.icon(
                      onPressed: widget.onNavigateToAbsenzen,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Alle anzeigen'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (absences == null)
                  const Center(child: CircularProgressIndicator())
                else ...[
                  ...(() {
                    final List absRaw = absences;
                    final List<AbsenceDto> absList = absRaw.map((a) {
                      if (a is AbsenceDto) return a;
                      try {
                        return AbsenceDto.fromJson(a as Map<String, dynamic>);
                      } catch (_) {
                        return null;
                      }
                    }).whereType<AbsenceDto>().toList();
                    final openStatuses = {'offen', 'open', 'ofage', 'unexcused', 'pending'};
                    final openAbsences = absList.where((absence) {
                      final status = absence.statusEAB;
                      return openStatuses.contains(status.toLowerCase());
                    }).toList();
                    if (openAbsences.isEmpty) {
                      if (absList.isEmpty) {
                        return [const Center(child: Text('Keine Absenzen gefunden.'))];
                      } else {
                        final fallbackAbsences = absList.take(3).map((absence) {
                          return CompactAbsenceItem(
                            absentFrom: _formatDateTime(absence.dateFrom, absence.hourFrom),
                            absentTo: _formatDateTime(absence.dateTo, absence.hourTo),
                            excuseUntil: _formatDateTime(absence.dateEAB, null),
                            status: absence.statusEAB,
                            reason: absence.reason,
                          );
                        }).toList();
                        return [
                          const Center(child: Text('Keine offenen Absenzen.')), ...fallbackAbsences
                        ];
                      }
                    }
                    return openAbsences.take(3).map((absence) {
                      return CompactAbsenceItem(
                        absentFrom: _formatDateTime(absence.dateFrom, absence.hourFrom),
                        absentTo: _formatDateTime(absence.dateTo, absence.hourTo),
                        excuseUntil: _formatDateTime(absence.dateEAB, null),
                        status: absence.statusEAB,
                        reason: absence.reason,
                      );
                    }).toList();
                  })(),
                ],
              ],
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  String _weekdayShort(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mo';
      case 2:
        return 'Di';
      case 3:
        return 'Mi';
      case 4:
        return 'Do';
      case 5:
        return 'Fr';
      case 6:
        return 'Sa';
      case 7:
        return 'So';
      default:
        return '';
    }
  }

  String _formatDateTime(String date, String? time) {
    if (date.isEmpty) return '';
    final datePart = date.length > 10 ? date.substring(0, 10) : date;
    final dateFormatted = datePart.split('-').reversed.join('.');
    if (time == null || time.isEmpty) {
      // Try to extract time from date if present
      if (date.length > 10) {
        final timePart = date.substring(11, 16);
        return '$dateFormatted $timePart';
      }
      return dateFormatted;
    }
    final timeShort = time.length >= 5 ? time.substring(0, 5) : time;
    return '$dateFormatted $timeShort';
  }
}
