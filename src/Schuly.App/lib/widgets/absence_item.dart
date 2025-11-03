// widgets/absence_item.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AbsenceItem extends StatelessWidget {
  final String absentFrom;
  final String absentTo;
  final String excuseUntil;
  final String status;
  final String reason;
  final bool isOpen;

  const AbsenceItem({
    super.key,
    required this.absentFrom,
    required this.absentTo,
    required this.excuseUntil,
    required this.status,
    required this.reason,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    Color statusColor;
    IconData statusIcon;
    
    switch (status.toLowerCase()) {
      case 'offen':
        statusColor = Colors.orange;
        statusIcon = Icons.pending;
        break;
      case 'entschuldigt':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'unentschuldigt':
        statusColor = Colors.red;
        statusIcon = Icons.error;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(12),
        childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
        title: Row(
          children: [
            // Abwesend von - with flexible text
            Expanded(
              flex: 2,
              child: Text(
                absentFrom,
                style: const TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 8),
            
            // Abwesend bis - with flexible text
            Expanded(
              flex: 2,
              child: Text(
                absentTo,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 8),
            
            // Entschuldigen bis - with flexible text
            Expanded(
              flex: 2,
              child: Text(
                excuseUntil,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 8),
            
            // Status - with proper constraints
            Expanded(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    statusIcon,
                    color: statusColor,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localizations.details,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            _buildDetailRow('${localizations.reason}:', reason),
                            _buildDetailRow('${localizations.from}:', absentFrom),
                            _buildDetailRow('${localizations.to}:', absentTo),
                            _buildDetailRow('${localizations.excuseUntil}:', excuseUntil),
                            _buildDetailRow('${localizations.status}:', status),
                          ],
                        ),
                      ),
                      if (isOpen) ...[
                        const SizedBox(width: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 120,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  // TODO: Implement excuse functionality
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(localizations.excuseComingSoon),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit, size: 16),
                                label: Text(
                                  localizations.excuse,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.green,
                                  side: const BorderSide(color: Colors.green),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 120,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  _showDeleteDialog(context);
                                },
                                icon: const Icon(Icons.delete, size: 16),
                                label: Text(
                                  localizations.delete,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(color: Colors.red),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localizations.deleteAbsenceTitle),
          content: Text(localizations.deleteAbsenceConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(localizations.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(localizations.absenceDeleted),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(localizations.delete),
            ),
          ],
        );
      },
    );
  }
}