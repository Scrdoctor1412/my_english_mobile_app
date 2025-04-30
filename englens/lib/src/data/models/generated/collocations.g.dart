// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../collocations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollocationsAdapter extends TypeAdapter<Collocations> {
  @override
  final int typeId = 10;

  @override
  Collocations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Collocations(
      title: fields[0] as String,
      lessons: (fields[1] as List?)?.cast<Lesson>(),
    );
  }

  @override
  void write(BinaryWriter writer, Collocations obj) {
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
      other is CollocationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
