// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../level_based.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LevelBasedAdapter extends TypeAdapter<LevelBased> {
  @override
  final int typeId = 8;

  @override
  LevelBased read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LevelBased(
      title: fields[0] as String,
      lessons: (fields[1] as List?)?.cast<Lesson>(),
      id: fields[2] as String?,
      isBookmarked: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, LevelBased obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.lessons)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.isBookmarked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelBasedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
