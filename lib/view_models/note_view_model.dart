import 'dart:convert';

import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:blu_time/view_models/base_view_model.dart';
import 'package:flutter/services.dart';

class NoteViewModel extends BaseModel {

  List<Notes> notes = [];
 fetchNotes() async {
   var projectResponse = (await fetch<ProjectResponse>());
   notes = projectResponse.projectList?[0].notes ?? [];
   if (notes.isEmpty) {
      setState(ViewState.empty);
    }
   else {
     setState(ViewState.completed);
   }
    notifyListeners();
 }

  Future<T> fetch<T extends Decodable>() async {
    final String response = await rootBundle.loadString(AppAssets.projectJson);
    final data = await json.decode(response);
    var result = ResponseWrapper.init(create: () => ProjectResponse(), json: (data == null) ? [] : data, error: null);
    return result.response;
  }

 addNote(){
   // notes.add("value");
   // notes.add("value");
   // notes.add("value");
   // notes.add("value");
   fetchNotes();
 }

}