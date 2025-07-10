// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../leitner_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LeitnerBoxAdapter extends TypeAdapter<LeitnerBox> {
  @override
  final int typeId = 15;

  @override
  LeitnerBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LeitnerBox(
      index: fields[0] as int?,
      boxType: fields[1] as LeitnerBoxType?,
      wordIds: (fields[2] as List?)?.cast<String>(),
      lastLearned: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LeitnerBox obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.boxType)
      ..writeByte(2)
      ..write(obj.wordIds)
      ..writeByte(3)
      ..write(obj.lastLearned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeitnerBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LeitnerBoxTypeAdapter extends TypeAdapter<LeitnerBoxType> {
  @override
  final int typeId = 16;

  @override
  LeitnerBoxType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LeitnerBoxType.pending;
      case 1:
        return LeitnerBoxType.everyDay;
      case 2:
        return LeitnerBoxType.every2days;
      case 3:
        return LeitnerBoxType.every4days;
      case 4:
        return LeitnerBoxType.every8days;
      case 5:
        return LeitnerBoxType.every16days;
      case 6:
        return LeitnerBoxType.every32days;
      case 7:
        return LeitnerBoxType.learned;
      default:
        return LeitnerBoxType.pending;
    }
  }

  @override
  void write(BinaryWriter writer, LeitnerBoxType obj) {
    switch (obj) {
      case LeitnerBoxType.pending:
        writer.writeByte(0);
        break;
      case LeitnerBoxType.everyDay:
        writer.writeByte(1);
        break;
      case LeitnerBoxType.every2days:
        writer.writeByte(2);
        break;
      case LeitnerBoxType.every4days:
        writer.writeByte(3);
        break;
      case LeitnerBoxType.every8days:
        writer.writeByte(4);
        break;
      case LeitnerBoxType.every16days:
        writer.writeByte(5);
        break;
      case LeitnerBoxType.every32days:
        writer.writeByte(6);
        break;
      case LeitnerBoxType.learned:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeitnerBoxTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
