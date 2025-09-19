import 'package:flutter/material.dart';
import 'package:schuly/api/lib/api.dart';
import 'logger.dart';

class GradeUtils {
  static Color getGradeColor(double grade) {
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
      final weightValue = double.tryParse(grade.weight!);
      
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

  /// Format grade for display (1 decimal place)
  static String formatGrade(double grade) {
    return grade.toStringAsFixed(1);
  }
}