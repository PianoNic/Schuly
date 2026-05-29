import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../services/school_data_service.dart';
import '../core/grade_color.dart';

/// Grades tab with two views: live exam grades (grouped by class) and the
/// official semester reports.
class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: SizedBox(
            width: double.infinity,
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Grades')),
                ButtonSegment(value: 1, label: Text('Reports')),
              ],
              selected: {_tab},
              onSelectionChanged: (s) => setState(() => _tab = s.first),
              showSelectedIcon: false,
            ),
          ),
        ),
        Expanded(
          child: IndexedStack(
            index: _tab,
            children: const [_GradesView(), _ReportsView()],
          ),
        ),
      ],
    );
  }
}

class _GradesView extends StatelessWidget {
  const _GradesView();

  @override
  Widget build(BuildContext context) {
    final svc = SchoolDataService.instance;
    final myGrades = svc.myGradesByExam;

    final byClass = <String, List<ExamDto>>{};
    for (final e in svc.exams) {
      if (e.id != null && myGrades.containsKey(e.id)) {
        byClass.putIfAbsent(e.classId ?? '—', () => []).add(e);
      }
    }
    final classNames = <String?, String?>{
      for (final c in (svc.me?.classes ?? const <UserClassDto>[])) c.classId: c.className,
      ...svc.classNameById,
    };

    if (byClass.isEmpty) {
      return _RefreshableEmpty(onRefresh: svc.refresh, text: 'No grades yet');
    }

    return RefreshIndicator(
      onRefresh: svc.refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          for (final entry in byClass.entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ClassSection(
                title: classNames[entry.key] ?? 'Class',
                exams: entry.value,
                myGrades: myGrades,
              ),
            ),
        ],
      ),
    );
  }
}

class _ClassSection extends StatelessWidget {
  final String title;
  final List<ExamDto> exams;
  final Map<String, GradeDto> myGrades;
  const _ClassSection({required this.title, required this.exams, required this.myGrades});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;

    double ws = 0, ss = 0;
    for (final e in exams) {
      final g = myGrades[e.id];
      if (g == null || !isGraded(g.score)) continue;
      final w = (g.weighting ?? 1).toDouble();
      ws += w;
      ss += g.score!.toDouble() * w;
    }
    final avg = ws > 0 ? ss / ws : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(title, style: typography.base.copyWith(fontWeight: FontWeight.w600))),
              if (avg != null)
                Text('⌀ ${formatGrade(avg)}',
                    style: typography.sm.copyWith(color: gradeColor(context, avg), fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        for (final e in exams)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: FTile(
              title: Text(e.name ?? 'Exam'),
              subtitle: Text([
                if ((myGrades[e.id]?.weighting ?? 1) != 1) 'weight ${formatGrade(myGrades[e.id]!.weighting ?? 1)}',
                'class ⌀ ${formatGrade(e.classAverage)}',
              ].join(' · ')),
              suffix: GradePill(myGrades[e.id]?.score),
            ),
          ),
      ],
    );
  }
}

class _ReportsView extends StatelessWidget {
  const _ReportsView();

  @override
  Widget build(BuildContext context) {
    final svc = SchoolDataService.instance;
    final reports = svc.reports.toList()
      ..sort((a, b) {
        final y = b.schoolYearStart.compareTo(a.schoolYearStart);
        return y != 0 ? y : b.semesterHalf.compareTo(a.semesterHalf);
      });

    if (reports.isEmpty) {
      return _RefreshableEmpty(onRefresh: svc.refresh, text: 'No reports yet');
    }

    return RefreshIndicator(
      onRefresh: svc.refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          for (final r in reports)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ReportCard(r),
            ),
        ],
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final SemesterReportDto report;
  const _ReportCard(this.report);

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final r = report;
    final half = r.semesterHalf == 2 ? 'FS' : 'HS';
    final period = '$half ${r.schoolYearStart}';
    final promoted = (r.promotionDecision ?? '').toLowerCase().contains('promo') ||
        (r.promotionDecision ?? '').toLowerCase().contains('beförder') ||
        (r.promotionDecision ?? '').toLowerCase().contains('bestanden');
    final promoColor = (r.promotionDecision?.isEmpty ?? true)
        ? colors.mutedForeground
        : (promoted ? const Color(0xFF22C55E) : colors.destructive);

    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text([r.className, period].where((s) => (s ?? '').isNotEmpty).join(' · '),
                      style: typography.base.copyWith(fontWeight: FontWeight.w700)),
                ),
                if (isGraded(r.gradeAverage))
                  Text('⌀ ${formatGrade(r.gradeAverage!)}',
                      style: typography.lg.copyWith(
                          fontWeight: FontWeight.w700, color: gradeColor(context, r.gradeAverage!))),
              ],
            ),
            if (r.promotionDecision?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: promoColor.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(r.promotionDecision!,
                        style: TextStyle(color: promoColor, fontWeight: FontWeight.w600, fontSize: 12)),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Absences: ${r.totalAbsences ?? 0} total · ${r.excusedAbsences ?? 0} excused · ${r.unexcusedAbsences ?? 0} unexcused',
                style: typography.sm.copyWith(color: colors.mutedForeground),
              ),
            ),
            for (final s in (r.subjects ?? const <SemesterSubjectGradeDto>[]))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(s.subjectName ?? '—', style: typography.sm)),
                    if (isGraded(s.grade))
                      Text(formatGrade(s.grade!),
                          style: typography.sm.copyWith(
                              fontWeight: FontWeight.w700, color: gradeColor(context, s.grade!))),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RefreshableEmpty extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final String text;
  const _RefreshableEmpty({required this.onRefresh, required this.text});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 360,
            child: Center(child: Text(text, style: TextStyle(color: colors.mutedForeground))),
          ),
        ],
      ),
    );
  }
}
