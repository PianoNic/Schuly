import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';

class HolidayTile extends StatelessWidget {
  final String name;
  final String from;
  final String to;

  const HolidayTile({
    super.key,
    required this.name,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final seedColor = appColors?.seedColor ?? Theme.of(context).colorScheme.primary;
    final lightBackground = appColors?.lightBackground ?? seedColor.withValues(alpha: 0.1);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lightBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: seedColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.beach_access, color: seedColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('$from - $to'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}