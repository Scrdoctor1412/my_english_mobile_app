// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../schedule_notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleNotificationAdapter extends TypeAdapter<ScheduleNotification> {
  @override
  final int typeId = 5;

  @override
  ScheduleNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleNotification(
      id: fields[0] as int,
      title: fields[1] as String,
      body: fields[2] as String,
      scheduleDate: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleNotification obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.scheduleDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
