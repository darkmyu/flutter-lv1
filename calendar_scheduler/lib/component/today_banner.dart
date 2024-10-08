import 'package:calendar_scheduler/constant/colors.dart';
import 'package:flutter/material.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  final int taskCount;

  const TodayBanner({
    required this.selectedDay,
    required this.taskCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );

    return Container(
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
              style: textStyle,
            ),
            Text(
              '$taskCount개',
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
