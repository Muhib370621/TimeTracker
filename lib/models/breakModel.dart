
import 'package:hive/hive.dart';
// part 'break.dart';

@HiveType(typeId:0)
class BreakModel extends HiveObject
{
  @HiveField(0)
  String breakStart;
  @HiveField(1)
  String breakEnd;
  @HiveField(2)
  String totalBreakTime;

  BreakModel({
    required this.breakStart,
    required this.breakEnd,
    required this.totalBreakTime,
  });
}