import 'package:image_picker/image_picker.dart';

class AddNote {

  String? description;
  List<String>? imagePaths;
  bool? isSynced;

  AddNote(this.description, this.imagePaths, this.isSynced);

  AddNote.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    imagePaths = json['imagePaths'];
    isSynced = json['isSynced'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['imagePaths'] = imagePaths;
    data['isSynced'] = isSynced;
    return data;
  }

}