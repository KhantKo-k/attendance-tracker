import 'package:attendance_tracker/core/error/error_handler_guard.dart';
import 'package:attendance_tracker/core/error/exceptions.dart';
import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/core/services/connectivity_service.dart';
import 'package:attendance_tracker/core/services/location_service.dart';
import 'package:attendance_tracker/core/storage/hive/schema.dart';
import 'package:attendance_tracker/features/attendance/data/datasources/attendance_firestore_datasource.dart';
import 'package:attendance_tracker/features/attendance/data/datasources/attendance_local_datasource.dart';
import 'package:attendance_tracker/features/attendance/domain/entities/attendance_entities.dart';
import 'package:attendance_tracker/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:attendance_tracker/shared/utils/uuid.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AttendanceRepository)
class AttendanceRepositoryImpl implements AttendanceRepository {
  AttendanceRepositoryImpl({
    required AttendanceFirestoreDatasource firestoreDatasource,
    required AttendanceLocalDatasource localDatasource,
    required LocationService locationService,
    required ConnectivityService connectivityService,
  }) : _firestoreDatasource = firestoreDatasource,
       _localDatasource = localDatasource,
       _locationService = locationService,
       _connectivityService = connectivityService;

  final AttendanceFirestoreDatasource _firestoreDatasource;
  final AttendanceLocalDatasource _localDatasource;
  final LocationService _locationService;
  final ConnectivityService _connectivityService;

  @override
  Future<Either<AttendanceStatus, Failure>> getAttendanceStatus(
    String userId,
  ) async {
    return ErrorHandlerGuard.on<AttendanceStatus>(() async {
      final latest = await _firestoreDatasource.getLatestLog(userId);
      final pending = await _localDatasource.getPendingLogs();
      final userPending = pending.where((log) => log.userId == userId).toList();
      final todayLogs = await _getTodayLogs(userId, userPending);

      var isCheckedIn = latest?.type == AttendanceType.checkIn;
      for (final pendingLog in userPending) {
        if (pendingLog.type == AttendanceType.checkIn.firestoreValue) {
          isCheckedIn = true;
        } else if (pendingLog.type == AttendanceType.checkOut.firestoreValue) {
          isCheckedIn = false;
        }
      }

      final hasCheckedInToday = todayLogs.any(
        (log) => log.type == AttendanceType.checkIn,
      );
      final hasCheckedOutToday = todayLogs.any(
        (log) => log.type == AttendanceType.checkOut,
      );
      final openSessionFromPriorDay =
          isCheckedIn &&
          latest != null &&
          latest.type == AttendanceType.checkIn &&
          !_isSameCalendarDay(latest.timestamp, DateTime.now());

      return AttendanceStatus(
        isCheckedIn: isCheckedIn,
        hasCheckedInToday: hasCheckedInToday,
        hasCheckedOutToday: hasCheckedOutToday,
        openSessionFromPriorDay: openSessionFromPriorDay,
        lastLog: latest,
      );
    });
  }

  @override
  Future<Either<AttendanceLog, Failure>> checkIn({
    required String userId,
    required String userName,
  }) async {
    return _recordAttendance(
      userId: userId,
      userName: userName,
      type: AttendanceType.checkIn,
    );
  }

  @override
  Future<Either<AttendanceLog, Failure>> checkOut({
    required String userId,
    required String userName,
  }) async {
    return _recordAttendance(
      userId: userId,
      userName: userName,
      type: AttendanceType.checkOut,
    );
  }

  @override
  Future<Either<List<AttendanceLog>, Failure>> getUserHistory(
    String userId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return ErrorHandlerGuard.on<List<AttendanceLog>>(() async {
      final remoteLogs = await _firestoreDatasource.getUserLogs(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );
      final pending = await _localDatasource.getPendingLogs();
      final pendingLogs = pending
          .where((log) => log.userId == userId)
          .map(
            (log) => AttendanceLog(
              id: log.id,
              userId: log.userId,
              userName: log.userName,
              type: AttendanceType.fromFirestore(log.type),
              timestamp: log.timestamp,
              latitude: log.latitude,
              longitude: log.longitude,
              address: log.address,
              isPending: true,
            ),
          )
          .toList();

      final logs = [...remoteLogs, ...pendingLogs]
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return logs;
    });
  }

