import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wewallet/Products/repository/provider/Products.provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CalendarFormat calendarFormat = CalendarFormat.month;
    return TableCalendar(
      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
        titleCentered: true,
        formatButtonVisible: false,
      ),
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2023, 12, 31),
      focusedDay: DateTime.now(),
      calendarFormat: calendarFormat,
      calendarStyle: const CalendarStyle(
        todayTextStyle: TextStyle(
          color: Color(0xFFFAFAFA),
          fontSize: 16.0,
        ),
      ),
      onPageChanged: (format) {
        ref
            .read(monthProivder.notifier)
            .update((state) => state = format.month);
      },
    );
  }
}
