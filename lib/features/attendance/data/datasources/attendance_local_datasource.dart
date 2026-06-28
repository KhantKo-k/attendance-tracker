import 'package:attendance_tracker/core/storage/hive/schema.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

abstract interface class AttendanceLocalDatasource {
  Future<List<PendingAttendanceLog>> getPendingLogs();
  Future<void> savePendingLog(PendingAttendanceLog log);
  Future<void> deletePendingLog(String id);
}

@Injectable(as: AttendanceLocalDatasource)
class AttendanceLocalDatasourceImpl implements AttendanceLocalDatasource {
  AttendanceLocalDatasourceImpl({required Box<PendingAttendanceLog> pendingBox})
    : _pendingBox = pendingBox;

  final Box<PendingAttendanceLog> _pendingBox;

  @override
  Future<List<PendingAttendanceLog>> getPendingLogs() async {
    return _pendingBox.values.toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  @override
  Future<void> savePendingLog(PendingAttendanceLog log) async {
    await _pendingBox.put(log.id, log);
  }

  @override
  Future<void> deletePendingLog(String id) async {
    await _pendingBox.delete(id);
  }
}
