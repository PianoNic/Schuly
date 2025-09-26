import 'package:flutter/material.dart';
import 'package:schuly/api/lib/api.dart';
import 'logger.dart';

class GradeUtils {
  /// Get color for a grade based on configurable thresholds
  static Color getGradeColor(double grade, double redThreshold, double yellowThreshold, bool useColors) {
    if (!useColors) {
      // Return null/default color if colors are disabled
      return Colors.transparent;
    }

    if (grade < redThreshold) {
      return Colors.red;
    } else if (grade < yellowThreshold) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  // Legacy method for backward compatibility
  static Color getGradeColorLegacy(double grade) {
    if (grade > 5.0) return Colors.green[600]!;
    if (grade >= 4.0) return Colors.yellow[700]!;
    return Colors.red[600]!;
  }

  /// Calculate weighted average for a list of grades
  static double? calculateWeightedAverage(List<GradeDto> grades) {
    if (grades.isEmpty) {
      logDebug('No grades provided', source: 'GradeUtils');
      return null;
    }
    
    logDebug('Total grades: ${grades.length}', source: 'GradeUtils');
    
    // Filter only confirmed grades
    final confirmedGrades = grades.where((grade) => grade.isConfirmed).toList();
    logDebug('Confirmed grades: ${confirmedGrades.length}', source: 'GradeUtils');
    
    // If no confirmed grades, try with all grades as fallback
    final gradesToUse = confirmedGrades.isNotEmpty ? confirmedGrades : grades;
    
    double totalWeightedGrades = 0.0;
    double totalWeight = 0.0;
    
    for (final grade in gradesToUse) {
      logDebug('Processing grade: mark=${grade.mark}, weight=${grade.weight}, confirmed=${grade.isConfirmed}', source: 'GradeUtils');
      
      final gradeValue = grade.mark != null ? double.tryParse(grade.mark!) : null;
      final weightValue = double.tryParse(grade.weight);
      
      logDebug('Parsed values: gradeValue=$gradeValue, weightValue=$weightValue', source: 'GradeUtils');
      
      if (gradeValue != null && weightValue != null && weightValue > 0) {
        totalWeightedGrades += gradeValue * weightValue;
        totalWeight += weightValue;
        logDebug('Added to calculation: totalWeightedGrades=$totalWeightedGrades, totalWeight=$totalWeight', source: 'GradeUtils');
      }
    }
    
    if (totalWeight == 0) {
      logDebug('Total weight is 0, returning null', source: 'GradeUtils');
      return null;
    }
    
    final result = totalWeightedGrades / totalWeight;
    logDebug('Final average: $result', source: 'GradeUtils');
    return result;
  }

  /// Calculate overall average across all subjects
  static double? calculateOverallAverage(Map<String, List<GradeDto>> gradesBySubject) {
    if (gradesBySubject.isEmpty) return null;
    
    final subjectAverages = <double>[];
    
    for (final grades in gradesBySubject.values) {
      final average = calculateWeightedAverage(grades);
      if (average != null) {
        subjectAverages.add(average);
      }
    }
    
    if (subjectAverages.isEmpty) return null;
    
    return subjectAverages.reduce((a, b) => a + b) / subjectAverages.length;
  }

  /// Format grade for display (show raw value with all decimals)
  static String formatGrade(double grade) {
    // Show the raw grade value as it is
    String gradeStr = grade.toString();
    // Remove trailing .0 if it's a whole number
    if (gradeStr.endsWith('.0')) {
      gradeStr = gradeStr.substring(0, gradeStr.length - 2);
    }
    return gradeStr;
  }

  /// Round grade to nearest 0.5 for Swiss grading system (Zeugnisnote)
  static double roundToSwissGrade(double grade) {
    // Swiss grading rounds to nearest 0.5
    // Examples: 4.24 -> 4.0, 4.25 -> 4.5, 4.74 -> 4.5, 4.75 -> 5.0
    return (grade * 2).round() / 2;
  }

  /// Format Swiss rounded grade for display
  static String formatSwissGrade(double grade) {
    final rounded = roundToSwissGrade(grade);
    // If it's a whole number, show without decimal (4, 5, 6)
    // Otherwise show with .5 (4.5, 5.5)
    if (rounded == rounded.roundToDouble()) {
      return rounded.toStringAsFixed(0);
    }
    return rounded.toStringAsFixed(1);
  }

  /// Get display grade based on settings
  static String getDisplayGrade(double grade, GradeDisplayMode mode) {
    switch (mode) {
      case GradeDisplayMode.exact:
        return formatGrade(grade);
      case GradeDisplayMode.rounded:
        return formatSwissGrade(grade);
      case GradeDisplayMode.both:
        return '${formatGrade(grade)} (${formatSwissGrade(grade)})';
    }
  }
}

/// Enum for grade display modes
enum GradeDisplayMode {
  exact,    // Show exact grade (e.g., 4.7)
  rounded,  // Show rounded grade (e.g., 4.5)
  both,     // Show both (e.g., 4.7 (4.5))
}