import 'dart:convert';

import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/add_note.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:blu_time/utilities/media_picker.dart';
import 'package:blu_time/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class NoteViewModel extends BaseModel {
  List<Notes> notes = [];
 final MediaPicker _mediaPicker = MediaPicker();
 List<XFile> noteImages = [];
  fetchNotes() async {
    var projectResponse = (await fetch<ProjectResponse>());
    notes = projectResponse.projectList?[0].notes ?? [];
    if (notes.isEmpty) {
      setState(ViewState.empty);
    } else {
      setState(ViewState.completed);
    }
   // fetchLocalNotes();
    notifyListeners();
  }

  fetchLocalNotes() async {

   List<dynamic> note = await locator<StoreServices>().getLocal("notes", "userid");
   List<AddNote> note1 = note.map((e) => AddNote.fromJson(Map<String,dynamic>.from(e))).toList() ;
   if (note1.isNotEmpty) {
     noteImages = (note1.map((e) => (e.imagePaths?.map((e) => XFile(e))))).expand((i) => i!).toList();
     debugPrint(note.last.description);
   }
  }

  Future<T> fetch<T extends Decodable>() async {
    final String response = await rootBundle.loadString(AppAssets.projectJson);
    final data = await json.decode(response);
    var result = ResponseWrapper.init(
        create: () => ProjectResponse(),
        json: (data == null) ? [] : data,
        error: null);
    return result.response;
  }

  selectImages() async {
   noteImages = await _mediaPicker.selectImages();
   debugPrint(noteImages.toString());
   notifyListeners();
  }

  addNote() {
    // notes.add("value");
    // notes.add("value");
    // notes.add("value");
    // notes.add("value");
    fetchNotes();
  }
}
