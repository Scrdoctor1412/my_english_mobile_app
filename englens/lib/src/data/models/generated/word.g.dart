// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordAdapter extends TypeAdapter<Word> {
  @override
  final int typeId = 2;

  @override
  Word read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Word(
      word: fields[0] as String,
      pos: fields[1] as String,
      phonetic: fields[2] as String,
      phoneticText: fields[3] as String,
      phoneticAm: fields[4] as String,
      phoneticAmText: fields[5] as String,
      senses: (fields[6] as List).cast<Sense>(),
      index: fields[7] as int?,
      img: fields[8] as String?,
      pronunciation: fields[9] as String?,
      id: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.pos)
      ..writeByte(2)
      ..write(obj.phonetic)
      ..writeByte(3)
      ..write(obj.phoneticText)
      ..writeByte(4)
      ..write(obj.phoneticAm)
      ..writeByte(5)
      ..write(obj.phoneticAmText)
      ..writeByte(6)
      ..write(obj.senses)
      ..writeByte(7)
      ..write(obj.index)
      ..writeByte(8)
      ..write(obj.img)
      ..writeByte(9)
      ..write(obj.pronunciation)
      ..writeByte(10)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
