import 'dart:convert';
import 'dart:math';

import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:blu_time/view_models/base_view_model.dart';
import 'package:blu_time/view_models/onboarding_view_model.dart';
import 'package:flutter/services.dart';

class ClockViewModel extends BaseModel {

  final _client = locator<ApiServices>().client;

  List<Project> projects = [];
  Project? currentProject;

  selectRandomProject(){

    currentProject = projects[Random().nextInt(projects.length)];
    notifyListeners();

  }

  Future<T> fetch<T extends Decodable>() async {
    final String response = await rootBundle.loadString(AppAssets.projectJson);
    final data = await json.decode(response);
    var result = ResponseWrapper.init(create: () => ProjectResponse(), json: (data == null) ? [] : data, error: null);
    return result.response;
  }


  getLocalProjects<T extends Decodable>() async {
    var projectResponse = (await fetch<ProjectResponse>());
    projects = projectResponse.projectList ?? [];
    if (projects.isNotEmpty){
      currentProject = projects[0];
    }
    notifyListeners();
  }

  Future<EmptyResponse?> getProjects<T extends Decodable>() async {
    try {
      final result = await _client.request<EmptyResponse>(
          route: APIRoute(APIType.suiteql),
          data: null,
          create: () => EmptyResponse());
      return result.response;
    } on ErrorResponse {
      rethrow;
    }
  }

  String calculateElapsedTime() {
    return '${(Duration(seconds:  0))}'.split('.')[0].padLeft(8, '0');
  }

}