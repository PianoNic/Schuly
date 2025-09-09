import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/lesson_tile.dart';
import '../widgets/holiday_tile.dart';
import '../widgets/grade_tile.dart';
import '../providers/api_store.dart';
import '../pages/absenzen_page.dart';
import 'package:schuly/api/lib/api.dart';

class StartPage extends StatelessWidget {
  final VoidCallback? onNavigateToAbsenzen;

  const StartPage({super.key, this.onNavigateToAbsenzen});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiStore>(
      builder: (context, apiStore, _) {
        final agenda = apiStore.agenda;
        return RefreshIndicator(
          onRefresh: () async {
            await apiStore.fetchAll();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nächste Lektionen',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        if (agenda == null)
                          const Center(child: CircularProgressIndicator())
                        else if (agenda.isEmpty)
                          const Center(child: Text('Keine Lektionen gefunden.'))
                        else ...[
                          ...(() {
                            final now = DateTime.now();
                            final lessons = agenda
                              .where((item) => (item.eventType == 'Timetable') && DateTime.tryParse(item.startDate)?.isAfter(now) == true)
                              .toList();
                            lessons.sort((a, b) {
                              final aStart = DateTime.tryParse(a.startDate) ?? DateTime.fromMillisecondsSinceEpoch(0);
                              final bStart = DateTime.tryParse(b.startDate) ?? DateTime.fromMillisecondsSinceEpoch(0);
                              return aStart.compareTo(bStart);
                            });
                            if (lessons.isEmpty) return <Widget>[const Center(child: Text('Keine Lektionen gefunden.'))];
                            final nextDay = DateTime.tryParse(lessons.first.startDate)?.toLocal();
                            if (nextDay == null) return <Widget>[const Center(child: Text('Keine Lektionen gefunden.'))];
                            final sameDayLessons = lessons.where((item) {
                              final start = DateTime.tryParse(item.startDate)?.toLocal();
                              return start != null &&
                                start.year == nextDay.year &&
                                start.month == nextDay.month &&
                                start.day == nextDay.day;
                            }).toList();
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
                ),
                const SizedBox(height: 16),

                // Holidays
                Card(
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
                          // Filter for holidays (eventType == 'holiday' or similar)
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
                ),
                const SizedBox(height: 16),

                // Last Submitted Notes
                Card(
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
                        if (apiStore.grades == null)
                          const Center(child: CircularProgressIndicator())
                        else if (apiStore.grades!.isEmpty)
                          const Center(child: Text('Keine Noten gefunden.'))
                        else ...[
                          ...(() {
                            final grades = apiStore.grades!.toList();
                            grades.sort((a, b) => b.date.compareTo(a.date));
                            return grades.take(3).map((grade) => GradeTile(
                              subject: grade.title,
                              grade: grade.mark,
                              date: grade.date,
                              confirmed: grade.isConfirmed,
                            ));
                          })(),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Fixed Offene Absenzen section
                Card(
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
                              onPressed: onNavigateToAbsenzen,
                              icon: const Icon(Icons.arrow_forward),
                              label: const Text('Alle anzeigen'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (apiStore.absences == null)
                          const Center(child: CircularProgressIndicator())
                        else ...[
                          ...(() {
                            // Accept both Map and AbsenceDto, robust to all shapes
                            final List absRaw = apiStore.absences!;
                            final List<AbsenceDto> absences = absRaw.map((a) {
                              if (a is AbsenceDto) return a;
                              try {
                                return AbsenceDto.fromJson(a as Map<String, dynamic>);
                              } catch (_) {
                                return null;
                              }
                            }).whereType<AbsenceDto>().toList();

                            // Define what counts as "open" (robust to status variants)
                            final openStatuses = {'offen', 'open', 'ofage', 'unexcused', 'pending'};
                            final openAbsences = absences.where((absence) {
                              final status = absence.statusEAB;
                              return openStatuses.contains(status.toLowerCase());
                            }).toList();

                            if (openAbsences.isEmpty) {
                              if (absences.isEmpty) {
                                return [const Center(child: Text('Keine Absenzen gefunden.'))];
                              } else {
                                // Show up to 3 most recent absences with any status
                                final fallbackAbsences = absences.take(3).map((absence) {
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
                            // Show up to 3 open absences
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
                ),
              ],
            ),
          ),
        );
      },
    );
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
