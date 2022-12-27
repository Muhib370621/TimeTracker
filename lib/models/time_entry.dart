import 'package:blu_time/utilities/apis/decodable.dart';

class TimeEntry extends Decodable<TimeEntry>{
  String? billingsubsidiary;
  String? csegBbProject;
  String? custcolBbTimeAddedInJe;
  String? custcolBbTimerReplay;
  String? custcolEnteredByPunch;
  String? customer;
  String? displayfield;
  String? employee;
  String? hours;
  String? id;
  String? isbillable;
  String? isexempt;
  String? isproductive;
  String? isutilized;
  String? item;
  String? lastmodifieddate;
  String? memo;
  String? overriderate;
  String? price;
  String? subsidiary;
  String? supervisorapproval;
  String? timemodified;
  String? timesheet;
  String? timetype;
  String? trandate;

  TimeEntry(
      {this.billingsubsidiary,
        this.csegBbProject,
        this.custcolBbTimeAddedInJe,
        this.custcolBbTimerReplay,
        this.custcolEnteredByPunch,
        this.customer,
        this.displayfield,
        this.employee,
        this.hours,
        this.id,
        this.isbillable,
        this.isexempt,
        this.isproductive,
        this.isutilized,
        this.item,
        this.lastmodifieddate,
        this.memo,
        this.overriderate,
        this.price,
        this.subsidiary,
        this.supervisorapproval,
        this.timemodified,
        this.timesheet,
        this.timetype,
        this.trandate});

  TimeEntry.fromJson(Map<String, dynamic> json) {
    billingsubsidiary = json['billingsubsidiary'];
    csegBbProject = json['cseg_bb_project'];
    custcolBbTimeAddedInJe = json['custcol_bb_time_added_in_je'];
    custcolBbTimerReplay = json['custcol_bb_timer_replay'];
    custcolEnteredByPunch = json['custcol_entered_by_punch'];
    customer = json['customer'];
    displayfield = json['displayfield'];
    employee = json['employee'];
    hours = json['hours'];
    id = json['id'];
    isbillable = json['isbillable'];
    isexempt = json['isexempt'];
    isproductive = json['isproductive'];
    isutilized = json['isutilized'];
    item = json['item'];
    lastmodifieddate = json['lastmodifieddate'];
    memo = json['memo'];
    overriderate = json['overriderate'];
    price = json['price'];
    subsidiary = json['subsidiary'];
    supervisorapproval = json['supervisorapproval'];
    timemodified = json['timemodified'];
    timesheet = json['timesheet'];
    timetype = json['timetype'];
    trandate = json['trandate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['billingsubsidiary'] = billingsubsidiary;
    data['cseg_bb_project'] = csegBbProject;
    data['custcol_bb_time_added_in_je'] = custcolBbTimeAddedInJe;
    data['custcol_bb_timer_replay'] = custcolBbTimerReplay;
    data['custcol_entered_by_punch'] = custcolEnteredByPunch;
    data['customer'] = customer;
    data['displayfield'] = displayfield;
    data['employee'] = employee;
    data['hours'] = hours;
    data['id'] = id;
    data['isbillable'] = isbillable;
    data['isexempt'] = isexempt;
    data['isproductive'] = isproductive;
    data['isutilized'] = isutilized;
    data['item'] = item;
    data['lastmodifieddate'] = lastmodifieddate;
    data['memo'] = memo;
    data['overriderate'] = overriderate;
    data['price'] = price;
    data['subsidiary'] = subsidiary;
    data['supervisorapproval'] = supervisorapproval;
    data['timemodified'] = timemodified;
    data['timesheet'] = timesheet;
    data['timetype'] = timetype;
    data['trandate'] = trandate;
    return data;
  }

  @override
  TimeEntry decode(json) {
    return TimeEntry.fromJson(json);
  }
}