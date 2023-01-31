import 'package:blu_time/utilities/apis/decodable.dart';

class ActionChecklist extends Decodable<ActionChecklist>{
  bool? completed;
  String? title;
  String? completedDate;
  String? custrecordBbPachklistProjectAction;

  ActionChecklist({this.completed, this.title, this.completedDate, this.custrecordBbPachklistProjectAction});
  ActionChecklist.fromJson(Map<String, dynamic> json) {
    completed = (json['completed'] == 'T');
    title = json['title'];
    completedDate = json['completed_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completed'] = completed;
    data['title'] = title;
    data['completed_date'] = completedDate;
    return data;
  }

  @override
  ActionChecklist decode(json) {
    return ActionChecklist.fromJson(json);
  }
}