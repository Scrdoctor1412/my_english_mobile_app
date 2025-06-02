// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../lesson.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonAdapter extends TypeAdapter<Lesson> {
  @override
  final int typeId = 7;

  @override
  Lesson read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lesson(
      topic: fields[0] as String,
      title: fields[1] as String,
      lesson: fields[2] as String,
      wordList: (fields[3] as List?)?.cast<Word>(),
      id: fields[4] as String?,
      isBookmarked: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Lesson obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.topic)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.lesson)
      ..writeByte(3)
      ..write(obj.wordList)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.isBookmarked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
