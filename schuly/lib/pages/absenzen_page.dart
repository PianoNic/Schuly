import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/api_store.dart';
import 'package:schuly/api/lib/api.dart';

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48.0), // Reduced from default ~56
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 0, // Remove toolbar space completely
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Alle Absenzen'),
              Tab(text: 'Verspätungen'),
              Tab(text: 'Absenzen'),
              Tab(text: 'Meldungen'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllAbsencesTab(),
          _buildLatenessTab(),
          _buildAbsencesTab(),
          _buildAbsenceNoticesTab(),
        ],
      ),
    );
  }

  Widget _buildAllAbsencesTab() {
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
            return const Center(child: Text('Keine Absenzen gefunden.'));
          }
          
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Absences section
                if (absences.isNotEmpty) ...[
                  Text('Absenzen', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
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
                      );
                    }).toList();
                  })(),
                  const SizedBox(height: 16),
                ],
                
                // Lateness section
                if (lateness.isNotEmpty) ...[
                  Text('Verspätungen', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ..._buildLatenessItems(lateness),
                  const SizedBox(height: 16),
                ],
                
                // Absence notices section
                if (absenceNotices.isNotEmpty) ...[
                  Text('Meldungen', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ..._buildGenericItems(absenceNotices, 'Meldung'),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildLatenessItems(List<LatenessDto> latenessItems) {
    return latenessItems.map((lateness) {
      return LatenessItem(
        date: lateness.date,
        duration: lateness.duration,
        reason: lateness.reason ?? 'Kein Grund angegeben',
        excused: lateness.excused,
        comment: lateness.comment ?? 'Kein Kommentar angegeben',
        courseToken: lateness.courseToken,
      );
    }).toList();
  }

  List<Widget> _buildGenericItems(List<Object> items, String itemType) {
    return items.map((item) {
      Map<String, dynamic> itemData = {};
      if (item is Map<String, dynamic>) {
        itemData = item;
      } else {
        try {
          itemData = {'data': item.toString()};
        } catch (_) {
          itemData = {'data': 'Unbekannte Daten'};
        }
      }

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
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
        ),
      );
    }).toList();
  }

  Widget _buildLatenessTab() {
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
            return const Center(child: Text('Keine Verspätungen gefunden.'));
          }
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildLatenessItems(lateness),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAbsencesTab() {
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
            return const Center(child: Text('Keine Absenzen gefunden.'));
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

  Widget _buildAbsenceNoticesTab() {
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
            return const Center(child: Text('Keine Meldungen gefunden.'));
          }
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildGenericItems(absenceNotices, 'Meldung'),
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

  const LatenessItem({
    super.key,
    required this.date,
    required this.duration,
    required this.reason,
    required this.excused,
    required this.comment,
    required this.courseToken,
  });

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  String _formatDuration(String duration) {
    // Convert duration from minutes to readable format
    try {
      final minutes = int.parse(duration);
      if (minutes < 60) {
        return '$minutes Min.';
      } else {
        final hours = minutes ~/ 60;
        final remainingMinutes = minutes % 60;
        if (remainingMinutes == 0) {
          return '$hours Std.';
        } else {
          return '$hours Std. $remainingMinutes Min.';
        }
      }
    } catch (_) {
      return duration; // Return original if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verspätung vom ${_formatDate(date)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Dauer:', _formatDuration(duration)),
            _buildDetailRow('Kurs:', courseToken),
            _buildDetailRow('Grund:', reason),
            _buildDetailRow('Kommentar:', comment),
            _buildDetailRowWithStatus('Status:', excused),
          ],
        ),
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
      displayText = 'Entschuldigt';
    } else {
      icon = Icons.cancel;
      color = Colors.red;
      displayText = 'Nicht entschuldigt';
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

  const CompactAbsenceItem({
    super.key,
    required this.absentFrom,
    required this.absentTo,
    required this.excuseUntil,
    required this.status,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reason,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Von:', absentFrom),
            _buildDetailRow('Bis:', absentTo),
            _buildDetailRow('Entschuldigen bis:', excuseUntil),
            _buildDetailRowWithStatusText('Status:', status),
          ],
        ),
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

  final List<String> _reasons = [
    'Krankheit',
    'Unfall',
    'Militär',
    'gültiges Arztzeugnis für Sport',
    'Andere Absenz',
  ];

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
                    ).colorScheme.onSurfaceVariant.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Neue Absenz erfassen',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),

              // Reason Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Grund *',
                  border: OutlineInputBorder(),
                ),
                initialValue: _selectedReason.isEmpty ? null : _selectedReason,
                items: _reasons.map((reason) {
                  return DropdownMenuItem(value: reason, child: Text(reason));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedReason = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte wählen Sie einen Grund aus';
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
                        labelText: 'Abwesend von *',
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
                          return 'Bitte wählen Sie ein Datum aus';
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
                        labelText: 'Abwesend bis *',
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
                          return 'Bitte wählen Sie ein Datum aus';
                        }
                        if (_fromDate != null &&
                            _toDate!.isBefore(_fromDate!)) {
                          return 'Bis-Datum muss nach Von-Datum liegen';
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
                        labelText: 'Abwesend ab (Uhrzeit)',
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
                        labelText: 'Abwesend bis (Uhrzeit)',
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
                decoration: const InputDecoration(
                  labelText: 'Kommentar',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Abbrechen'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Absenz erfolgreich erfasst!'),
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
                      child: const Text('Erfassen'),
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
