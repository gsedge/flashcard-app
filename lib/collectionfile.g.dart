// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collectionfile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectionClassAdapter extends TypeAdapter<CollectionClass> {
  @override
  final int typeId = 2;

  @override
  CollectionClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollectionClass(
      fields[0] as int,
      fields[1] as String,
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CollectionClass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.collectionId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.userBelong);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
