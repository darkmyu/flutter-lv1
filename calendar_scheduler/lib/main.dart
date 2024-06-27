import 'package:calendar_scheduler/constant/colors.dart';
import 'package:calendar_scheduler/database/drift.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = AppDatabase();

  await database.createSchedule(
    ScheduleTableCompanion(
      startTime: const Value(12),
      endTime: const Value(12),
      content: const Value('Flutter Study'),
      date: Value(DateTime.utc(2024, 6, 27)),
      color: Value(categoryColors.first),
    ),
  );

  final response = await database.getSchedules();
  print(response);

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: const HomeScreen(),
    ),
  );
}
