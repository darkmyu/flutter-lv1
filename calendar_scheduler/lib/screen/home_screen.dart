import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/constant/colors.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.now().toUtc();
  DateTime focusedDay = DateTime.now().toUtc();

  Map<DateTime, List<Schedule>> schedules = {
    DateTime.utc(2024, 6, 9): [
      Schedule(
        id: 1,
        startTime: 11,
        endTime: 12,
        content: 'Flutter Study',
        date: DateTime.utc(2024, 6, 9),
        color: categoryColors[0],
        createdAt: DateTime.now().toUtc(),
      ),
      Schedule(
        id: 2,
        startTime: 14,
        endTime: 16,
        content: 'NestJS Study',
        date: DateTime.utc(2024, 6, 9),
        color: categoryColors[3],
        createdAt: DateTime.now().toUtc(),
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => const ScheduleBottomSheet(),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
              selectedDayPredicate: selectedDayPredicate,
            ),
            TodayBanner(
              selectedDay: selectedDay,
              taskCount: 0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: ListView.separated(
                  itemCount: schedules.containsKey(selectedDay)
                      ? schedules[selectedDay]!.length
                      : 0,
                  itemBuilder: (context, index) {
                    final selectedSchedules = schedules[selectedDay]!;
                    final scheduleModel = selectedSchedules[index];

                    return ScheduleCard(
                      startTime: scheduleModel.startTime,
                      endTime: scheduleModel.endTime,
                      content: scheduleModel.content,
                      color: Color(
                        int.parse(
                          'FF${scheduleModel.color}',
                          radix: 16,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (content, index) {
                    return const SizedBox(
                      height: 8.0,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(selectedDay, focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(DateTime date) {
    return date.isAtSameMomentAs(selectedDay);
  }
}
