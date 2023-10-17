// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicAdapter extends TypeAdapter<Medic> {
  @override
  final int typeId = 2;

  @override
  Medic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Medic(
      img: fields[0] as Uint8List,
      name: fields[1] as String,
      bar: fields[2] as int?,
      pill: fields[3] as int?,
      date: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Medic obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.img)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.bar)
      ..writeByte(3)
      ..write(obj.pill)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
