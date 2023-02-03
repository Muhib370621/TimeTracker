import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:intl/intl.dart';

class TimeEntry extends Decodable<TimeEntry> {
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
  int? actionsCount;
  int? completeCount;
  int? remainingCount;
  String? type;
  List<Break>? breaks;
  String? startTime;
  String? endTime;
  String? location;
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
      this.trandate,
      this.actionsCount,
      this.completeCount,
      this.remainingCount,
      this.type,
      this.breaks,
      this.startTime,
      this.endTime,this.location});

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

  String get startDateParsed {
    return _getParsedDate(startTime ?? "");
  }

  String get startDateParsedWithDay {
     try {
      DateTime dateTime = DateFormat('M/d/yyyy h:mm:ss a').parse(startTime ?? "");
      return DateFormat('EEE d MMM').format(dateTime);
    } catch (e) {
      return startTime ?? "";
    }
  }



  String get startDateTimeParsed {
    return "${_getParsedDate(startTime ?? "")}  ${_getParsedTime(startTime ?? "")}";
  }


  String get endDateTimeParsed {
    return "${_getParsedDate(endTime ?? "")}  ${_getParsedTime(endTime ?? "")}";
  }

  String get startTimeParsed {
    return _getParsedTime(startTime ?? "");
  }

  String get endDateParsed {
    return _getParsedDate(endTime ?? "");
  }

  String get endTimeParsed {
    return _getParsedTime(endTime ?? "");
  }

  _getParsedDate(String date) {
    try {
      DateTime dateTime = DateFormat('M/d/yyyy h:mm:ss a').parse(startTime ?? "");
      return DateFormat('MMM d yyyy').format(dateTime);
    } catch (e) {
      return startTime ?? "";
    }
  }

  _getParsedTime(String date) {
    try {
      DateTime dateTime = DateFormat('M/d/yyyy h:mm:ss a').parse(date);
      int hour = dateTime.hour;
      if (hour == 0 || hour == 12) {
        hour = 12;
      } else if (hour > 12) {
        hour -= 12;
      }
      String minute = dateTime.minute.toString().padLeft(2, '0');
      String second = dateTime.second.toString().padLeft(2, '0');
      String time = "$hour:$minute";
      if (second != "00") {
        time += ":$second";
      }
      time += " ${dateTime.hour >= 12 ? 'PM' : 'AM'}";
      return time;
    } catch (e) {
      return date;
    }
  }
}

class Break {
  final String? startDate;
  final String? startTime;
  final String? endDate;
  final String? endTime;

  Break(this.startDate, this.startTime, this.endDate, this.endTime);
}
