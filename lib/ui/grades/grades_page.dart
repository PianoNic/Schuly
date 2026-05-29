import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../services/school_data_service.dart';
import '../core/grade_color.dart';

/// Grades grouped by class. Each class is an accordion section showing the
/// user's exams with their score, the exam weighting, and the class average.
class GradesPage extends StatelessWidget {
  const GradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final svc = SchoolDataService.instance;
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final myGrades = svc.myGradesByExam;

    // Group the user's graded exams by class.
    final byClass = <String, List<ExamDto>>{};
    for (final e in svc.exams) {
      if (e.id != null && myGrades.containsKey(e.id)) {
        byClass.putIfAbsent(e.classId ?? '—', () => []).add(e);
      }
    }
    // Prefer the friendly ClassDto.name; fall back to the user's class code.
    final classNames = <String?, String?>{
      for (final c in (svc.me?.classes ?? const <UserClassDto>[])) c.classId: c.className,
      ...svc.classNameById,
    };

    // Overall weighted average — only real (graded) scores count.
    double weightSum = 0, scoreSum = 0;
    for (final entry in myGrades.entries) {
      final g = entry.value;
      if (!isGraded(g.score)) continue;
      final w = (g.weighting ?? 1).toDouble();
      weightSum += w;
      scoreSum += g.score!.toDouble() * w;
    }
    final overall = weightSum > 0 ? scoreSum / weightSum : null;

    if (byClass.isEmpty) {
      return RefreshIndicator(
        onRefresh: svc.refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 400,
              child: Center(
                child: Text('No grades yet', style: TextStyle(color: colors.mutedForeground)),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: svc.refresh,
      child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        FCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Overall average', style: typography.base.copyWith(fontWeight: FontWeight.w600)),
                Text(
                  overall == null ? '—' : formatGrade(overall),
                  style: typography.xl2.copyWith(
                    fontWeight: FontWeight.w700,
                    color: overall == null ? colors.foreground : gradeColor(context, overall),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
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
        // Plain class header (no enclosing card).
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

