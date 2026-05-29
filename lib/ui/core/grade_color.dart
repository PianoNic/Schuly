import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// Swiss grade scale colouring: 6 best, 1 worst, 4 is the pass mark.
/// ≥5 green, 4–<5 amber, <4 red.
Color gradeColor(BuildContext context, num grade) {
  final colors = context.theme.colors;
  if (grade >= 5) return const Color(0xFF22C55E); // green
  if (grade >= 4) return const Color(0xFFF59E0B); // amber
  return colors.destructive;
}

/// A score is only a real grade when it's on the 1–6 scale. 0/null means the
/// exam exists but isn't graded yet — excluded from averages and shown as "—".
bool isGraded(num? score) => score != null && score > 0;

String formatGrade(num grade) {
  final s = grade.toStringAsFixed(2);
  return s.endsWith('00')
      ? grade.toStringAsFixed(0)
      : (s.endsWith('0') ? grade.toStringAsFixed(1) : s);
}

/// Coloured grade chip. Ungraded (≤0) scores render as a muted "—".
class GradePill extends StatelessWidget {
  final num? score;
  const GradePill(this.score, {super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    if (!isGraded(score)) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: colors.muted,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text('—', style: TextStyle(color: colors.mutedForeground, fontWeight: FontWeight.w700)),
      );
    }
    final c = gradeColor(context, score!);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: c.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(8)),
      child: Text(formatGrade(score!), style: TextStyle(color: c, fontWeight: FontWeight.w700)),
    );
  }
}
