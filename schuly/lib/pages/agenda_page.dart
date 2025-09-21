import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/agenda_item.dart';
import '../widgets/custom_calendar.dart';
import '../providers/api_store.dart';
import '../l10n/app_localizations.dart';
import 'package:schuly/api/lib/api.dart';
import '../providers/theme_provider.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  DateTime _selectedDay = DateTime.now();

  Widget _buildAgendaItemWithTest({
    required dynamic lesson,
    required List<ExamDto> exams,
    required Color color,
  }) {
    final hasTest = exams.isNotEmpty;

    return AgendaItemWithTest(
      time: '${lesson.startDate.substring(11, 16)} - ${lesson.endDate.substring(11, 16)}',
      subject: lesson.text,
      room: lesson.roomToken,
      teachers: lesson.teachers,
      color: color,
      hasTest: hasTest,
      testCourse: hasTest ? exams.first.courseName : null,
      testContent: hasTest ? exams.first.text : null,
    );
  }

  Widget _buildTestCard(ExamDto exam) {
    final appColors = Theme.of(context).extension<AppColors>();
    final surfaceContainer = appColors?.surfaceContainer ??
        Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);
    final localizations = AppLocalizations.of(context)!;

    // Parse time
    final startTime = DateTime.tryParse(exam.startDate);
    final endTime = DateTime.tryParse(exam.endDate);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 4,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Test label and time display - stacked like agenda items
            if (startTime != null && endTime != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.test.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${localizations.from.toLowerCase()}: ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${localizations.to.toLowerCase()}: ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            if (startTime != null && endTime != null) const SizedBox(width: 12),
            // Test details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam.courseName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (exam.text.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      exam.text,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 12,
                    runSpacing: 4,
                    children: [
                      if (exam.roomToken.isNotEmpty)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.room,
                              size: 14,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              exam.roomToken,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Set<DateTime> _getDatesWithEvents(List<dynamic>? agenda) {
    if (agenda == null) return {};

    final datesWithEvents = <DateTime>{};
    for (final item in agenda) {
      final start = DateTime.tryParse(item.startDate);
      if (start != null) {
        datesWithEvents.add(DateTime(start.year, start.month, start.day));
      }
    }
    return datesWithEvents;
  }

  Set<DateTime> _getDatesWithTests(List<ExamDto>? exams) {
    if (exams == null) return {};

    final datesWithTests = <DateTime>{};
    for (final exam in exams) {
      final examDate = DateTime.tryParse(exam.startDate);
      if (examDate != null) {
        datesWithTests.add(DateTime(examDate.year, examDate.month, examDate.day));
      }
    }
    return datesWithTests;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Consumer<ApiStore>(
      builder: (context, apiStore, _) {
        final agenda = apiStore.agenda;
        final exams = apiStore.exams;
        return RefreshIndicator(
          onRefresh: () async {
            await apiStore.fetchAgenda(forceRefresh: true);
            await apiStore.fetchExams(forceRefresh: true);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: CustomCalendar(
                    selectedDate: _selectedDay,
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    datesWithEvents: _getDatesWithEvents(agenda),
                    datesWithTests: _getDatesWithTests(exams),
                    onDateChanged: (date) {
                      setState(() {
                        _selectedDay = date;
                      });
                    },
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          localizations.agendaForDate(_selectedDay.day, _selectedDay.month, _selectedDay.year), // TODO: Add agendaForDate to ARB
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        if (agenda == null && exams == null)
                          const Center(child: CircularProgressIndicator())
                        else ...[
                          // Combine and sort agenda items and exams for selected day
                          ...() {
                            final List<Widget> dayItems = [];

                            // Get today's agenda items
                            final todayAgenda = agenda?.where((a) {
                              final start = DateTime.tryParse(a.startDate);
                              return start != null &&
                                start.year == _selectedDay.year &&
                                start.month == _selectedDay.month &&
                                start.day == _selectedDay.day;
                            }).toList() ?? [];

                            // Get today's exams
                            final todayExams = exams?.where((exam) {
                              final examDate = DateTime.tryParse(exam.startDate);
                              return examDate != null &&
                                examDate.year == _selectedDay.year &&
                                examDate.month == _selectedDay.month &&
                                examDate.day == _selectedDay.day;
                            }).toList() ?? [];

                            // Create a map to group items by time
                            final Map<String, ({dynamic lesson, List<ExamDto> exams})> timeGroups = {};

                            // Add lessons to the map
                            for (final item in todayAgenda) {
                              final timeKey = '${item.startDate.substring(11, 16)}-${item.endDate.substring(11, 16)}';
                              timeGroups[timeKey] = (lesson: item, exams: []);
                            }

                            // Add exams to matching lessons or create new entries
                            for (final exam in todayExams) {
                              final examTimeKey = '${exam.startDate.substring(11, 16)}-${exam.endDate.substring(11, 16)}';

                              // Check if there's a lesson at the same time
                              if (timeGroups.containsKey(examTimeKey)) {
                                timeGroups[examTimeKey]!.exams.add(exam);
                              } else {
                                // No matching lesson, add as standalone
                                timeGroups[examTimeKey] = (lesson: null, exams: [exam]);
                              }
                            }

                            // Sort entries by start time
                            final sortedEntries = timeGroups.entries.toList()
                              ..sort((a, b) {
                                final aTime = a.key.substring(0, 5);
                                final bTime = b.key.substring(0, 5);
                                return aTime.compareTo(bTime);
                              });

                            // Build widgets for each time group
                            for (final entry in sortedEntries) {
                              final timeSlot = entry.value;

                              if (timeSlot.lesson != null) {
                                // Parse hex color string to Color
                                Color itemColor = Theme.of(context).colorScheme.primary;
                                if (timeSlot.lesson.color.isNotEmpty && timeSlot.lesson.color.startsWith('#')) {
                                  try {
                                    final hexColor = timeSlot.lesson.color.replaceFirst('#', '');
                                    itemColor = Color(int.parse('FF$hexColor', radix: 16));
                                  } catch (e) {
                                    // Keep default color if parsing fails
                                  }
                                }

                                // Create agenda item with embedded test info
                                dayItems.add(_buildAgendaItemWithTest(
                                  lesson: timeSlot.lesson,
                                  exams: timeSlot.exams,
                                  color: itemColor,
                                ));
                              } else {
                                // Standalone test(s)
                                for (final exam in timeSlot.exams) {
                                  dayItems.add(_buildTestCard(exam));
                                }
                              }
                            }

                            if (dayItems.isEmpty) {
                              return [Center(child: Text(localizations.noAgendaForDay))];
                            }

                            return dayItems;
                          }(),
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
}

// TODO: Add agendaForDate (with params), noAgendaForDay to ARB files