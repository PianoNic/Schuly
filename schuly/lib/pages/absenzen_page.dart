import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/api_store.dart';
import '../providers/theme_provider.dart';
import 'package:schuly/api/lib/api.dart';
import '../l10n/app_localizations.dart';

class AbsenzenPage extends StatefulWidget {
  const AbsenzenPage({super.key});

  @override
  State<AbsenzenPage> createState() => _AbsenzenPageState();
}

class _AbsenzenPageState extends State<AbsenzenPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<AbsenceNoticeDto> _getNoticesForAbsence(AbsenceDto absence, List<dynamic> notices) {
    final List<AbsenceNoticeDto> validNotices = [];

    for (final notice in notices) {
      AbsenceNoticeDto? noticeDto;
      if (notice is AbsenceNoticeDto) {
        noticeDto = notice;
      } else if (notice is Map<String, dynamic>) {
        try {
          noticeDto = AbsenceNoticeDto.fromJson(notice);
        } catch (_) {
          continue;
        }
      }

      if (noticeDto != null) {
        // Check if notice date falls within absence period
        if (_isNoticeWithinAbsence(absence, noticeDto)) {
          validNotices.add(noticeDto);
        }
      }
    }

    return validNotices;
  }

  bool _isNoticeWithinAbsence(AbsenceDto absence, AbsenceNoticeDto notice) {
    try {
      // Parse absence dates
      final absenceFromDate = DateTime.parse(absence.dateFrom);
      final absenceToDate = DateTime.parse(absence.dateTo);

      // Parse notice date
      final noticeDate = DateTime.parse(notice.date);

      // Check if notice date is within absence date range
      if (noticeDate.isAfter(absenceFromDate.subtract(const Duration(days: 1))) &&
          noticeDate.isBefore(absenceToDate.add(const Duration(days: 1)))) {

        // If we have time information, check time overlap too
        if (absence.hourFrom != null && absence.hourFrom!.isNotEmpty &&
            absence.hourTo != null && absence.hourTo!.isNotEmpty &&
            notice.hourFrom.isNotEmpty && notice.hourTo.isNotEmpty) {

          // For same day, check time overlap
          if (absenceFromDate.year == absenceToDate.year &&
              absenceFromDate.month == absenceToDate.month &&
              absenceFromDate.day == absenceToDate.day &&
              noticeDate.year == absenceFromDate.year &&
              noticeDate.month == absenceFromDate.month &&
              noticeDate.day == absenceFromDate.day) {

            final absenceFromTime = _parseTime(absence.hourFrom!);
            final absenceToTime = _parseTime(absence.hourTo!);
            final noticeFromTime = _parseTime(notice.hourFrom);
            final noticeToTime = _parseTime(notice.hourTo);

            // Check if times overlap
            return _doTimesOverlap(
              absenceFromTime, absenceToTime,
              noticeFromTime, noticeToTime
            );
          }
        }

        return true; // Date matches, no time check needed or multi-day absence
      }
    } catch (e) {
      // If date parsing fails, don't match
      return false;
    }

    return false;
  }

  int _parseTime(String? time) {
    if (time == null || time.isEmpty) return 0;
    try {
      final parts = time.split(':');
      if (parts.length >= 2) {
        return int.parse(parts[0]) * 60 + int.parse(parts[1]);
      }
    } catch (_) {}
    return 0;
  }

  bool _doTimesOverlap(int start1, int end1, int start2, int end2) {
    return start1 < end2 && start2 < end1;
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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48.0), // Reduced from default ~56
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 0, // Remove toolbar space completely
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: localizations.absencesTabAll), // TODO: Add absencesTabAll to ARB
              Tab(text: localizations.absencesTabLateness), // TODO: Add absencesTabLateness to ARB
              Tab(text: localizations.absencesTabAbsences), // TODO: Add absencesTabAbsences to ARB
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllAbsencesTab(localizations),
          _buildLatenessTab(localizations),
          _buildAbsencesTab(localizations),
        ],
      ),
    );
  }

  Widget _buildAllAbsencesTab(AppLocalizations localizations) {
    return RefreshIndicator(
      onRefresh: () async {
        final apiStore = Provider.of<ApiStore>(context, listen: false);
        await Future.wait([
          apiStore.fetchAbsences(forceRefresh: true),
          apiStore.fetchLateness(forceRefresh: true),
          apiStore.fetchAbsenceNotices(forceRefresh: true),
        ]);
      },
      child: Consumer<ApiStore>(
        builder: (context, apiStore, _) {
          final absences = apiStore.absences;
          final lateness = apiStore.lateness;
          final absenceNotices = apiStore.absenceNotices;
          
          bool isLoading = absences == null || lateness == null || absenceNotices == null;
          bool isEmpty = (absences?.isEmpty ?? true) && 
                        (lateness?.isEmpty ?? true) && 
                        (absenceNotices?.isEmpty ?? true);
          
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (isEmpty) {
            return Center(child: Text(localizations.noAbsencesFound));
          }
          
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Absences section
                if (absences.isNotEmpty) ...[
                  Text(localizations.absencesSection, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), // TODO: Add absencesSection to ARB
                  const SizedBox(height: 8),
                  ...(() {
                    final List absRaw = absences;
                    final List<AbsenceDto> validAbsences = absRaw.map((a) {
                      if (a is AbsenceDto) return a;
                      try {
                        return AbsenceDto.fromJson(a as Map<String, dynamic>);
                      } catch (_) {
                        return null;
                      }
                    }).whereType<AbsenceDto>().toList();

                    return validAbsences.map((absence) {
                      // Filter notices for this absence
                      final relatedNotices = _getNoticesForAbsence(absence, absenceNotices);
                      final selectedAbsenceId = apiStore.selectedAbsenceId;
                      final shouldExpand = selectedAbsenceId != null && absence.id == selectedAbsenceId;

                      // Clear selected absence after use
                      if (shouldExpand) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          apiStore.setSelectedAbsenceId(null);
                        });
                      }

                      return CompactAbsenceItem(
                        absence: absence,
                        absentFrom: _formatDateTime(absence.dateFrom, absence.hourFrom),
                        absentTo: _formatDateTime(absence.dateTo, absence.hourTo),
                        excuseUntil: absence.dateEAB != null ? _formatDateTime(absence.dateEAB!, null) : '',
                        status: absence.statusEAB,
                        reason: absence.reason,
                        relatedNotices: relatedNotices,
                        localizations: localizations,
                        initiallyExpanded: shouldExpand,
                      );
                    }).toList();
                  })(),
                  const SizedBox(height: 16),
                ],
                
                // Lateness section
                if (lateness.isNotEmpty) ...[
                  Text(localizations.latenessSection, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), // TODO: Add latenessSection to ARB
                  const SizedBox(height: 8),
                  ..._buildLatenessItems(lateness, localizations),
                  const SizedBox(height: 16),
                ],
                
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildLatenessItems(List<LatenessDto> latenessItems, AppLocalizations localizations) {
    return latenessItems.map((lateness) {
      return LatenessItem(
        date: lateness.date,
        duration: lateness.duration,
        reason: lateness.reason ?? localizations.noReasonGiven, // TODO: Add noReasonGiven to ARB
        excused: lateness.excused,
        comment: lateness.comment ?? localizations.noCommentGiven, // TODO: Add noCommentGiven to ARB
        courseToken: lateness.courseToken,
        localizations: localizations,
      );
    }).toList();
  }


  Widget _buildLatenessTab(AppLocalizations localizations) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<ApiStore>(context, listen: false).fetchLateness(forceRefresh: true);
      },
      child: Consumer<ApiStore>(
        builder: (context, apiStore, _) {
          final lateness = apiStore.lateness;
          if (lateness == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (lateness.isEmpty) {
            return Center(child: Text(localizations.noLatenessFound)); // TODO: Add noLatenessFound to ARB
          }
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildLatenessItems(lateness, localizations),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAbsencesTab(AppLocalizations localizations) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<ApiStore>(context, listen: false).fetchAbsences(forceRefresh: true);
      },
      child: Consumer<ApiStore>(
        builder: (context, apiStore, _) {
          final absences = apiStore.absences;
          if (absences == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (absences.isEmpty) {
            return Center(child: Text(localizations.noAbsencesFound));
          }
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...(() {
                  final List absRaw = absences;
                  final List<AbsenceDto> validAbsences = absRaw.map((a) {
                    if (a is AbsenceDto) return a;
                    try {
                      return AbsenceDto.fromJson(a as Map<String, dynamic>);
                    } catch (_) {
                      return null;
                    }
                  }).whereType<AbsenceDto>().toList();

                  return validAbsences.map((absence) {
                    // Fetch notices here too
                    final absenceNotices = apiStore.absenceNotices ?? [];
                    final relatedNotices = _getNoticesForAbsence(absence, absenceNotices);
                    final selectedAbsenceId = apiStore.selectedAbsenceId;
                    final shouldExpand = selectedAbsenceId != null && absence.id == selectedAbsenceId;

                    // Clear selected absence after use
                    if (shouldExpand) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        apiStore.setSelectedAbsenceId(null);
                      });
                    }

                    return CompactAbsenceItem(
                      absence: absence,
                      absentFrom: _formatDateTime(absence.dateFrom, absence.hourFrom),
                      absentTo: _formatDateTime(absence.dateTo, absence.hourTo),
                      excuseUntil: absence.dateEAB != null ? _formatDateTime(absence.dateEAB!, null) : '',
                      status: absence.statusEAB,
                      reason: absence.reason,
                      relatedNotices: relatedNotices,
                      localizations: localizations,
                      initiallyExpanded: shouldExpand,
                    );
                  }).toList();
                })(),
              ],
            ),
          );
        },
      ),
    );
  }

}

