// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      img: fields[0] as String?,
      fName: fields[1] as String?,
      lName: fields[2] as String?,
      email: fields[3] as String?,
      locationLatitude: fields[4] as double?,
      locationLongitude: fields[5] as double?,
      locationString: fields[6] as String?,
      darkTheme: fields[7] as bool?,
      token: fields[8] as String?,
      phone: fields[9] as String?,
      whatsapp: fields[10] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.img)
      ..writeByte(1)
      ..write(obj.fName)
      ..writeByte(2)
      ..write(obj.lName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.locationLatitude)
      ..writeByte(5)
      ..write(obj.locationLongitude)
      ..writeByte(6)
      ..write(obj.locationString)
      ..writeByte(7)
      ..write(obj.darkTheme)
      ..writeByte(8)
      ..write(obj.token)
      ..writeByte(9)
      ..write(obj.phone)
      ..writeByte(10)
      ..write(obj.whatsapp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
