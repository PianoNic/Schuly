import 'package:flutter/material.dart';
import '../utils/grade_utils.dart';

class GradeTile extends StatelessWidget {
  final String subject;
  final String grade;
  final String date;
  final bool confirmed;

  const GradeTile({
    super.key,
    required this.subject,
    required this.grade,
    required this.date,
    required this.confirmed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: confirmed
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: confirmed
              ? Colors.green.withValues(alpha: 0.1)
              : Colors.orange.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: GradeUtils.getGradeColor(double.parse(grade)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              grade,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(date),
              ],
            ),
          ),
          Icon(
            confirmed ? Icons.check_circle : Icons.pending,
            color: confirmed ? Colors.green : Colors.orange,
          ),
        ],
      ),
    );
  }
}