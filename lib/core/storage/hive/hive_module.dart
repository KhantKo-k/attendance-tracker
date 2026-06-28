part of '../../di/service_locator.dart';

const _pendingAttendanceBoxName = 'pending_attendance';

@module
abstract class HiveModule {
  @preResolve
  Future<Box<PendingAttendanceLog>> pendingAttendanceBox() async {
    await Hive.initFlutter();
    Hive.registerAdapters();

    if (!Hive.isBoxOpen(_pendingAttendanceBoxName)) {
      return Hive.openBox<PendingAttendanceLog>(_pendingAttendanceBoxName);
    }

    return Hive.box<PendingAttendanceLog>(_pendingAttendanceBoxName);
  }
}
