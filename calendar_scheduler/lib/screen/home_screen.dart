import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/constant/colors.dart';
import 'package:calendar_scheduler/database/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.now().toUtc();
  DateTime focusedDay = DateTime.now().toUtc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet<ScheduleTable>(
            context: context,
            builder: (_) => ScheduleBottomSheet(
              selectedDay: selectedDay,
            ),
          );

          setState(() {});
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
                child: FutureBuilder<List<ScheduleTableData>>(
                  future: GetIt.I<AppDatabase>().getSchedules(selectedDay),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                        ),
                      );
                    }

                    if (!snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final schedules = snapshot.data!;

                    return ListView.separated(
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        // final selectedSchedules = schedules[selectedDay]!;
                        // final scheduleModel = selectedSchedules[index];

                        final schedule = schedules[index];

                        return Dismissible(
                          key: ObjectKey(schedule.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {},
                          child: ScheduleCard(
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.content,
                            color: Color(
                              int.parse(
                                'FF${schedule.color}',
                                radix: 16,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (content, index) {
                        return const SizedBox(
                          height: 8.0,
                        );
                      },
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
