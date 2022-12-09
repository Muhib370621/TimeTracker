import 'package:blu_time/utilities/apis/decodable.dart';

class ProjectResponse implements Decodable<ProjectResponse> {
  List<Project>? projectList;

  ProjectResponse({this.projectList});

  ProjectResponse.fromJson(Map<String, dynamic> json) {
    if (json['projectList'] != null) {
      projectList = <Project>[];
      json['projectList'].forEach((v) {
        projectList!.add(Project.fromJson(v));
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

class Project {
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

  Project(
      {this.projectId,
        this.name,
        this.address,
        this.startDateTime,
        this.endDateTime,
        this.notes,
        this.images,
        this.totalTime,
        this.tasks,
        this.breaks});

  Project.fromJson(Map<String, dynamic> json) {
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

class Notes {
  String? noteId;
  String? note;

  Notes({this.noteId, this.note});

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

  Tasks(
      {this.taskId,
        this.taskDescription,
        this.startDateTime,
        this.endDateTime,
        this.totalTime,
        this.note,
        this.images});

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