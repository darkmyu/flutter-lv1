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

  // Map<DateTime, List<ScheduleTable>> schedules = {
  //   DateTime.utc(2024, 6, 9): [
  //     ScheduleTable(
  //       id: 1,
  //       startTime: 11,
  //       endTime: 12,
  //       content: 'Flutter Study',
  //       date: DateTime.utc(2024, 6, 9),
  //       color: categoryColors[0],
  //       createdAt: DateTime.now().toUtc(),
  //     ),
  //     ScheduleTable(
  //       id: 2,
  //       startTime: 14,
  //       endTime: 16,
  //       content: 'NestJS Study',
  //       date: DateTime.utc(2024, 6, 9),
  //       color: categoryColors[3],
  //       createdAt: DateTime.now().toUtc(),
  //     ),
  //   ],
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final schedule = await showModalBottomSheet<ScheduleTable>(
            context: context,
            builder: (_) => ScheduleBottomSheet(
              selectedDay: selectedDay,
            ),
          );

          if (schedule == null) return;

          // setState(() {
          //   schedules = {
          //     ...schedules,
          //     schedule.date: [
          //       if (schedules.containsKey(schedule.date))
          //         ...schedules[schedule.date]!,
          //       schedule,
          //     ],
          //   };
          // });
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
                  itemCount: 0,
                  itemBuilder: (context, index) {
                    // final selectedSchedules = schedules[selectedDay]!;
                    // final scheduleModel = selectedSchedules[index];

                    return ScheduleCard(
                      startTime: 12,
                      endTime: 14,
                      content: 'test',
                      color: Color(
                        int.parse(
                          'FF000000',
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
