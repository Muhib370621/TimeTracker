

import 'package:blu_time/view_models/base_view_model.dart';

class BreakModel extends BaseModel
{
  String breakStart;
  String breakEnd;
  String totalBreakTime;

  BreakModel({
    required this.breakStart,
    required this.breakEnd,
    required this.totalBreakTime,
  });
}