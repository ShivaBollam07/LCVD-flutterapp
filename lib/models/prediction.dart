import 'package:hive/hive.dart';

part 'prediction.g.dart';

@HiveType(typeId: 0)
class Prediction extends HiveObject {
  @HiveField(1)
  String imageName;

  @HiveField(0)
  final DateTime dateTime;

  @HiveField(2)
  String? prediction;

  @HiveField(3)
  String? caseName;

  @HiveField(4, defaultValue: <String>[])
  List<String>? chat;

  @HiveField(5, defaultValue: false)
  bool predicted = false;

  @HiveField(6, defaultValue: false)
  bool error = false;

  Prediction({
    this.prediction,
    required this.dateTime,
    required this.imageName,
    this.caseName,
    this.predicted = false,
    this.error = false,
    this.chat,
  });
}
