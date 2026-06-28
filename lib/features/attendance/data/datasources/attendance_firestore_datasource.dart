import 'package:attendance_tracker/features/attendance/domain/entities/attendance_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract interface class AttendanceFirestoreDatasource {
  Future<void> createLog(AttendanceLog log);
  Future<AttendanceLog?> getLatestLog(String userId);
  Future<List<AttendanceLog>> getUserLogs({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 50,
    DocumentSnapshot<Map<String, dynamic>>? startAfter,
  });
  Future<List<AttendanceLog>> getAllLogs({
    DateTime? startDate,
    DateTime? endDate,
    String? userId,
    int limit = 50,
    DocumentSnapshot<Map<String, dynamic>>? startAfter,
  });
  Future<int> countUsers();
  Future<int> countTodayLogs(AttendanceType type);
}

@Injectable(as: AttendanceFirestoreDatasource)
class AttendanceFirestoreDatasourceImpl implements AttendanceFirestoreDatasource {
  AttendanceFirestoreDatasourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;
  static const _logsCollection = 'attendance_logs';
  static const _usersCollection = 'users';

  @override
  Future<void> createLog(AttendanceLog log) async {
    await _firestore.collection(_logsCollection).doc(log.id).set({
      'userId': log.userId,
      'userName': log.userName,
      'type': log.type.firestoreValue,
      'timestamp': Timestamp.fromDate(log.timestamp),
      'latitude': log.latitude,
      'longitude': log.longitude,
      'address': log.address,
    });
  }

  @override
  Future<AttendanceLog?> getLatestLog(String userId) async {
    final snapshot = await _firestore
        .collection(_logsCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    }
    return _mapLog(snapshot.docs.first);
  }

  @override
  Future<List<AttendanceLog>> getUserLogs({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 50,
    DocumentSnapshot<Map<String, dynamic>>? startAfter,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection(_logsCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true);

    if (startDate != null) {
      query = query.where(
        'timestamp',
        isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
      );
    }
    if (endDate != null) {
      query = query.where(
        'timestamp',
        isLessThanOrEqualTo: Timestamp.fromDate(endDate),
      );
    }

    query = query.limit(limit);
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();
    return snapshot.docs.map(_mapLog).toList();
  }

  @override
  Future<List<AttendanceLog>> getAllLogs({
    DateTime? startDate,
    DateTime? endDate,
    String? userId,
    int limit = 50,
    DocumentSnapshot<Map<String, dynamic>>? startAfter,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection(_logsCollection)
        .orderBy('timestamp', descending: true);

    if (userId != null) {
      query = query.where('userId', isEqualTo: userId);
    }
    if (startDate != null) {
      query = query.where(
        'timestamp',
        isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
      );
    }
    if (endDate != null) {
      query = query.where(
        'timestamp',
        isLessThanOrEqualTo: Timestamp.fromDate(endDate),
      );
    }

    query = query.limit(limit);
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();
    return snapshot.docs.map(_mapLog).toList();
  }

  @override
  Future<int> countUsers() async {
    final snapshot = await _firestore.collection(_usersCollection).get();
    return snapshot.docs.length;
  }

  @override
  Future<int> countTodayLogs(AttendanceType type) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final snapshot = await _firestore
        .collection(_logsCollection)
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('timestamp', isLessThan: Timestamp.fromDate(endOfDay))
        .get();

    return snapshot.docs
        .where((doc) => doc.data()['type'] == type.firestoreValue)
        .length;
  }

  AttendanceLog _mapLog(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return AttendanceLog(
      id: doc.id,
      userId: data['userId'] as String,
      userName: data['userName'] as String? ?? '',
      type: AttendanceType.fromFirestore(data['type'] as String?),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      latitude: (data['latitude'] as num).toDouble(),
      longitude: (data['longitude'] as num).toDouble(),
      address: data['address'] as String?,
    );
  }
}
