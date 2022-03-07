import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';
part 'notepad_model.g.dart';

@HiveType(typeId: 0)
class NotepadModel {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? surname;
  @HiveField(2)
  int? age;
  @HiveField(3)
  String? text;

  NotepadModel({this.name, this.surname, this.age, this.text});
}
