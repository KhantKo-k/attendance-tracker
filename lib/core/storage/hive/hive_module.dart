part of '../../di/service_locator.dart';

const _notesBoxName = 'notes';

@module
abstract class HiveModule {
  @preResolve
  Future<Box<Note>> notesBox() async {
    await Hive.initFlutter();
    Hive.registerAdapters();

    if (!Hive.isBoxOpen(_notesBoxName)) {
      return Hive.openBox<Note>(_notesBoxName);
    }

    return Hive.box<Note>(_notesBoxName);
  }
}
