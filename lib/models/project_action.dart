import 'package:blu_time/utilities/apis/decodable.dart';

class ProjectAction extends Decodable<ProjectAction>{
  String? created;
  String? custrecordBbActgrpSequence;
  String? custrecordBbActionStatusType;
  String? custrecordBbBludocsPath;
  String? custrecordBbDocumentStatus;
  String? custrecordBbPackage;
  String? custrecordBbPackageStepNumber;
  String? custrecordBbProjActCounterpartyType;
  String? custrecordBbProjActOverallStepInt;
  String? custrecordBbProjActSequence;
  String? custrecordBbProjActnPreviousRevBox;
  String? custrecordBbProjDocRequiredOptional;
  String? custrecordBbProjTaskUuidTxt;
  String? custrecordBbProject;
  String? custrecordBbProjectPackageAction;
  String? custrecordBbRevisionNumber;
  String? id;
  String? isinactive;
  String? lastmodified;
  String? name;
  String? owner;
  String? scriptid;
  String? custrecordBbProjactPrecedPackAction;

  ProjectAction(
      {
        this.created,
        this.custrecordBbActgrpSequence,
        this.custrecordBbActionStatusType,
        this.custrecordBbBludocsPath,
        this.custrecordBbDocumentStatus,
        this.custrecordBbPackage,
        this.custrecordBbPackageStepNumber,
        this.custrecordBbProjActCounterpartyType,
        this.custrecordBbProjActOverallStepInt,
        this.custrecordBbProjActSequence,
        this.custrecordBbProjActnPreviousRevBox,
        this.custrecordBbProjDocRequiredOptional,
        this.custrecordBbProjTaskUuidTxt,
        this.custrecordBbProject,
        this.custrecordBbProjectPackageAction,
        this.custrecordBbRevisionNumber,
        this.id,
        this.isinactive,
        this.lastmodified,
        this.name,
        this.owner,
        this.scriptid,
        this.custrecordBbProjactPrecedPackAction});

  ProjectAction.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    custrecordBbActgrpSequence = json['custrecord_bb_actgrp_sequence'];
    custrecordBbActionStatusType = json['custrecord_bb_action_status_type'];
    custrecordBbBludocsPath = json['custrecord_bb_bludocs_path'];
    custrecordBbDocumentStatus = json['custrecord_bb_document_status'];
    custrecordBbPackage = json['custrecord_bb_package'];
    custrecordBbPackageStepNumber = json['custrecord_bb_package_step_number'];
    custrecordBbProjActCounterpartyType =
    json['custrecord_bb_proj_act_counterparty_type'];
    custrecordBbProjActOverallStepInt =
    json['custrecord_bb_proj_act_overall_step_int'];
    custrecordBbProjActSequence = json['custrecord_bb_proj_act_sequence'];
    custrecordBbProjActnPreviousRevBox =
    json['custrecord_bb_proj_actn_previous_rev_box'];
    custrecordBbProjDocRequiredOptional =
    json['custrecord_bb_proj_doc_required_optional'];
    custrecordBbProjTaskUuidTxt = json['custrecord_bb_proj_task_uuid_txt'];
    custrecordBbProject = json['custrecord_bb_project'];
    custrecordBbProjectPackageAction =
    json['custrecord_bb_project_package_action'];
    custrecordBbRevisionNumber = json['custrecord_bb_revision_number'];
    id = json['id'];
    isinactive = json['isinactive'];
    lastmodified = json['lastmodified'];
    name = json['name'];
    owner = json['owner'];
    scriptid = json['scriptid'];
    custrecordBbProjactPrecedPackAction =
    json['custrecord_bb_projact_preced_pack_action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created'] = created;
    data['custrecord_bb_actgrp_sequence'] = custrecordBbActgrpSequence;
    data['custrecord_bb_action_status_type'] =
        custrecordBbActionStatusType;
    data['custrecord_bb_bludocs_path'] = custrecordBbBludocsPath;
    data['custrecord_bb_document_status'] = custrecordBbDocumentStatus;
    data['custrecord_bb_package'] = custrecordBbPackage;
    data['custrecord_bb_package_step_number'] =
        custrecordBbPackageStepNumber;
    data['custrecord_bb_proj_act_counterparty_type'] =
        custrecordBbProjActCounterpartyType;
    data['custrecord_bb_proj_act_overall_step_int'] =
        custrecordBbProjActOverallStepInt;
    data['custrecord_bb_proj_act_sequence'] = custrecordBbProjActSequence;
    data['custrecord_bb_proj_actn_previous_rev_box'] =
        custrecordBbProjActnPreviousRevBox;
    data['custrecord_bb_proj_doc_required_optional'] =
        custrecordBbProjDocRequiredOptional;
    data['custrecord_bb_proj_task_uuid_txt'] = custrecordBbProjTaskUuidTxt;
    data['custrecord_bb_project'] = custrecordBbProject;
    data['custrecord_bb_project_package_action'] =
        custrecordBbProjectPackageAction;
    data['custrecord_bb_revision_number'] = custrecordBbRevisionNumber;
    data['id'] = id;
    data['isinactive'] = isinactive;
    data['lastmodified'] = lastmodified;
    data['name'] = name;
    data['owner'] = owner;
    data['scriptid'] = scriptid;
    data['custrecord_bb_projact_preced_pack_action'] =
        custrecordBbProjactPrecedPackAction;
    return data;
  }

  @override
  ProjectAction decode(json) {
    return ProjectAction.fromJson(json);
  }
}