import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/lesson_tile.dart';
import '../widgets/holiday_tile.dart';
import '../widgets/break_card.dart';
import '../widgets/grade_tile.dart';
import '../providers/api_store.dart';
import '../providers/homepage_config_provider.dart';
import '../providers/theme_provider.dart';
import '../pages/absences_page.dart';
import 'package:schuly/api/lib/api.dart';
import '../l10n/app_localizations.dart';

class StartPage extends StatefulWidget {
  final VoidCallback? onNavigateToAbsenzen;

  const StartPage({super.key, this.onNavigateToAbsenzen});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  DateTime _selectedDay = DateTime.now();
  bool _hasInitializedSelectedDay = false;
  final PageController _pageController = PageController();
  List<DateTime> _availableDates = [];

  List<DateTime> _getAvailableDates(List<dynamic> agenda) {
    final lessons = agenda
        .where((item) => item.eventType == 'Timetable')
        .toList();

    final availableDates = <DateTime>[];
    final seenDates = <String>{};

    for (final lesson in lessons) {
      final start = DateTime.tryParse(lesson.startDate)?.toLocal();
      if (start != null) {
        final dateKey = '${start.year}-${start.month}-${start.day}';
        if (!seenDates.contains(dateKey)) {
          seenDates.add(dateKey);
          availableDates.add(DateTime(start.year, start.month, start.day));
        }
      }
    }

    availableDates.sort();
    return availableDates;
  }

  double _calculateOptimalHeight(List<dynamic> agenda, List<DateTime> availableDates) {
    int maxLessonsPerDay = 0;

    for (final date in availableDates) {
      final lessonsForDate = agenda
          .where((item) => item.eventType == 'Timetable')
          .where((item) {
            final start = DateTime.tryParse(item.startDate)?.toLocal();
            return start != null &&
                start.year == date.year &&
                start.month == date.month &&
                start.day == date.day;
          }).length;

      if (lessonsForDate > maxLessonsPerDay) {
        maxLessonsPerDay = lessonsForDate;
      }
    }

    // Calculate height: each lesson tile is approximately 64px + 8px margin
    const double lessonTileHeight = 72.0; // More accurate estimate
    const double minHeight = 150.0; // Minimum height

    double calculatedHeight = (maxLessonsPerDay * lessonTileHeight);
    return calculatedHeight > minHeight ? calculatedHeight : minHeight;
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
        final exams = apiStore.exams;
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
                    _buildSection(context, section.id, agenda, grades, absences, exams, apiStore, widget.onNavigateToAbsenzen, homepageConfig),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(BuildContext context, String sectionId, dynamic agenda, dynamic grades, dynamic absences, dynamic exams, ApiStore apiStore, VoidCallback? onNavigateToAbsenzen, HomepageConfigProvider homepageConfig) {
    final localizations = AppLocalizations.of(context)!;
    switch (sectionId) {
      case 'lessons':
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizations.nextLessons,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                              '${_weekdayShort(_selectedDay.weekday)}, ${_selectedDay.day}. ${_getMonthShort(_selectedDay.month)} ${_selectedDay.year}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Home icon - disabled when on the next school day
                    if (_availableDates.isNotEmpty)
                      (() {
                        final today = DateTime.now();
                        final todayDate = DateTime(today.year, today.month, today.day);

                        // Find the next school day (today or later)
                        DateTime? nextSchoolDay;
                        int nextSchoolDayIndex = 0;
                        for (int i = 0; i < _availableDates.length; i++) {
                          if (!_availableDates[i].isBefore(todayDate)) {
                            nextSchoolDay = _availableDates[i];
                            nextSchoolDayIndex = i;
                            break;
                          }
                        }

                        // If no future dates, use the last available date
                        if (nextSchoolDay == null && _availableDates.isNotEmpty) {
                          nextSchoolDay = _availableDates.last;
                          nextSchoolDayIndex = _availableDates.length - 1;
                        }

                        // Check if current selected day is the next school day
                        final isOnNextSchoolDay = nextSchoolDay != null &&
                            _selectedDay.year == nextSchoolDay.year &&
                            _selectedDay.month == nextSchoolDay.month &&
                            _selectedDay.day == nextSchoolDay.day;

                        return IconButton(
                          onPressed: isOnNextSchoolDay ? null : () {
                            _pageController.animateToPage(
                              nextSchoolDayIndex,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          icon: const Icon(Icons.home),
                          tooltip: localizations.today,
                        );
                      })(),
                  ],
                ),
                const SizedBox(height: 12),
                if (agenda == null)
                  const Center(child: CircularProgressIndicator())
                else if (agenda.isEmpty)
                  Center(child: Text(localizations.noLessonsFound))
                else ...[
                  (() {
                    // Initialize available dates and page controller
                    if (!_hasInitializedSelectedDay && agenda.isNotEmpty) {
                      _availableDates = _getAvailableDates(agenda);
                      if (_availableDates.isNotEmpty) {
                          // Find the first date that is today or in the future
                          final today = DateTime.now();
                          final todayDate = DateTime(today.year, today.month, today.day);

                          DateTime? bestDate;
                          int bestIndex = 0;
                          for (int i = 0; i < _availableDates.length; i++) {
                            if (!_availableDates[i].isBefore(todayDate)) {
                              bestDate = _availableDates[i];
                              bestIndex = i;
                              break;
                            }
                          }

                          // If no future dates, use the last available date
                          if (bestDate == null && _availableDates.isNotEmpty) {
                            bestDate = _availableDates.last;
                            bestIndex = _availableDates.length - 1;
                          }

                          if (bestDate != null) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) {
                                setState(() {
                                  _selectedDay = bestDate!;
                                  _hasInitializedSelectedDay = true;
                                });
                                // Jump to the page after the widget is built
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  if (_pageController.hasClients) {
                                    _pageController.jumpToPage(bestIndex);
                                  }
                                });
                              }
                            });
                          } else {
                            _hasInitializedSelectedDay = true;
                          }
                        } else {
                          _hasInitializedSelectedDay = true;
                        }
                      }

