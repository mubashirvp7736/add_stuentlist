import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String clas;

  @HiveField(4)
  final String address;

  StudentModel(
      {required this.name,
      required this.age,
      required this.clas,
      required this.address,
      this.id});
}