// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../eng_proverbs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EngProverbsAdapter extends TypeAdapter<EngProverbs> {
  @override
  final int typeId = 11;

  @override
  EngProverbs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EngProverbs(
      title: fields[0] as String,
      lessons: (fields[1] as List?)?.cast<Lesson>(),
    );
  }

  @override
  void write(BinaryWriter writer, EngProverbs obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.lessons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EngProverbsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
