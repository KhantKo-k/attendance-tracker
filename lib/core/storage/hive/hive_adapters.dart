import 'package:attendance_tracker/core/storage/hive/schema.dart';
import 'package:hive_ce/hive_ce.dart';

@GenerateAdapters([AdapterSpec<PendingAttendanceLog>()])
part 'hive_adapters.g.dart';
