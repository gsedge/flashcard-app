// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userfile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserClassAdapter extends TypeAdapter<UserClass> {
  @override
  final int typeId = 1;

  @override
  UserClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserClass(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserClass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userID)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
