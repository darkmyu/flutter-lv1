import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/constant/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return SafeArea(
                bottom: true,
                child: Container(
                  color: Colors.white,
                  height: 600,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: '시작 시간',
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: CustomTextField(
                                label: '마감 시간',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        const Expanded(
                          child: CustomTextField(
                            label: '내용',
                            expand: true,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: categoryColors
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(
                                        int.parse(
                                          'FF$e',
                                          radix: 16,
                                        ),
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    width: 32.0,
                                    height: 32.0,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
                child: ListView(
                  children: const [
                    ScheduleCard(
                      startTime: 12,
                      endTime: 14,
                      content: '프로그래밍 공부하기.',
                      color: Colors.red,
                    )
                  ],
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
