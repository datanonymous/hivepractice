import 'package:hive/hive.dart';

part 'contact.g.dart'; //flutter packages pub run build_runner build

@HiveType(typeId: 0) //https://github.com/hivedb/hive/issues/231
class Contact {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;

  Contact(this.name, this.age);
}