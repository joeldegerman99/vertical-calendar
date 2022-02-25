import 'package:flutter/material.dart';
import 'package:vertical_calendar/src/vertical_calendar_helper.dart';

class VerticalCalendar extends StatefulWidget {
  const VerticalCalendar({Key? key}) : super(key: key);

  @override
  State<VerticalCalendar> createState() => _VerticalCalendarState();
}

class _VerticalCalendarState extends State<VerticalCalendar> {
  final calendarHelper = VerticalCalendarHelper(DateTime.now());

  List<TableRow> _buildCalendarDays() {
    return List.generate(calendarHelper.getRows(), (index) => index * 7)
        .map((index) => TableRow(
              children: List.generate(
                7,
                (id) => Text(calendarHelper
                    .getVisibleDaysInMonth()[index + id]
                    .day
                    .toString()),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      children: _buildCalendarDays(),
    );
  }
}
