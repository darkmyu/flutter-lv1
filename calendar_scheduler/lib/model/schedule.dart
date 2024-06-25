import 'package:drift/drift.dart';

class ScheduleTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get startTime => integer()();

  IntColumn get endTime => integer()();

  TextColumn get content => text()();

  DateTimeColumn get date => dateTime()();

  TextColumn get color => text()();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();
}
