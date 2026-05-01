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
      room: lesson.roomToken ?? '',
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
    final startTime = exam.startDate != null ? DateTime.tryParse(exam.startDate!) : null;
    final endTime = exam.endDate != null ? DateTime.tryParse(exam.endDate!) : null;

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
                    exam.courseName ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (exam.text != null && exam.text!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      exam.text!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 12,
                    runSpacing: 4,
                    children: [
                      if (exam.roomToken != null && exam.roomToken!.isNotEmpty)
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
                              exam.roomToken!,
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

  Widget _buildTimelineView(List<({String startTime, String endTime, String subject, String room, List<String> teachers, Color color, bool isTest, String? testNote})> dayItems) {
    if (dayItems.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.noAgendaForDay,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    // Sort items by start time
    dayItems.sort((a, b) => a.startTime.compareTo(b.startTime));

    // Build the timeline directly with actual lesson times
    return Column(
      children: dayItems.asMap().entries.map((entry) =>
        _buildLessonSlot(
          entry.value,
          entry.key == dayItems.length - 1
        )
      ).toList(),
    );
  }

  Widget _buildLessonSlot(({
    String startTime,
    String endTime,
    String subject,
    String room,
    List<String> teachers,
    Color color,
    bool isTest,
    String? testNote,
  }) item, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time column - showing actual start time
          Container(
            width: 70,
            padding: const EdgeInsets.only(top: 12, right: 8, left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.startTime,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.endTime,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          // Vertical line
          Container(
            width: 1,
            color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
          ),
          // Content area
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isLast ? Colors.transparent : Theme.of(context).dividerColor.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _buildCompactAgendaCard(item),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactAgendaCard(({
    String startTime,
    String endTime,
    String subject,
    String room,
    List<String> teachers,
    Color color,
    bool isTest,
    String? testNote,
  }) item) {
    final appColors = Theme.of(context).extension<AppColors>();
    final surfaceContainer = appColors?.surfaceContainer ??
        Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);

    return Container(
      decoration: BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.circular(6),
        border: Border(
          left: BorderSide(
            color: item.isTest ? Theme.of(context).colorScheme.error : item.color,
            width: 3,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject
            Text(
              item.subject,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (item.room.isNotEmpty || item.teachers.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                [
                  if (item.room.isNotEmpty) item.room,
                  if (item.teachers.isNotEmpty) item.teachers.join(', '),
                ].join(' • '),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 11,
                ),
              ),
            ],
            // Test note if present
            if (item.isTest && item.testNote != null) ...[
              const SizedBox(height: 4),
              Text(
                item.testNote!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
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
      final examDate = exam.startDate != null ? DateTime.tryParse(exam.startDate!) : null;
      if (examDate != null) {
        datesWithTests.add(DateTime(examDate.year, examDate.month, examDate.day));
      }
    }
    return datesWithTests;
  }


  Widget _buildListView(DateTime selectedDate, List<dynamic>? agenda, List<ExamDto>? exams, AppLocalizations localizations) {
    if (agenda == null && exams == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Filter items for selected date
    final List<({String startTime, String endTime, String subject, String room, List<String> teachers, Color color, bool isTest, String? testNote})> dayItems = [];

    // Add agenda items for selected date
    if (agenda != null) {
      for (final item in agenda) {
        final startDate = DateTime.tryParse(item.startDate);
        if (startDate != null &&
            startDate.year == selectedDate.year &&
            startDate.month == selectedDate.month &&
            startDate.day == selectedDate.day) {

          // Parse color
          Color itemColor = Theme.of(context).colorScheme.primary;
          if (item.color.isNotEmpty && item.color.startsWith('#')) {
            try {
              final hexColor = item.color.replaceFirst('#', '');
              itemColor = Color(int.parse('FF$hexColor', radix: 16));
            } catch (e) {
              // Keep default color if parsing fails
            }
          }

          final startTimeStr = (item.startDate ?? '').substring(11, 16);
          final endTimeStr = (item.endDate ?? '').substring(11, 16);
          final subjectStr = item.text ?? '';
          final roomStr = item.roomToken ?? '';
          final teachersList = item.teachers ?? <String>[];

          final ({String startTime, String endTime, String subject, String room, List<String> teachers, Color color, bool isTest, String? testNote}) listItem = (
            startTime: startTimeStr,
            endTime: endTimeStr,
            subject: subjectStr,
            room: roomStr,
            teachers: teachersList,
            color: itemColor,
            isTest: false,
            testNote: null as String?,
          );

          dayItems.add(listItem);
        }
      }
    }

    // Add exam items for selected date
    if (exams != null) {
      for (final exam in exams) {
        final examDate = exam.startDate != null ? DateTime.tryParse(exam.startDate!) : null;
        if (examDate != null &&
            examDate.year == selectedDate.year &&
            examDate.month == selectedDate.month &&
            examDate.day == selectedDate.day) {

          // Check if there's already a lesson at the same time
          final examStartTime = (exam.startDate ?? '').substring(11, 16);
          final examEndTime = (exam.endDate ?? '').substring(11, 16);

          bool foundMatch = false;
          for (int i = 0; i < dayItems.length; i++) {
            if (dayItems[i].startTime == examStartTime &&
                dayItems[i].endTime == examEndTime &&
                !dayItems[i].isTest) {
              // Update existing item to show it has a test
              final updatedRoom = (exam.roomToken != null && exam.roomToken!.isNotEmpty) ? exam.roomToken! : dayItems[i].room;
              dayItems[i] = (
                startTime: dayItems[i].startTime,
                endTime: dayItems[i].endTime,
                subject: dayItems[i].subject,
                room: updatedRoom,
                teachers: dayItems[i].teachers,
                color: dayItems[i].color,
                isTest: true,
                testNote: 'Test: ${exam.text}',
              );
              foundMatch = true;
              break;
            }
          }

          if (!foundMatch) {
            // Add as standalone test
            final testStartTime = examStartTime;
            final testEndTime = examEndTime;
            final testSubject = exam.courseName ?? '';
            final testRoom = exam.roomToken ?? '';

            final testItem = (
              startTime: testStartTime,
              endTime: testEndTime,
              subject: testSubject,
              room: testRoom,
              teachers: const <String>[],
              color: Theme.of(context).colorScheme.error,
              isTest: true,
              testNote: 'Test: ${exam.text}' as String?,
            );
            dayItems.add(testItem);
          }
        }
      }
    }

    // Sort items by start time
    dayItems.sort((a, b) => a.startTime.compareTo(b.startTime));

    if (dayItems.isEmpty) {
      return _buildTimelineView(dayItems);
    }

    // Build the timeline view for single day
    return _buildTimelineView(dayItems);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Consumer<ApiStore>(
      builder: (context, apiStore, _) {
        final agenda = apiStore.agenda;
        final exams = apiStore.exams;
        final isListView = apiStore.isAgendaListView;

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
                // Calendar always visible at the top
                Card(
                  margin: const EdgeInsets.only(bottom: 16),
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
                // Bottom section - toggleable between card view and timeline view
                if (!isListView) ...[
                  // Traditional Card View
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
                                final start = a.startDate != null ? DateTime.tryParse(a.startDate!) : null;
                                return start != null &&
                                  start.year == _selectedDay.year &&
                                  start.month == _selectedDay.month &&
                                  start.day == _selectedDay.day;
                              }).toList() ?? [];

                              // Get today's exams
                              final todayExams = exams?.where((exam) {
                                final examDate = exam.startDate != null ? DateTime.tryParse(exam.startDate!) : null;
                                return examDate != null &&
                                  examDate.year == _selectedDay.year &&
                                  examDate.month == _selectedDay.month &&
                                  examDate.day == _selectedDay.day;
                              }).toList() ?? [];

                              // Create a map to group items by time
                              final Map<String, ({dynamic lesson, List<ExamDto> exams})> timeGroups = {};

                              // Add lessons to the map
                              for (final item in todayAgenda) {
                                final timeKey = '${(item.startDate ?? '').substring(11, 16)}-${(item.endDate ?? '').substring(11, 16)}';
                                timeGroups[timeKey] = (lesson: item, exams: []);
                              }

                              // Add exams to matching lessons or create new entries
                              for (final exam in todayExams) {
                                final examTimeKey = '${(exam.startDate ?? '').substring(11, 16)}-${(exam.endDate ?? '').substring(11, 16)}';

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
                ] else ...[
                  // Timeline List View
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            localizations.agendaForDate(_selectedDay.day, _selectedDay.month, _selectedDay.year),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          if (agenda == null && exams == null)
                            const Center(child: CircularProgressIndicator())
                          else
                            _buildListView(_selectedDay, agenda, exams, localizations),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

// TODO: Add agendaForDate (with params), noAgendaForDay to ARB files