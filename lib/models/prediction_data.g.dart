// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PredictionDataAdapter extends TypeAdapter<PredictionData> {
  @override
  final int typeId = 0;

  @override
  PredictionData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PredictionData(
      prediction: fields[0] as String?,
      dateTime: fields[1] as DateTime?,
      imageName: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PredictionData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.prediction)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.imageName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PredictionDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
