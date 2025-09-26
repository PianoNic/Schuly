import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/grade_tile.dart';
import '../providers/api_store.dart';
import '../utils/grade_utils.dart';
import 'package:schuly/api/lib/api.dart';
import '../l10n/app_localizations.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Consumer<ApiStore>(
      builder: (context, apiStore, _) {
        final grades = apiStore.grades;
        if (grades == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (grades.isEmpty) {
          return Center(child: Text(localizations.noGradesFound));
        }
        // Group grades by subject
        final Map<String, List<GradeDto>> gradesBySubject = {};
        for (final grade in grades) {
          gradesBySubject.putIfAbsent(grade.subject, () => []).add(grade);
        }
        return RefreshIndicator(
          onRefresh: () async {
            await apiStore.fetchGrades(forceRefresh: true);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Subject Cards
                ...gradesBySubject.entries.map((entry) {
                  final subjectAverage = GradeUtils.calculateWeightedAverage(entry.value);
                  
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
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
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  subjectAverage != null
                                      ? GradeUtils.getDisplayGrade(subjectAverage, apiStore.gradeDisplayMode)
                                      : '?',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                            children: entry.value.map((gradeData) => GradeTile(
                                  grade: gradeData,
                                )).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}