  @override
  Future<Either<void, Failure>> syncPendingLogs() async {
    return ErrorHandlerGuard.on<void>(() async {
      if (!await _connectivityService.isOnline()) {
        return;
      }

      final pending = await _localDatasource.getPendingLogs();
      for (final pendingLog in pending) {
        final log = AttendanceLog(
          id: pendingLog.id,
          userId: pendingLog.userId,
          userName: pendingLog.userName,
          type: AttendanceType.fromFirestore(pendingLog.type),
          timestamp: pendingLog.timestamp,
          latitude: pendingLog.latitude,
          longitude: pendingLog.longitude,
          address: pendingLog.address,
        );
        await _firestoreDatasource.createLog(log);
        await _localDatasource.deletePendingLog(pendingLog.id);
      }
    });
  }

  Future<Either<AttendanceLog, Failure>> _recordAttendance({
    required String userId,
    required String userName,
    required AttendanceType type,
  }) async {
    return ErrorHandlerGuard.on<AttendanceLog>(() async {
      final statusResult = await getAttendanceStatus(userId);
      final status = statusResult.fold((value) => value, (_) {
        throw StateError('Unable to read attendance status');
      });

      _validateAttendanceAction(type: type, status: status);

      final location = await _locationService.getCurrentLocation();
      final log = AttendanceLog(
        id: uuid.v4(),
        userId: userId,
        userName: userName,
        type: type,
        timestamp: DateTime.now(),
        latitude: location.latitude,
        longitude: location.longitude,
        address: location.address,
      );

      if (await _connectivityService.isOnline()) {
        await _firestoreDatasource.createLog(log);
      } else {
        await _localDatasource.savePendingLog(
          PendingAttendanceLog(
            id: log.id,
            userId: log.userId,
            userName: log.userName,
            type: log.type.firestoreValue,
            timestamp: log.timestamp,
            latitude: log.latitude,
            longitude: log.longitude,
            address: log.address,
          ),
        );
        return AttendanceLog(
          id: log.id,
          userId: log.userId,
          userName: log.userName,
          type: log.type,
          timestamp: log.timestamp,
          latitude: log.latitude,
          longitude: log.longitude,
          address: log.address,
          isPending: true,
        );
      }

      return log;
    });
  }

  void _validateAttendanceAction({
    required AttendanceType type,
    required AttendanceStatus status,
  }) {
    if (type == AttendanceType.checkIn) {
      if (status.isCheckedIn) {
        throw AttendanceRuleException(
          violation: AttendanceRuleViolation.alreadyCheckedIn,
          stackTrace: StackTrace.current,
        );
      }
      if (status.hasCheckedInToday) {
        throw AttendanceRuleException(
          violation: AttendanceRuleViolation.alreadyCheckedInToday,
          stackTrace: StackTrace.current,
        );
      }
      return;
    }

    if (!status.isCheckedIn) {
      throw AttendanceRuleException(
        violation: AttendanceRuleViolation.notCheckedIn,
        stackTrace: StackTrace.current,
      );
    }
    if (!status.canCheckOut) {
      throw AttendanceRuleException(
        violation: AttendanceRuleViolation.alreadyCheckedOutToday,
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<List<AttendanceLog>> _getTodayLogs(
    String userId,
    List<PendingAttendanceLog> userPending,
  ) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    final remoteLogs = await _firestoreDatasource.getUserLogs(
      userId: userId,
      startDate: startOfDay,
      endDate: endOfDay,
    );

    final pendingLogs = userPending
        .where((log) => _isSameCalendarDay(log.timestamp, now))
        .map(
          (log) => AttendanceLog(
            id: log.id,
            userId: log.userId,
            userName: log.userName,
            type: AttendanceType.fromFirestore(log.type),
            timestamp: log.timestamp,
            latitude: log.latitude,
            longitude: log.longitude,
            address: log.address,
            isPending: true,
          ),
        )
        .toList();

    return [...remoteLogs, ...pendingLogs];
  }

  bool _isSameCalendarDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
