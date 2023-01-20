import 'package:blu_time/utilities/apis/decodable.dart';

class ActionChecklist extends Decodable<ActionChecklist>{
  String? created;
  String? custrecordBbPachklistCompletedBoolea;
  String? custrecordBbPachklistProject;
  String? custrecordBbPachklistProjectAction;
  String? custrecordBbPachklistTitle;
  String? id;
  String? isinactive;
  String? lastmodified;
  String? name;
  String? owner;
  String? scriptid;
  bool? isCompleted;

  ActionChecklist(
      {this.created,
        this.custrecordBbPachklistCompletedBoolea,
        this.custrecordBbPachklistProject,
        this.custrecordBbPachklistProjectAction,
        this.custrecordBbPachklistTitle,
        this.id,
        this.isinactive,
        this.lastmodified,
        this.name,
        this.owner,
        this.scriptid,this.isCompleted});

  ActionChecklist.fromJson(Map<String, dynamic> json) {

    created = json['created'];
    custrecordBbPachklistCompletedBoolea =
    json['custrecord_bb_pachklist_completed_boolea'];
    custrecordBbPachklistProject = json['custrecord_bb_pachklist_project'];
    custrecordBbPachklistProjectAction =
    json['custrecord_bb_pachklist_project_action'];
    custrecordBbPachklistTitle = json['custrecord_bb_pachklist_title'];
    id = json['id'];
    isinactive = json['isinactive'];
    lastmodified = json['lastmodified'];
    name = json['name'];
    owner = json['owner'];
    scriptid = json['scriptid'];
  }
  final Map<String, dynamic> data = Map<String, dynamic>();
  Map<String, dynamic> toJson() {
    data['created'] = created;
    data['custrecord_bb_pachklist_completed_boolea'] =
        custrecordBbPachklistCompletedBoolea;
    data['custrecord_bb_pachklist_project'] = custrecordBbPachklistProject;
    data['custrecord_bb_pachklist_project_action'] =
        custrecordBbPachklistProjectAction;
    data['custrecord_bb_pachklist_title'] = custrecordBbPachklistTitle;
    data['id'] = id;
    data['isinactive'] = isinactive;
    data['lastmodified'] = lastmodified;
    data['name'] = name;
    data['owner'] = owner;
    data['scriptid'] = scriptid;
    return data;
  }

  @override
  ActionChecklist decode(json) {
    return ActionChecklist.fromJson(json);
  }
}