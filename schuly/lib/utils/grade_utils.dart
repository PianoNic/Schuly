import 'package:flutter/material.dart';

class GradeUtils {
  static Color getGradeColor(double grade) {
    if (grade >= 5.5) return Colors.green[600]!;
    if (grade >= 4.5) return Colors.orange[600]!;
    return Colors.red[600]!;
  }
}