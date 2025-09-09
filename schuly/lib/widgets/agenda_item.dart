import 'package:flutter/material.dart';

class AgendaItem extends StatelessWidget {
  final String time;
  final String subject;
  final String room;
  final Color color;

  const AgendaItem({
    super.key,
    required this.time,
    required this.subject,
    required this.room,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(width: 4, height: 50, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subject),
                Text(room, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}