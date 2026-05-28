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

String formatGrade(num grade) {
  final s = grade.toStringAsFixed(2);
  return s.endsWith('00')
      ? grade.toStringAsFixed(0)
      : (s.endsWith('0') ? grade.toStringAsFixed(1) : s);
}
