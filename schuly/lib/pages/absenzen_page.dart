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
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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


  Widget _buildGenericDetailRowWithStatus(String label, String statusText) {
    IconData icon;
    Color color;

    final statusLower = statusText.toLowerCase();
    if (statusLower.contains('entschuldigt') || statusLower.contains('excused')) {
      icon = Icons.check_circle;
      color = Colors.green;
    } else if (statusLower.contains('offen') || statusLower.contains('open') || statusLower.contains('pending')) {
      icon = Icons.schedule;
      color = Colors.orange;
    } else if (statusLower.contains('confirmed') || statusLower.contains('bestätigt')) {
      icon = Icons.verified;
      color = Colors.blue;
    } else if (statusLower.contains('abgelehnt') || statusLower.contains('rejected') || statusLower.contains('denied')) {
      icon = Icons.cancel;
      color = Colors.red;
    } else {
      icon = Icons.info;
      color = Colors.grey;
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
              Tab(text: localizations.absencesTabNotices), // TODO: Add absencesTabNotices to ARB
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
          _buildAbsenceNoticesTab(localizations),
        ],
      ),
    );
  }

  Widget _buildAllAbsencesTab(AppLocalizations localizations) {
    return RefreshIndicator(
      onRefresh: () async {
        final apiStore = Provider.of<ApiStore>(context, listen: false);
        await Future.wait([
          apiStore.fetchAbsences(),
          apiStore.fetchLateness(),
          apiStore.fetchAbsenceNotices(),
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
                      return CompactAbsenceItem(
                        absentFrom: _formatDateTime(absence.dateFrom, absence.hourFrom),
                        absentTo: _formatDateTime(absence.dateTo, absence.hourTo),
                        excuseUntil: _formatDateTime(absence.dateEAB, null),
                        status: absence.statusEAB,
                        reason: absence.reason,
                        localizations: localizations,
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
                
                // Absence notices section
                if (absenceNotices.isNotEmpty) ...[
                  Text(localizations.noticesSection, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), // TODO: Add noticesSection to ARB
                  const SizedBox(height: 8),
                  ..._buildGenericItems(absenceNotices, localizations.noticeItem, localizations), // TODO: Add noticeItem to ARB
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

  List<Widget> _buildGenericItems(List<Object> items, String itemType, AppLocalizations localizations) {
    return items.map((item) {
      Map<String, dynamic> itemData = {};
      if (item is Map<String, dynamic>) {
        itemData = item;
      } else {
        try {
          itemData = {'data': item.toString()};
        } catch (_) {
          itemData = {'data': localizations.unknownData}; // TODO: Add unknownData to ARB
        }
      }

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
              itemType,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ...itemData.entries.map((entry) {
              final isStatusField = entry.key.toLowerCase().contains('status') ||
                                   entry.key.toLowerCase().contains('excused') ||
                                   entry.key.toLowerCase().contains('entschuldigt');

              if (isStatusField) {
                return _buildGenericDetailRowWithStatus('${entry.key}:', entry.value?.toString() ?? 'N/A');
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          '${entry.key}:',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          entry.value?.toString() ?? 'N/A',
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildLatenessTab(AppLocalizations localizations) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<ApiStore>(context, listen: false).fetchLateness();
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
        await Provider.of<ApiStore>(context, listen: false).fetchAbsences();
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
                    return CompactAbsenceItem(
                      absentFrom: _formatDateTime(absence.dateFrom, absence.hourFrom),
                      absentTo: _formatDateTime(absence.dateTo, absence.hourTo),
                      excuseUntil: _formatDateTime(absence.dateEAB, null),
                      status: absence.statusEAB,
                      reason: absence.reason,
                      localizations: localizations,
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

  Widget _buildAbsenceNoticesTab(AppLocalizations localizations) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<ApiStore>(context, listen: false).fetchAbsenceNotices();
      },
      child: Consumer<ApiStore>(
        builder: (context, apiStore, _) {
          final absenceNotices = apiStore.absenceNotices;
          if (absenceNotices == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (absenceNotices.isEmpty) {
            return Center(child: Text(localizations.noNoticesFound)); // TODO: Add noNoticesFound to ARB
          }
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildGenericItems(absenceNotices, localizations.noticeItem, localizations),
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
class CompactAbsenceItem extends StatelessWidget {
  final String absentFrom;
  final String absentTo;
  final String excuseUntil;
  final String status;
  final String reason;
  final AppLocalizations localizations;

  const CompactAbsenceItem({
    super.key,
    required this.absentFrom,
    required this.absentTo,
    required this.excuseUntil,
    required this.status,
    required this.reason,
    required this.localizations,
  });

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
            reason,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildDetailRow('${localizations.from}:', absentFrom), // TODO: Add from to ARB
            _buildDetailRow('${localizations.to}:', absentTo), // TODO: Add to to ARB
            _buildDetailRow('${localizations.excuseUntil}:', excuseUntil), // TODO: Add excuseUntil to ARB
            _buildDetailRowWithStatusText('${localizations.status}:', status), // TODO: Add status to ARB
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

  Widget _buildDetailRowWithStatusText(String label, String statusText) {
    IconData icon;
    Color color;

    final statusLower = statusText.toLowerCase();
    if (statusLower.contains('entschuldigt') || statusLower.contains('excused')) {
      icon = Icons.check_circle;
      color = Colors.green;
    } else if (statusLower.contains('offen') || statusLower.contains('open') || statusLower.contains('pending')) {
      icon = Icons.schedule;
      color = Colors.orange;
    } else if (statusLower.contains('confirmed') || statusLower.contains('bestätigt')) {
      icon = Icons.verified;
      color = Colors.blue;
    } else if (statusLower.contains('abgelehnt') || statusLower.contains('rejected') || statusLower.contains('denied')) {
      icon = Icons.cancel;
      color = Colors.red;
    } else {
      icon = Icons.info;
      color = Colors.grey;
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
