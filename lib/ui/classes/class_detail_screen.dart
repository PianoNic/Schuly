import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../services/api_client.dart';
import '../core/grade_color.dart';

/// Detail for a single class: students, exams, and agenda — fetched on demand
/// via GET /Class/search.
class ClassDetailScreen extends StatefulWidget {
  final String classId;
  final String title;
  const ClassDetailScreen({super.key, required this.classId, required this.title});

  @override
  State<ClassDetailScreen> createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  ClassDto? _class;
  bool _loading = true;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await ApiClient.instance.api
          .getClassApi()
          .apiClassSearchGet(classId: widget.classId);
      if (mounted) setState(() => _class = res.data);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final c = _class;

    Widget body;
    if (_loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SelectableText('Failed to load: $_error',
              style: TextStyle(color: colors.destructive)),
        ),
      );
    } else if (c == null) {
      body = Center(child: Text('Not found', style: TextStyle(color: colors.mutedForeground)));
    } else {
      final students = (c.students ?? const <SchoolUserDto>[]).toList()
        ..sort((a, b) => '${a.lastName}'.compareTo('${b.lastName}'));
      final exams = c.exams ?? const <ExamDto>[];
      final agenda = (c.agenda ?? const <AgendaEntryDto>[]).toList()
        ..sort((a, b) => a.date.compareTo(b.date));

      body = RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            if ((c.description?.isNotEmpty ?? false))
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(c.description!, style: TextStyle(color: colors.mutedForeground)),
              ),
            if (students.isNotEmpty) ...[
              _Label('Students (${students.length})'),
              for (final s in students)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FTile(
                    prefix: const Icon(FIcons.user),
                    title: Text('${s.firstName ?? ''} ${s.lastName ?? ''}'.trim()),
                  ),
                ),
              const SizedBox(height: 12),
            ],
            if (exams.isNotEmpty) ...[
              _Label('Exams (${exams.length})'),
              for (final e in exams)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FTile(
                    title: Text(e.name ?? 'Exam'),
                    subtitle: Text('class ⌀ ${formatGrade(e.classAverage)}'),
                    suffix: isGraded(e.classAverage)
                        ? GradePill(e.classAverage)
                        : null,
                  ),
                ),
              const SizedBox(height: 12),
            ],
            if (agenda.isNotEmpty) ...[
              _Label('Agenda (${agenda.length})'),
              for (final a in agenda.take(30))
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FTile(
                    prefix: const Icon(FIcons.calendarDays),
                    title: Text(a.title?.isNotEmpty == true ? a.title! : 'Entry'),
                    subtitle: Text('${a.date.day}.${a.date.month}.${a.date.year}'),
                  ),
                ),
            ],
          ],
        ),
      );
    }

    return FScaffold(
      header: FHeader.nested(
        title: Text(widget.title),
        prefixes: [FHeaderAction.back(onPress: () => Navigator.of(context).pop())],
      ),
      child: body,
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) {
    final c = context.theme.colors;
    final t = context.theme.typography;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: Text(text.toUpperCase(),
          style: t.xs.copyWith(color: c.mutedForeground, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
    );
  }
}
