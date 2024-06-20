// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcardfile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlashcardClassAdapter extends TypeAdapter<FlashcardClass> {
  @override
  final int typeId = 3;

  @override
  FlashcardClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlashcardClass(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FlashcardClass obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.collectionId)
      ..writeByte(1)
      ..write(obj.cardColor)
      ..writeByte(2)
      ..write(obj.frontside)
      ..writeByte(3)
      ..write(obj.backside);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlashcardClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
