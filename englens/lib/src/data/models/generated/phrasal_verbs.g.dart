// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../phrasal_verbs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhrasalVerbsAdapter extends TypeAdapter<PhrasalVerbs> {
  @override
  final int typeId = 12;

  @override
  PhrasalVerbs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhrasalVerbs(
      title: fields[0] as String,
      lessons: (fields[1] as List?)?.cast<Lesson>(),
    );
  }

  @override
  void write(BinaryWriter writer, PhrasalVerbs obj) {
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
      other is PhrasalVerbsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
