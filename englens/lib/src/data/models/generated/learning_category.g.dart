// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../learning_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LearningCategoryAdapter extends TypeAdapter<LearningCategory> {
  @override
  final int typeId = 13;

  @override
  LearningCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LearningCategory(
      title: fields[0] as String,
      lessons: (fields[1] as List?)?.cast<Lesson>(),
      isBookmarked: fields[2] as bool?,
      categoryType: fields[3] as CategoryType?,
      id: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LearningCategory obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.lessons)
      ..writeByte(2)
      ..write(obj.isBookmarked)
      ..writeByte(3)
      ..write(obj.categoryType)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LearningCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryTypeAdapter extends TypeAdapter<CategoryType> {
  @override
  final int typeId = 14;

  @override
  CategoryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CategoryType.idioms;
      case 1:
        return CategoryType.collocations;
      case 2:
        return CategoryType.phraselVerbs;
      case 3:
        return CategoryType.engProverbs;
      case 4:
        return CategoryType.topic;
      case 5:
        return CategoryType.levelBased;
      default:
        return CategoryType.idioms;
    }
  }

  @override
  void write(BinaryWriter writer, CategoryType obj) {
    switch (obj) {
      case CategoryType.idioms:
        writer.writeByte(0);
        break;
      case CategoryType.collocations:
        writer.writeByte(1);
        break;
      case CategoryType.phraselVerbs:
        writer.writeByte(2);
        break;
      case CategoryType.engProverbs:
        writer.writeByte(3);
        break;
      case CategoryType.topic:
        writer.writeByte(4);
        break;
      case CategoryType.levelBased:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