                    if (_availableDates.isEmpty) {
                      return Center(child: Text(localizations.noLessonsFound));
                    }

                    // Calculate optimal height based on the day with most lessons
                    final optimalHeight = _calculateOptimalHeight(agenda, _availableDates);

                    return SizedBox(
                      height: optimalHeight,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _availableDates.length,
                        padEnds: false,
                        onPageChanged: (index) {
                          setState(() {
                            _selectedDay = _availableDates[index];
                          });
                        },
                        itemBuilder: (context, index) {
                          final selectedDate = _availableDates[index];
                          final lessons = agenda
                              .where((item) => item.eventType == 'Timetable')
                              .toList();

                          final sameDayLessons = lessons.where((item) {
                            final start = DateTime.tryParse(item.startDate)?.toLocal();
                            return start != null &&
                                start.year == selectedDate.year &&
                                start.month == selectedDate.month &&
                                start.day == selectedDate.day;
                          }).toList();

                          sameDayLessons.sort((a, b) {
                            final aStart = DateTime.tryParse(a.startDate) ?? DateTime.fromMillisecondsSinceEpoch(0);
                            final bStart = DateTime.tryParse(b.startDate) ?? DateTime.fromMillisecondsSinceEpoch(0);
                            return aStart.compareTo(bStart);
                          });

                          if (sameDayLessons.isEmpty) {
                            return Center(
                              child: Text(localizations.noLessonsForDay(selectedDate.day, selectedDate.month, selectedDate.year))
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ListView(
                              children: _buildLessonsWithBreaks(sameDayLessons, homepageConfig.showBreaks),
                            ),
                          );
                        },
                      ),
                    );
                  })(),
                ],
              ],
            ),
          ),
        );
      case 'holidays':
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.nextHolidays,
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
                    Center(child: Text(localizations.noHolidaysFound)),
                ],
              ],
            ),
          ),
        );
      case 'grades':
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.latestGrades,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                if (grades == null)
                  const Center(child: CircularProgressIndicator())
                else if (grades.isEmpty)
                  Center(child: Text(localizations.noGradesFound))
                else ...[
                  ...(() {
                    final List<GradeDto> gradesList = grades.cast<GradeDto>().toList();
                    gradesList.sort((a, b) => (b.date ?? '').compareTo(a.date ?? ''));
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
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.unexcusedAbsences,
                  style: Theme.of(context).textTheme.titleLarge,
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
                    // Filter for unexcused absences only
                    final unexcusedAbsences = absList.where((absence) {
                      return !(absence.isExcused ?? false);
                    }).toList();
                    if (unexcusedAbsences.isEmpty) {
                      if (absList.isEmpty) {
                        return [Center(child: Text(localizations.noAbsencesFound))];
                      } else {
                        // Don't show any absences if all are excused
                        return [Center(child: Text(localizations.noOpenAbsences))];
                      }
                    }
                    return unexcusedAbsences.take(3).map((absence) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to absences page and pass the absence ID
                          if (widget.onNavigateToAbsenzen != null) {
                            // Store the selected absence ID in ApiStore for retrieval
                            apiStore.setSelectedAbsenceId(absence.id);
                            widget.onNavigateToAbsenzen!();
                          }
                        },
                        child: CompactAbsenceItem(
                          absence: absence,
                          absentFrom: _formatDateTime(absence.dateFrom ?? '', absence.hourFrom),
                          absentTo: _formatDateTime(absence.dateTo ?? '', absence.hourTo),
                          excuseUntil: absence.dateEAB != null ? _formatDateTime(absence.dateEAB ?? '', null) : '',
                          status: absence.statusEAB ?? '',
                          reason: absence.reason ?? '',
                          relatedNotices: [], // No notices needed on start page
                          localizations: localizations,
                        ),
                      );
                    }).toList();
                  })(),
                ],
              ],
            ),
          ),
        );
      case 'tests':
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.upcomingTests,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                if (exams == null)
                  const Center(child: CircularProgressIndicator())
                else if (exams.isEmpty)
                  Center(child: Text(localizations.noTestsFound))
                else ...[
                  ...(() {
                    final List<ExamDto> examsList = exams.cast<ExamDto>().toList();
                    // Filter for upcoming exams only
                    final now = DateTime.now();
                    final upcomingExams = examsList.where((exam) {
                      final examDate = exam.startDate != null ? DateTime.tryParse(exam.startDate!) : null;
                      return examDate != null && examDate.isAfter(now);
                    }).toList();

                    // Sort by date
                    upcomingExams.sort((a, b) => (a.startDate ?? '').compareTo(b.startDate ?? ''));

                    if (upcomingExams.isEmpty) {
                      return [Center(child: Text(localizations.noUpcomingTests))];
                    }

                    // Get number of tests to show from config
                    final config = homepageConfig.sections.firstWhere((s) => s.id == 'tests');
                    final numberOfTests = config.settings['numberOfTests'] ?? 3;

                    return upcomingExams.take(numberOfTests).map((exam) {
                      final examDate = exam.startDate != null ? DateTime.parse(exam.startDate!) : DateTime.now();
                      final startTime = exam.startDate != null ? DateTime.tryParse(exam.startDate!) : null;
                      final endTime = exam.endDate != null ? DateTime.tryParse(exam.endDate!) : null;

                      final appColors = Theme.of(context).extension<AppColors>();
                      final surfaceContainer = appColors?.surfaceContainer ??
                          Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: surfaceContainer,
                          borderRadius: BorderRadius.circular(8),
                          border: Border(
                            left: BorderSide(
                              color: Color(int.parse('0xFF${(exam.color ?? '#000000').substring(1)}')),
                              width: 3,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Date display
                            Column(
                              children: [
                                Text(
                                  '${examDate.day}',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Text(
                                  _getMonthShort(examDate.month),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            // Exam details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exam.courseName ?? '',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (exam.text != null && exam.text!.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      exam.text!,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      if (startTime != null && endTime != null) ...[
                                        Icon(
                                          Icons.access_time,
                                          size: 14,
                                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} - ${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                      if (exam.roomToken != null && exam.roomToken!.isNotEmpty) ...[
                                        if (startTime != null && endTime != null)
                                          const SizedBox(width: 12),
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
    final localizations = AppLocalizations.of(context)!;
    switch (weekday) {
      case 1:
        return localizations.weekdayMon;
      case 2:
        return localizations.weekdayTue;
      case 3:
        return localizations.weekdayWed;
      case 4:
        return localizations.weekdayThu;
      case 5:
        return localizations.weekdayFri;
      case 6:
        return localizations.weekdaySat;
      case 7:
        return localizations.weekdaySun;
      default:
        return '';
    }
  }

  String _getMonthShort(int month) {
    final localizations = AppLocalizations.of(context)!;
    switch (month) {
      case 1:
        return localizations.january.substring(0, 3);
      case 2:
        return localizations.february.substring(0, 3);
      case 3:
        return localizations.march.substring(0, 3);
      case 4:
        return localizations.april.substring(0, 3);
      case 5:
        return localizations.may.substring(0, 3);
      case 6:
        return localizations.june.substring(0, 3);
      case 7:
        return localizations.july.substring(0, 3);
      case 8:
        return localizations.august.substring(0, 3);
      case 9:
        return localizations.september.substring(0, 3);
      case 10:
        return localizations.october.substring(0, 3);
      case 11:
        return localizations.november.substring(0, 3);
      case 12:
        return localizations.december.substring(0, 3);
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

  List<Widget> _buildLessonsWithBreaks(List<AgendaDto> lessons, bool showBreaks) {
    final List<Widget> widgets = [];

    for (int i = 0; i < lessons.length; i++) {
      final item = lessons[i];
      final start = item.startDate != null ? DateTime.tryParse(item.startDate!) : null;
      final end = item.endDate != null ? DateTime.tryParse(item.endDate!) : null;

      // Add the lesson tile
      final dayStr = start != null ?
          '${_weekdayShort(start.weekday)} ${start.day.toString().padLeft(2, '0')}.${start.month.toString().padLeft(2, '0')}' :
          '';
      final timeStr = (start != null && end != null)
          ? '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')} - '
              '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}'
          : '';
      final subject = item.text ?? '';
      final room = item.roomToken ?? '';
      final teacher = item.teachers != null && item.teachers!.isNotEmpty ? item.teachers!.join(', ') : '';

      widgets.add(LessonTile(
        day: dayStr,
        time: timeStr,
        subject: subject,
        room: room,
        teacher: teacher,
        startTime: start,
        endTime: end,
      ));

      // Add break card if there's a gap before the next lesson and showBreaks is true
      if (showBreaks && i < lessons.length - 1 && end != null) {
        final nextItem = lessons[i + 1];
        final nextStart = nextItem.startDate != null ? DateTime.tryParse(nextItem.startDate!) : null;

        if (nextStart != null) {
          final breakDuration = nextStart.difference(end).inMinutes;

          // Only show breaks that are between 5 and 120 minutes
          if (breakDuration >= 5 && breakDuration <= 120) {
            widgets.add(BreakCard(
              duration: breakDuration,
              startTime: end,
              endTime: nextStart,
            ));
          }
        }
      }
    }

    return widgets;
  }
}
