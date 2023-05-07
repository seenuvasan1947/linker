import 'package:hive/hive.dart';

part 'hive_data_model.g.dart';

@HiveType(typeId: 0)
class Links extends HiveObject {
  @HiveField(0)
  String lable;

  @HiveField(1)
  String link;

  Links(this.lable, this.link);
}
