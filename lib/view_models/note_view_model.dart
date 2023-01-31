import 'dart:convert';

import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_storage.dart';
import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/main.dart';
import 'package:blu_time/models/add_note.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/stores/mock_factory.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:blu_time/utilities/media_picker.dart';
import 'package:blu_time/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class NoteViewModel extends BaseModel {
  List<Notes> notes = [];
 final MediaPicker _mediaPicker = MediaPicker();
 List<XFile> noteImages = [];
  final _queryClient = ApiServices(baseUrl: AppUrls.path).client;

  fetchNotes(String projectId) async {
    if (isMockEnabled){
      notes = MockFactory().mockProjectNotes(projectId);
      setState(notes.isNotEmpty ? ViewState.completed : ViewState.empty);
      return;
    }

    List<dynamic> jsonList = await locator<StoreServices>().getLocal(AppStorage.notes, projectId) ?? [];
    notes = jsonList.map((e) => Notes().decode((Map<String, dynamic>.from(e)))).toList();
    setState(notes.isNotEmpty ? ViewState.completed : ViewState.loading);
    Map<String, String> body = {
      'q':
      "SELECT note.note FROM note WHERE entity=$projectId"
    };
    try {
      final result = await _queryClient.request<QueryResponse<Notes>>(
          route: APIRoute(APIType.suiteql, routeParams: "?limit=10"),
          data: body,
          create: () => QueryResponse(create: () => Notes()));
      notes = result.response?.items ?? [];
      if (notes.isNotEmpty) {
        await locator<StoreServices>().setLocal(AppStorage.notes,projectId, notes.map((e) => e.toJson()).toList());
      }
      if (notes.isEmpty) {
        setState(ViewState.empty);
      } else {
        setState(ViewState.completed);
      }
      notifyListeners();
    } on ErrorResponse {
      rethrow;
    }
  }

  // fetchNotes(String projectId) async {
  //
  //   notes = MockFactory().mockProjectNotes(projectId);
  //
  //   // var projectResponse = (await fetch<ProjectResponse>());
  //   // notes = projectResponse.projectList?[0].notes ?? [];
  //   if (notes.isEmpty) {
  //     setState(ViewState.empty);
  //   } else {
  //     setState(ViewState.completed);
  //   }
  //  // fetchLocalNotes();
  //   notifyListeners();
  // }

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
  Get.defaultDialog(
       title: '',
       middleText: '',
      titlePadding: EdgeInsets.zero,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppCommonButton(title: "Gallery",width: 90,height: 40,onPressed: () async {
            if (Get.context != null) {
              Navigator.of(Get.context!, rootNavigator: true).pop();
            }
            List<XFile> images = await _mediaPicker.selectImages();
            noteImages.addAll(images);
            debugPrint(noteImages.toString());
            notifyListeners();

          },),
          AppCommonButton(title: "Camera",width: 90,height: 40,onPressed: () async {
            if (Get.context != null) {
              Navigator.of(Get.context!, rootNavigator: true).pop();
            }
            List<XFile> images = await _mediaPicker.openCamera();
            noteImages.addAll(images);
            debugPrint(noteImages.toString());
            notifyListeners();
          },),
        ],
      ),

    );

  }

  removeImage(int index){
    if (noteImages.length > index) {
      noteImages.removeAt(index);
      notifyListeners();
    }
  }

  addNote() {
    // notes.add("value");
    // notes.add("value");
    // notes.add("value");
    // notes.add("value");
    //fetchNotes();
  }
}
