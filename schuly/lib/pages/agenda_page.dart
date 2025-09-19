import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/agenda_item.dart';
import '../widgets/custom_calendar.dart';
import '../providers/api_store.dart';
import '../l10n/app_localizations.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  DateTime _selectedDay = DateTime.now();

  Set<DateTime> _getDatesWithEvents(List<dynamic>? agenda) {
    if (agenda == null) return {};
    
    final datesWithEvents = <DateTime>{};
    for (final item in agenda) {
      final start = DateTime.tryParse(item.startDate);
      if (start != null) {
        datesWithEvents.add(DateTime(start.year, start.month, start.day));
      }
    }
    return datesWithEvents;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Consumer<ApiStore>(
      builder: (context, apiStore, _) {
        final agenda = apiStore.agenda;
        return RefreshIndicator(
          onRefresh: () async {
            await apiStore.fetchAgenda(forceRefresh: true);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: CustomCalendar(
                    selectedDate: _selectedDay,
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    datesWithEvents: _getDatesWithEvents(agenda),
                    onDateChanged: (date) {
                      setState(() {
                        _selectedDay = date;
                      });
                    },
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          localizations.agendaForDate(_selectedDay.day, _selectedDay.month, _selectedDay.year), // TODO: Add agendaForDate to ARB
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        if (agenda == null)
                          const Center(child: CircularProgressIndicator())
                        else ...[
                          // Filter agenda for selected day
                          ...agenda.where((a) {
                            final start = DateTime.tryParse(a.startDate);
                            return start != null &&
                              start.year == _selectedDay.year &&
                              start.month == _selectedDay.month &&
                              start.day == _selectedDay.day;
                          }).map((item) {
                            return AgendaItem(
                              time: '${item.startDate.substring(11, 16)} - ${item.endDate.substring(11, 16)}',
                              subject: item.text,
                              room: item.roomToken,
                              color: Colors.blue, // Optionally parse item.color
                            );
                          }),
                          if (agenda.where((a) {
                            final start = DateTime.tryParse(a.startDate);
                            return start != null &&
                              start.year == _selectedDay.year &&
                              start.month == _selectedDay.month &&
                              start.day == _selectedDay.day;
                          }).isEmpty)
                            Center(child: Text(localizations.noAgendaForDay)), // TODO: Add noAgendaForDay to ARB
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// TODO: Add agendaForDate (with params), noAgendaForDay to ARB files