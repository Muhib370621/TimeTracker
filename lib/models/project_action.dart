import 'package:blu_time/utilities/apis/decodable.dart';

class ProjectAction extends Decodable<ProjectAction>{
  String? assignedBy;
  String? assignedTime;
  bool? completed;
  String? id;
  String? title;
  String? custrecordBbProject;

  ProjectAction(
      {this.assignedBy,
        this.assignedTime,
        this.completed,
        this.id,
        this.title,
      this.custrecordBbProject});

  ProjectAction.fromJson(Map<String, dynamic> json) {
    assignedBy = json['assigned_by'];
    assignedTime = json['assigned_time'];
    completed = (json['completed'] == 'T');
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assigned_by'] = assignedBy;
    data['assigned_time'] = assignedTime;
    data['completed'] = completed;
    data['id'] = id;
    data['title'] = title;
    return data;
  }
  @override
  ProjectAction decode(json) {
    return ProjectAction.fromJson(json);
  }
}