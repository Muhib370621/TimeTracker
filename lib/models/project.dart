import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:intl/intl.dart';

class ProjectResponse implements Decodable<ProjectResponse> {
  List<Project2>? projectList;

  ProjectResponse({this.projectList});

  ProjectResponse.fromJson(Map<String, dynamic> json) {
    if (json['projectList'] != null) {
      projectList = <Project2>[];
      json['projectList'].forEach((v) {
        projectList!.add(Project2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (projectList != null) {
      data['projectList'] = projectList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  ProjectResponse decode(json) {
    return ProjectResponse.fromJson(json);
  }
}

class Project2 {
  String? projectId;
  String? name;
  String? address;
  String? startDateTime;
  String? endDateTime;
  List<Notes>? notes;
  List<Images>? images;
  int? totalTime;
  List<Tasks>? tasks;
  List<Breaks>? breaks;

  Project2({this.projectId, this.name, this.address, this.startDateTime, this.endDateTime, this.notes, this.images, this.totalTime, this.tasks, this.breaks});

  Project2.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    name = json['name'];
    address = json['address'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(Notes.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    totalTime = json['totalTime'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
    if (json['breaks'] != null) {
      breaks = <Breaks>[];
      json['breaks'].forEach((v) {
        breaks!.add(Breaks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['projectId'] = projectId;
    data['name'] = name;
    data['address'] = address;
    data['startDateTime'] = startDateTime;
    data['endDateTime'] = endDateTime;
    if (notes != null) {
      data['notes'] = notes!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['totalTime'] = totalTime;
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    if (breaks != null) {
      data['breaks'] = breaks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notes extends Decodable<Notes> {
  String? noteId;
  String? note;
  String? projectId;

  Notes({this.noteId, this.note, this.projectId});

  Notes.fromJson(Map<String, dynamic> json) {
    noteId = json['noteId'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noteId'] = noteId;
    data['note'] = note;
    return data;
  }

  @override
  Notes decode(json) {
    return Notes.fromJson(json);
  }
}

class Images {
  String? imageId;
  String? imgLink1;
  String? imgLink2;

  Images({this.imageId, this.imgLink1, this.imgLink2});

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    imgLink1 = json['img_link1'];
    imgLink2 = json['img_link2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['img_link1'] = imgLink1;
    data['img_link2'] = imgLink2;
    return data;
  }
}

class Tasks {
  int? taskId;
  String? taskDescription;
  String? startDateTime;
  String? endDateTime;
  int? totalTime;
  String? note;
  List<Images>? images;

  Tasks({this.taskId, this.taskDescription, this.startDateTime, this.endDateTime, this.totalTime, this.note, this.images});

  Tasks.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    taskDescription = json['taskDescription'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    totalTime = json['totalTime'];
    note = json['note'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskId'] = taskId;
    data['taskDescription'] = taskDescription;
    data['startDateTime'] = startDateTime;
    data['endDateTime'] = endDateTime;
    data['totalTime'] = totalTime;
    data['note'] = note;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Breaks {
  int? id;
  String? btype;
  String? fromTime;
  String? toTime;

  Breaks({this.id, this.btype, this.fromTime, this.toTime});

  Breaks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    btype = json['btype'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['btype'] = btype;
    data['fromTime'] = fromTime;
    data['toTime'] = toTime;
    return data;
  }
}

class QueryResult extends Decodable<QueryResult> {
  List<Links>? links;
  int? count;
  bool? hasMore;
  List<Project>? items;
  int? offset;
  int? totalResults;

  QueryResult({this.links, this.count, this.hasMore, this.items, this.offset, this.totalResults});

  QueryResult.fromJson(Map<String, dynamic> json) {
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    count = json['count'];
    hasMore = json['hasMore'];
    if (json['items'] != null) {
      items = <Project>[];
      json['items'].forEach((v) {
        items!.add(new Project.fromJson(v));
      });
    }
    offset = json['offset'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    data['hasMore'] = hasMore;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['offset'] = offset;
    data['totalResults'] = totalResults;
    return data;
  }

  @override
  QueryResult decode(json) {
    // TODO: implement decode
    throw UnimplementedError();
  }
}

class Links {
  String? rel;
  String? href;

  Links({this.rel, this.href});

  Links.fromJson(Map<String, dynamic> json) {
    rel = json['rel'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rel'] = rel;
    data['href'] = href;
    return data;
  }
}

class Project extends Decodable<Project> {
  List<Links>? links;
  String? address1;
  String? city;
  String? endTime;
  String? id;
  String? latitude;
  String? longitude;
  String? title;
  String? startTime;
  String? customer;
  String? bluchatId;

  Project({this.links, this.address1, this.city, this.endTime, this.id, this.latitude, this.longitude, this.title, this.startTime, this.customer,this.bluchatId});

  Project.fromJson(Map<String, dynamic> json) {
    address1 = json['address_1'];
    city = json['city'];
    endTime = json['end_time'];
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    title = json['title'];
    startTime = json['start_time'];
    bluchatId = json['bluchat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address_1'] = address1;
    data['city'] = city;
    data['end_time'] = endTime;
    data['id'] = id;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['title'] = title;
    data['start_time'] = startTime;
    data['bluchat_id'] = this.bluchatId;
    startTimeParsed;
    return data;
  }

  @override
  Project decode(json) {
    return Project.fromJson(json);
  }

  String get startDateParsed {
    return _getParsedDate(startTime ?? "");
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
      DateTime dateTime = DateFormat('M/d/yyyy h:mm:ss a').parse(date);
      return DateFormat.yMMMMd().format(dateTime);
    } catch (e) {
      return date;
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
