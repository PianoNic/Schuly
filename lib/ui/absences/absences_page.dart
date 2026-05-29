import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../services/api_client.dart';
import '../../services/school_data_service.dart';

/// Absences tab — lists the user's absences/delays and lets them report,
/// edit, and delete (the one writable area).
class AbsencesPage extends StatelessWidget {
  const AbsencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final svc = SchoolDataService.instance;
    final absences = svc.absences.toList()
      ..sort((a, b) => b.from.compareTo(a.from));

    final delays = absences.where((a) => a.type == AbsenceType.delay).length;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FButton(
        mainAxisSize: MainAxisSize.min,
        prefix: const Icon(FIcons.plus),
        onPress: svc.me == null ? null : () => _openForm(context),
        child: const Text('Report'),
      ),
      body: RefreshIndicator(
        onRefresh: svc.refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
          children: [
            FCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _Stat(label: 'Total', value: '${absences.length}'),
                    _Stat(label: 'Delays', value: '$delays'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (absences.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Text('No absences', style: TextStyle(color: colors.mutedForeground)),
                ),
              )
            else
              for (final a in absences)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FTile(
                    prefix: const Icon(FIcons.calendarOff),
                    title: Text(a.reason?.isNotEmpty == true ? a.reason! : 'Absence'),
                    subtitle: Text(_rangeLabel(a.from, a.until)),
                    suffix: _TypeBadge(a.type),
                    onPress: () => _openForm(context, existing: a),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Future<void> _openForm(BuildContext context, {AbsenceDto? existing}) async {
    final changed = await showFSheet<bool>(
      context: context,
      side: FLayout.btt,
      mainAxisMaxRatio: null,
      builder: (_) => _AbsenceForm(existing: existing),
    );
    if (changed == true) await SchoolDataService.instance.refresh();
  }

  static String _rangeLabel(DateTime from, DateTime until) {
    String d(DateTime x) => '${x.day}.${x.month}.${x.year}';
    final f = d(from);
    return until.difference(from).inDays.abs() < 1 ? f : '$f – ${d(until)}';
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    final t = context.theme.typography;
    final c = context.theme.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: t.xl2.copyWith(fontWeight: FontWeight.w700)),
        Text(label, style: t.sm.copyWith(color: c.mutedForeground)),
      ],
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final AbsenceType? type;
  const _TypeBadge(this.type);
  @override
  Widget build(BuildContext context) {
    final isDelay = type == AbsenceType.delay;
    final color = isDelay ? const Color(0xFFF59E0B) : const Color(0xFFEF4444);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(isDelay ? 'Delay' : 'Absence',
          style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }
}

/// Bottom-sheet form to create or edit an absence.
class _AbsenceForm extends StatefulWidget {
  final AbsenceDto? existing;
  const _AbsenceForm({this.existing});
  @override
  State<_AbsenceForm> createState() => _AbsenceFormState();
}

class _AbsenceFormState extends State<_AbsenceForm> {
  late final TextEditingController _reason;
  late AbsenceType _type;
  late DateTime _from;
  late DateTime _until;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _reason = TextEditingController(text: e?.reason ?? '');
    _type = e?.type ?? AbsenceType.absence;
    _from = e?.from ?? DateTime.now();
    _until = e?.until ?? DateTime.now();
  }

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  Future<void> _pickDate(bool isFrom) async {
    final initial = isFrom ? _from : _until;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(initial.year - 1),
      lastDate: DateTime(initial.year + 1),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _from = picked;
          if (_until.isBefore(_from)) _until = _from;
        } else {
          _until = picked;
        }
      });
    }
  }

  Future<void> _save() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final api = ApiClient.instance.api.getAbsencesApi();
      final existing = widget.existing;
      if (existing == null) {
        final schoolUserId = SchoolDataService.instance.me?.id;
        await api.apiAbsencesPost(
          createAbsenceCommand: CreateAbsenceCommand((b) => b
            ..reason = _reason.text.trim()
            ..type = _type
            ..from = _from.toUtc()
            ..until = _until.toUtc()
            ..schoolUserId = schoolUserId),
        );
      } else {
        await api.apiAbsencesPut(
          updateAbsenceCommand: UpdateAbsenceCommand((b) => b
            ..absenceId = existing.id
            ..reason = _reason.text.trim()
            ..type = _type
            ..from = _from.toUtc()
            ..until = _until.toUtc()
            ..schoolUserId = existing.schoolUserId),
        );
      }
      if (mounted) Navigator.of(context).pop(true);
    } on DioException catch (e) {
      setState(() => _error = 'HTTP ${e.response?.statusCode}: ${e.response?.data}');
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _delete() async {
    final existing = widget.existing;
    if (existing?.id == null) return;
    setState(() => _busy = true);
    try {
      await ApiClient.instance.api.getAbsencesApi().apiAbsencesIdDelete(id: existing!.id!);
      if (mounted) Navigator.of(context).pop(true);
    } on DioException catch (e) {
      setState(() {
        _busy = false;
        _error = 'HTTP ${e.response?.statusCode}: ${e.response?.data}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    String d(DateTime x) => '${x.day}.${x.month}.${x.year}';
    return Container(
      decoration: BoxDecoration(color: colors.background),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.existing == null ? 'Report absence' : 'Edit absence',
              style: context.theme.typography.lg.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          FTextField(
            control: FTextFieldControl.managed(controller: _reason),
            label: const Text('Reason'),
          ),
          const SizedBox(height: 12),
          SegmentedButton<AbsenceType>(
            segments: const [
              ButtonSegment(value: AbsenceType.absence, label: Text('Absence')),
              ButtonSegment(value: AbsenceType.delay, label: Text('Delay')),
            ],
            selected: {_type},
            onSelectionChanged: (s) => setState(() => _type = s.first),
            showSelectedIcon: false,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(FIcons.calendar, size: 16),
                  onPressed: () => _pickDate(true),
                  label: Text('From: ${d(_from)}'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(FIcons.calendar, size: 16),
                  onPressed: () => _pickDate(false),
                  label: Text('Until: ${d(_until)}'),
                ),
              ),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            SelectableText(_error!, style: TextStyle(color: colors.destructive)),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              if (widget.existing != null) ...[
                IconButton(
                  onPressed: _busy ? null : _delete,
                  icon: Icon(FIcons.trash2, color: colors.destructive),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: FButton(
                  onPress: _busy ? null : _save,
                  child: Text(_busy ? 'Saving…' : 'Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
