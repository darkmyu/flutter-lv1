import 'package:calendar_scheduler/database/drift.dart';

class ScheduleWithCategory {
  final CategoryTableData categoryTable;
  final ScheduleTableData scheduleTable;

  ScheduleWithCategory({
    required this.categoryTable,
    required this.scheduleTable,
  });
}
