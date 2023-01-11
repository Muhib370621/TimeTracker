import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:blu_time/constants/app_storage.dart';
import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:blu_time/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ProjectViewModel extends BaseModel {
  final _queryClient = ApiServices(baseUrl: AppUrls.path).client;
  List<Project> projects = [];
  Project? selectedProject;
  int tabIndex = 0;
  set setTabIndex(int tabIndex) {
    this.tabIndex = tabIndex;
    notifyListeners();
  }

  set setSelectedProject(Project selectedProject) {
    this.selectedProject = selectedProject;
    notifyListeners();
  }

  fetchProjects() async {
     //projects =  await locator<StoreServices>().getLocal(AppStorage.projects, Project());
     List<dynamic> jsonList = await locator<StoreServices>().getLocal(AppStorage.projects, "userid") ?? [];
     projects = jsonList.map((e) => Project().decode((Map<String, dynamic>.from(e)))).toList();
     setState(projects.isNotEmpty ? ViewState.completed : ViewState.loading);

    Map<String,String> body = {'q':"SELECT * FROM job WHERE custentity_bb_install_address_1_text='123 S. Main St' AND custentity_bb_install_address_2_text='Lot 2' AND custentity_bb_install_city_text='Portland' AND custentity_bb_install_zip_code_text='97216'"};
    try {
      final result = await _queryClient.request<QueryResponse<Project>>(
          route: APIRoute(APIType.suiteql, routeParams: "?limit=10"),
          data: body,
          create: () => QueryResponse(create: () => Project()));
      projects = result.response?.items ?? [];
      await locator<StoreServices>().setLocal(AppStorage.projects, "userid", projects.map((e) => e.toJson()).toList());
      setState(projects.isEmpty ? ViewState.empty : ViewState.completed);
      notifyListeners();
    } on ErrorResponse {
       rethrow;
    } on SocketException{
       throw Get.defaultDialog(title: "Internet Not Available",
          content: const Text("Please check your internet connection"));
    }
  }

}

Future<String?> findLocalPath() async {
  String? externalStorageDirPath = '';
  if (Platform.isAndroid) {
    try {
      externalStorageDirPath = await AndroidPathProvider.downloadsPath;
    } catch (e) {
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    }
  } else if (Platform.isIOS) {
    externalStorageDirPath =
        (await getApplicationDocumentsDirectory()).absolute.path;
  }
  return externalStorageDirPath;
}