import 'package:flutter/material.dart';
import 'package:schuly/api/lib/api.dart';

class GradeUtils {
  static Color getGradeColor(double grade) {
    if (grade > 5.0) return Colors.green[600]!;
    if (grade >= 4.0) return Colors.yellow[700]!;
    return Colors.red[600]!;
  }

  /// Calculate weighted average for a list of grades
  static double? calculateWeightedAverage(List<GradeDto> grades) {
    if (grades.isEmpty) {
      print('No grades provided');
      return null;
    }
    
    print('Total grades: ${grades.length}');
    
    // Filter only confirmed grades
    final confirmedGrades = grades.where((grade) => grade.isConfirmed).toList();
    print('Confirmed grades: ${confirmedGrades.length}');
    
    // If no confirmed grades, try with all grades as fallback
    final gradesToUse = confirmedGrades.isNotEmpty ? confirmedGrades : grades;
    
    double totalWeightedGrades = 0.0;
    double totalWeight = 0.0;
    
    for (final grade in gradesToUse) {
      print('Processing grade: mark=${grade.mark}, weight=${grade.weight}, confirmed=${grade.isConfirmed}');
      
      final gradeValue = double.tryParse(grade.mark);
      final weightValue = double.tryParse(grade.weight);
      
      print('Parsed values: gradeValue=$gradeValue, weightValue=$weightValue');
      
      if (gradeValue != null && weightValue != null && weightValue > 0) {
        totalWeightedGrades += gradeValue * weightValue;
        totalWeight += weightValue;
        print('Added to calculation: totalWeightedGrades=$totalWeightedGrades, totalWeight=$totalWeight');
      }
    }
    
    if (totalWeight == 0) {
      print('Total weight is 0, returning null');
      return null;
    }
    
    final result = totalWeightedGrades / totalWeight;
    print('Final average: $result');
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