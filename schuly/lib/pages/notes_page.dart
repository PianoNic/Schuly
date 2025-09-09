import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/grade_tile.dart';
import '../providers/api_store.dart';
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
              children: gradesBySubject.entries.map((entry) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.key, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        ...entry.value.map((grade) => GradeTile(
                              subject: grade.title,
                              grade: grade.mark,
                              date: grade.date,
                              confirmed: grade.isConfirmed,
                            )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}