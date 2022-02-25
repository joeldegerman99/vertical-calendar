import 'package:flutter/material.dart';

class VerticalCalendarHelper {
  static final VerticalCalendarHelper _instance = VerticalCalendarHelper._internal();

  factory VerticalCalendarHelper(DateTime date) {
    _instance.date = date;
    return _instance;
  }

  VerticalCalendarHelper._internal();

  late DateTime date;

  DateTime _getFirstDayInMonth(DateTime date) =>
      DateTime(date.year, date.month, 1);

  DateTime _getLastDayInMonth(DateTime date) =>
      DateTime(date.year, date.month + 1, 0);

  DateTime _getFirstDateVisible(DateTime date) {
    final firstDayInMonth = _getFirstDayInMonth(date);
    return firstDayInMonth
        .subtract(Duration(days: firstDayInMonth.weekday - 1));
  }

  DateTime _getLastDateVisible(DateTime date) {
    final lastDayInMonth = _getLastDayInMonth(date);
    return lastDayInMonth
        .add(Duration(days: DateTime.daysPerWeek - lastDayInMonth.weekday));
  }

  DateTimeRange _getVisibleDaysInMonth(DateTime date) {
    date = _toUtc(date);
    final firstDayOnCalendar = _getFirstDateVisible(date);
    final lastDayOnCalendar = _getLastDateVisible(date);

    return DateTimeRange(start: firstDayOnCalendar, end: lastDayOnCalendar);
  }

  List<DateTime> getVisibleDaysInMonth() {
    final dateRange = _getVisibleDaysInMonth(date);
    List<DateTime> dates = [];

    final amountOfDays = dateRange.end.difference(dateRange.start).inDays + 1;
    dates = List.generate(
      amountOfDays,
      (index) => DateTime.utc(dateRange.start.year, dateRange.start.month,
          dateRange.start.day + index),
    );
    return dates;
  }

  int getRows() {
    return getVisibleDaysInMonth().length ~/7;
  }

  DateTime _toUtc(DateTime date) {
    return DateTime(date.year, date.month, date.day).toUtc();
  }
}
