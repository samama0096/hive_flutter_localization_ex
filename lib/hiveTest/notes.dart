import 'package:hive/hive.dart';
part 'notes.g.dart';

@HiveType()
class Notes {
  @HiveField(0)
  String name;

  @HiveField(1)
  String title;

  @HiveField(2)
  String desc;

  Notes({this.name, this.title, this.desc});
}
