// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../learning_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LearningRecordAdapter extends TypeAdapter<LearningRecord> {
  @override
  final int typeId = 17;

  @override
  LearningRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LearningRecord(
      wordIds: (fields[1] as List?)?.cast<String>(),
      learnDate: fields[2] as String?,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, LearningRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.wordIds)
      ..writeByte(2)
      ..write(obj.learnDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LearningRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
