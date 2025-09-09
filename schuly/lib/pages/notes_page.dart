import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/grade_tile.dart';
import '../providers/api_store.dart';
import '../utils/grade_utils.dart';
import 'package:schuly/api/lib/api.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiStore>(
      builder: (context, apiStore, _) {
        final grades = apiStore.grades;
        if (grades == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (grades.isEmpty) {
          return const Center(child: Text('Keine Noten gefunden.'));
        }
        // Group grades by subject
        final Map<String, List<GradeDto>> gradesBySubject = {};
        for (final grade in grades) {
          gradesBySubject.putIfAbsent(grade.subject, () => []).add(grade);
        }
        return RefreshIndicator(
          onRefresh: () async {
            await apiStore.fetchGrades();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Subject Cards
                ...gradesBySubject.entries.map((entry) {
                  final subjectAverage = GradeUtils.calculateWeightedAverage(entry.value);
                  print('Subject: ${entry.key}, Average: $subjectAverage, Grades count: ${entry.value.length}');
                  
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Subject header with average in top right corner
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 12, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  entry.key, 
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: subjectAverage != null 
                                      ? GradeUtils.getGradeColor(subjectAverage)
                                      : Colors.grey[600],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  subjectAverage != null 
                                      ? GradeUtils.formatGrade(subjectAverage)
                                      : '?',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Grade tiles
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                          child: Column(
                            children: entry.value.map((grade) => GradeTile(
                                  subject: grade.title,
                                  grade: grade.mark,
                                  date: grade.date,
                                  confirmed: grade.isConfirmed,
                                )).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}