// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class PendingAttendanceLogAdapter extends TypeAdapter<PendingAttendanceLog> {
  @override
  final typeId = 1;

  @override
  PendingAttendanceLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendingAttendanceLog(
      id: fields[0] as String,
      userId: fields[1] as String,
      userName: fields[2] as String,
      type: fields[3] as String,
      timestamp: fields[4] as DateTime,
      latitude: (fields[5] as num).toDouble(),
      longitude: (fields[6] as num).toDouble(),
      address: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PendingAttendanceLog obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.latitude)
      ..writeByte(6)
      ..write(obj.longitude)
      ..writeByte(7)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingAttendanceLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
