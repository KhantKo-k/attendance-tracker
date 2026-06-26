import 'package:app_starter_kit_bloc/core/storage/hive/schema.dart';
import 'package:hive_ce/hive_ce.dart';

@GenerateAdapters([AdapterSpec<Note>()])
part 'hive_adapters.g.dart';