// Lateness Item Widget
class LatenessItem extends StatelessWidget {
  final DateTime date;
  final String duration;
  final String reason;
  final bool excused;
  final String comment;
  final String courseToken;
  final AppLocalizations localizations;

  const LatenessItem({
    super.key,
    required this.date,
    required this.duration,
    required this.reason,
    required this.excused,
    required this.comment,
    required this.courseToken,
    required this.localizations,
  });

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  String _formatDuration(String duration) {
    // Convert duration from minutes to readable format
    try {
      final minutes = int.parse(duration);
      if (minutes < 60) {
        return '$minutes ${localizations.minutes}'; // TODO: Add minutes to ARB
      } else {
        final hours = minutes ~/ 60;
        final remainingMinutes = minutes % 60;
        if (remainingMinutes == 0) {
          return '$hours ${localizations.hours}'; // TODO: Add hours to ARB
        } else {
          return '$hours ${localizations.hours} $remainingMinutes ${localizations.minutes}';
        }
      }
    } catch (_) {
      return duration; // Return original if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final surfaceContainer = appColors?.surfaceContainer ??
        Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${localizations.latenessFrom} ${_formatDate(date)}', // TODO: Add latenessFrom to ARB
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildDetailRow('${localizations.duration}:', _formatDuration(duration)), // TODO: Add duration to ARB
            _buildDetailRow('${localizations.course}:', courseToken), // TODO: Add course to ARB
            _buildDetailRow('${localizations.reason}:', reason), // TODO: Add reason to ARB
            _buildDetailRow('${localizations.comment}:', comment), // TODO: Add comment to ARB
            _buildDetailRowWithStatus('${localizations.status}:', excused), // TODO: Add status to ARB
          ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRowWithStatus(String label, bool excusedStatus) {
    IconData icon;
    Color color;
    String displayText;

    if (excusedStatus) {
      icon = Icons.check_circle;
      color = Colors.green;
      displayText = localizations.excused; // TODO: Add excused to ARB
    } else {
      icon = Icons.cancel;
      color = Colors.red;
      displayText = localizations.notExcused; // TODO: Add notExcused to ARB
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(icon, color: color, size: 16),
                const SizedBox(width: 6),
                Text(
                  displayText,
                  style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Compact version of AbsenceItem
class CompactAbsenceItem extends StatefulWidget {
  final AbsenceDto? absence;
  final String absentFrom;
  final String absentTo;
  final String excuseUntil;
  final String status;
  final String reason;
  final List<AbsenceNoticeDto>? relatedNotices;
  final AppLocalizations localizations;
  final bool initiallyExpanded;

  const CompactAbsenceItem({
    super.key,
    this.absence,
    required this.absentFrom,
    required this.absentTo,
    required this.excuseUntil,
    required this.status,
    required this.reason,
    this.relatedNotices,
    required this.localizations,
    this.initiallyExpanded = false,
  });

  @override
  State<CompactAbsenceItem> createState() => _CompactAbsenceItemState();
}

class _CompactAbsenceItemState extends State<CompactAbsenceItem> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final surfaceContainer = appColors?.surfaceContainer ??
        Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);

    final hasNotices = widget.relatedNotices != null && widget.relatedNotices!.isNotEmpty;
    final noticeCount = widget.relatedNotices?.length ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: hasNotices ? () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            } : null,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.reason,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      if (hasNotices) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.assignment,
                                size: 13,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '$noticeCount',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more,
                          size: 20,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow('${widget.localizations.from}:', widget.absentFrom), // TODO: Add from to ARB
                  _buildDetailRow('${widget.localizations.to}:', widget.absentTo), // TODO: Add to to ARB
                  _buildDetailRow('${widget.localizations.excuseUntil}:', widget.excuseUntil), // TODO: Add excuseUntil to ARB
                  _buildDetailRowWithExcusedStatus('${widget.localizations.status}:', widget.absence?.isExcused ?? false), // TODO: Add status to ARB
                ],
              ),
            ),
          ),
          if (_isExpanded && hasNotices) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.localizations.relatedNotices, // TODO: Add relatedNotices to ARB
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.relatedNotices!.map((notice) => _buildNoticeCard(notice)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(String time) {
    // Remove seconds from time format (HH:mm:ss -> HH:mm)
    if (time.length >= 5) {
      return time.substring(0, 5);
    }
    return time;
  }

  String _calculateDuration(String startTime, String endTime) {
    try {
      // Parse times
      final startParts = startTime.split(':');
      final endParts = endTime.split(':');

      if (startParts.length >= 2 && endParts.length >= 2) {
        final startMinutes = int.parse(startParts[0]) * 60 + int.parse(startParts[1]);
        final endMinutes = int.parse(endParts[0]) * 60 + int.parse(endParts[1]);

        var durationMinutes = endMinutes - startMinutes;
        if (durationMinutes < 0) {
          durationMinutes += 24 * 60; // Handle day wrap
        }

        final hours = durationMinutes ~/ 60;
        final minutes = durationMinutes % 60;

        if (hours > 0 && minutes > 0) {
          return '${hours}h ${minutes}min';
        } else if (hours > 0) {
          return '${hours}h';
        } else {
          return '${minutes}min';
        }
      }
    } catch (_) {}

    return '-';
  }

  Widget _buildNoticeCard(AbsenceNoticeDto notice) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                notice.isExamLesson ? Icons.school : Icons.class_,
                size: 15,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  notice.course,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
              if (notice.isExamLesson)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.localizations.exam, // TODO: Add exam to ARB
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          _buildNoticeDateTimeDurationRow(
            widget.localizations.date,
            notice.date.split('T')[0].split('-').reversed.join('.'),
            widget.localizations.time,
            '${_formatTime(notice.hourFrom)} - ${_formatTime(notice.hourTo)}',
            widget.localizations.duration,
            _calculateDuration(notice.hourFrom, notice.hourTo)
          ),
          if (notice.studentReason != null && notice.studentReason!.isNotEmpty)
            _buildNoticeDetailRow(widget.localizations.studentReason, notice.studentReason!), // TODO: Add studentReason to ARB
          if (notice.trainerComment != null && notice.trainerComment!.isNotEmpty)
            _buildNoticeDetailRow(widget.localizations.trainerComment, notice.trainerComment!), // TODO: Add trainerComment to ARB
          if (notice.comment != null && notice.comment!.isNotEmpty)
            _buildNoticeDetailRow(widget.localizations.comment, notice.comment!), // TODO: Add comment to ARB
          const SizedBox(height: 4),
          _buildNoticeStatusRow(notice.status, notice.statusLong),
        ],
      ),
    );
  }

  Widget _buildNoticeDateTimeDurationRow(String dateLabel, String dateValue, String timeLabel, String timeValue, String durationLabel, String durationValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate approximate widths needed for each section
          final dateWidth = _calculateTextWidth('$dateLabel: $dateValue', const TextStyle(fontSize: 11));
          final timeWidth = _calculateTextWidth('$timeLabel: $timeValue', const TextStyle(fontSize: 11));
          final durationWidth = _calculateTextWidth('$durationLabel: $durationValue', const TextStyle(fontSize: 11));

          // Add spacing between elements (16px each)
          final totalWidth = dateWidth + timeWidth + durationWidth + 32;

          // Use Row if everything fits, otherwise use Wrap
          if (totalWidth <= constraints.maxWidth) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$dateLabel:',
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dateValue,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$timeLabel:',
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeValue,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$durationLabel:',
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      durationValue,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Wrap(
              spacing: 16,
              runSpacing: 4,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$dateLabel:',
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dateValue,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$timeLabel:',
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeValue,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$durationLabel:',
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      durationValue,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  double _calculateTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  Widget _buildNoticeDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 11),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeStatusRow(String status, String statusLong) {
    IconData icon;
    Color color;

    final statusLower = status.toLowerCase();
    if (statusLower.contains('entschuldigt') || statusLower.contains('excused')) {
      icon = Icons.check_circle;
      color = Colors.green;
    } else if (statusLower.contains('offen') || statusLower.contains('open') || statusLower.contains('pending')) {
      icon = Icons.schedule;
      color = Colors.orange;
    } else if (statusLower.contains('confirmed') || statusLower.contains('bestätigt')) {
      icon = Icons.verified;
      color = Colors.blue;
    } else {
      icon = Icons.info;
      color = Colors.grey;
    }

    return Row(
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 3),
        Text(
          statusLong,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRowWithExcusedStatus(String label, bool isExcused) {
    IconData icon;
    Color color;
    String statusText;

    if (isExcused) {
      icon = Icons.check_circle;
      color = Colors.green;
      statusText = widget.localizations.excused;
    } else {
      icon = Icons.cancel;
      color = Colors.red;
      statusText = widget.localizations.notExcused;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(icon, color: color, size: 16),
                const SizedBox(width: 6),
                Text(
                  statusText,
                  style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Form modal for creating new absences (remains unchanged)
class AbsenceFormModal extends StatefulWidget {
  const AbsenceFormModal({super.key});

  @override
  State<AbsenceFormModal> createState() => _AbsenceFormModalState();
}

class _AbsenceFormModalState extends State<AbsenceFormModal> {
  final _formKey = GlobalKey<FormState>();
  String _selectedReason = '';
  DateTime? _fromDate;
  DateTime? _toDate;
  TimeOfDay? _fromTime;
  TimeOfDay? _toTime;
  final _commentController = TextEditingController();

  List<String> _getReasons(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return [
      localizations.illness,
      localizations.accident,
      localizations.military,
      localizations.medicalCertificateForSport,
      localizations.otherAbsence,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                AppLocalizations.of(context)!.createNewAbsence,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),

              // Reason Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.reasonRequired,
                  border: const OutlineInputBorder(),
                ),
                initialValue: _selectedReason.isEmpty ? null : _selectedReason,
                items: _getReasons(context).map((reason) {
                  return DropdownMenuItem(value: reason, child: Text(reason));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedReason = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.selectReason;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date fields
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.absentFrom,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 30),
                              ),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (date != null) {
                              setState(() {
                                _fromDate = date;
                              });
                            }
                          },
                        ),
                      ),
                      controller: TextEditingController(
                        text: _fromDate != null
                            ? '${_fromDate!.day.toString().padLeft(2, '0')}.${_fromDate!.month.toString().padLeft(2, '0')}.${_fromDate!.year}'
                            : '',
                      ),
                      validator: (value) {
                        if (_fromDate == null) {
                          return AppLocalizations.of(context)!.selectDate;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.absentTo,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _fromDate ?? DateTime.now(),
                              firstDate:
                                  _fromDate ?? 
                                  DateTime.now().subtract(
                                    const Duration(days: 30),
                                  ),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (date != null) {
                              setState(() {
                                _toDate = date;
                              });
                            }
                          },
                        ),
                      ),
                      controller: TextEditingController(
                        text: _toDate != null
                            ? '${_toDate!.day.toString().padLeft(2, '0')}.${_toDate!.month.toString().padLeft(2, '0')}.${_toDate!.year}'
                            : '',
                      ),
                      validator: (value) {
                        if (_toDate == null) {
                          return AppLocalizations.of(context)!.selectDate;
                        }
                        if (_fromDate != null &&
                            _toDate!.isBefore(_fromDate!)) {
                          return AppLocalizations.of(context)!.toDateMustBeAfterFromDate;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Time fields
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.absentFromTime,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (time != null) {
                              setState(() {
                                _fromTime = time;
                              });
                            }
                          },
                        ),
                      ),
                      controller: TextEditingController(
                        text: _fromTime != null
                            ? '${_fromTime!.hour.toString().padLeft(2, '0')}:${_fromTime!.minute.toString().padLeft(2, '0')}'
                            : '',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.absentToTime,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: _fromTime ?? TimeOfDay.now(),
                            );
                            if (time != null) {
                              setState(() {
                                _toTime = time;
                              });
                            }
                          },
                        ),
                      ),
                      controller: TextEditingController(
                        text: _toTime != null
                            ? '${_toTime!.hour.toString().padLeft(2, '0')}:${_toTime!.minute.toString().padLeft(2, '0')}'
                            : '',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Comment field
              TextFormField(
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.comment,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(AppLocalizations.of(context)!.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!.absenceCreatedSuccessfully),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimary,
                      ),
                      child: Text(AppLocalizations.of(context)!.create),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
