// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notepad_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotepadModelAdapter extends TypeAdapter<NotepadModel> {
  @override
  final int typeId = 0;

  @override
  NotepadModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotepadModel(
      name: fields[0] as String?,
      surname: fields[1] as String?,
      age: fields[2] as int?,
      text: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotepadModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.surname)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotepadModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
