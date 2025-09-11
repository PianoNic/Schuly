import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onDateChanged;
  final Set<DateTime> datesWithEvents;

  const CustomCalendar({
    super.key,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateChanged,
    this.datesWithEvents = const {},
  });

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _currentMonth;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(widget.selectedDate.year, widget.selectedDate.month);
    _pageController = PageController(
      initialPage: _monthsBetween(widget.firstDate, _currentMonth),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _monthsBetween(DateTime start, DateTime end) {
    return (end.year - start.year) * 12 + end.month - start.month;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _hasEvent(DateTime date) {
    return widget.datesWithEvents.any((eventDate) => _isSameDay(eventDate, date));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        SizedBox(
          height: 262,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _monthsBetween(widget.firstDate, widget.lastDate) + 1,
            onPageChanged: (index) {
              setState(() {
                _currentMonth = DateTime(
                  widget.firstDate.year,
                  widget.firstDate.month + index,
                );
              });
            },
            itemBuilder: (context, index) {
              final month = DateTime(
                widget.firstDate.year,
                widget.firstDate.month + index,
              );
              return _buildMonthView(month);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final appColors = Theme.of(context).extension<AppColors>();
    final seedColor = appColors?.seedColor ?? Theme.of(context).colorScheme.primary;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            icon: Icon(Icons.chevron_left, color: seedColor),
          ),
          Text(
            '${_getMonthName(_currentMonth.month)} ${_currentMonth.year}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          IconButton(
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            icon: Icon(Icons.chevron_right, color: seedColor),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthView(DateTime month) {
    return Column(
      children: [
        // Weekday headers
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'].map((day) =>
              Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ).toList(),
          ),
        ),
        const SizedBox(height: 4),
        // Calendar table
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildCalendarTable(month),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarTable(DateTime month) {
    final List<List<DateTime?>> calendarData = _generateCalendarData(month);
    
    return Table(
      children: calendarData.map((week) {
        return TableRow(
          children: week.map((date) {
            if (date == null) {
              return AspectRatio(
                aspectRatio: 1.0,
                child: Container(),
              );
            }
            return AspectRatio(
              aspectRatio: 1.0,
              child: _buildDayCell(date, date.month == month.month),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  List<List<DateTime?>> _generateCalendarData(DateTime month) {
  final List<List<DateTime?>> weeks = [];
  
  // Use UTC to avoid DST issues, or force time to noon
  final firstDay = DateTime(month.year, month.month, 1, 12); // noon
  
  DateTime current = firstDay;
  while (current.weekday != 1) {
    current = current.subtract(const Duration(days: 1));
    current = DateTime(current.year, current.month, current.day, 12); // keep noon
  }
  
  while (weeks.isEmpty || (weeks.last.any((date) => date?.month == month.month) && weeks.length < 6)) {
    final List<DateTime?> week = [];
    
    for (int i = 0; i < 7; i++) {
      final date = DateTime(current.year, current.month, current.day + i, 12);
      week.add(date);
    }
    
    weeks.add(week);
    current = DateTime(current.year, current.month, current.day + 7, 12);
  }
  
  return weeks;
}

  Widget _buildDayCell(DateTime date, bool isCurrentMonth) {
    final isSelected = _isSameDay(date, widget.selectedDate);
    final isToday = _isSameDay(date, DateTime.now());
    final hasEvent = _hasEvent(date);
    final appColors = Theme.of(context).extension<AppColors>();
    final seedColor = appColors?.seedColor ?? Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: isCurrentMonth ? () => widget.onDateChanged(date) : null,
      child: Container(
        margin: const EdgeInsets.all(0.5),
        decoration: BoxDecoration(
          color: isSelected
              ? seedColor
              : null,
          border: isToday
              ? Border.all(
                  color: seedColor,
                  width: 2,
                )
              : null,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                date.day.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : isCurrentMonth
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                  fontWeight: isToday ? FontWeight.bold : null,
                ),
              ),
            ),
            if (hasEvent && isCurrentMonth)
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : seedColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Januar', 'Februar', 'März', 'April', 'Mai', 'Juni',
      'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'
    ];
    return months[month - 1];
  }
}