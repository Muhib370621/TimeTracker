
import 'dart:io';

import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/roles_response.dart';
import 'package:blu_time/models/token_info.dart';
import 'package:blu_time/models/user_detail.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:blu_time/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class OnboardingViewModel extends BaseModel {
  final _issueTokenClient = ApiServices(baseUrl: AppUrls.issueToken).client;
  final _rolesClient = ApiServices(baseUrl: AppUrls.roles).client;
  final _queryClient = ApiServices(baseUrl: AppUrls.path).client;


  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set setObscureText(bool val) {
    _obscureText = val;
    notifyListeners();
  }


  getRoles() async {
    try {
      List<dynamic> result = await _rolesClient.requestList<RoleResponse>(
          route: APIRoute(APIType.roles),
          data: null,
          create: () => RoleResponse());
      return result.map((e) => RoleResponse.fromJson(e)).toList();
    } on ErrorResponse {
      rethrow;
    }
  }

  getToken() async {
      final result = await _issueTokenClient.request<TokenInfo>(
          route: APIRoute(APIType.issueToken),
          data: null,
          create: () => TokenInfo());
      return result.response;
  }

  getUserId() async {
    try {
      Map<String, String> body = {
        'q': "SELECT id FROM entity WHERE email = 'dev5-bbss@blubanyan.com'"
      };
      final result = await _queryClient.request<QueryResponse<UserDetail>>(
          route: APIRoute(APIType.suiteql, routeParams: "?limit=10"), data: body, create: () => QueryResponse(create: () => UserDetail()));
      List<UserDetail> users = result.response?.items ?? [];
      if (users.isNotEmpty){
        await locator<StoreServices>().setUserID(users.first.id ?? "");
      }
    } on ErrorResponse {
      rethrow;
    } on SocketException {
      throw Get.defaultDialog(
        title: "Internet Not Available",
        content: Expanded(
          child: SizedBox(
            width: 90.w,
            child: const Text("Please check your internet connection"),
          ),
        ),
      );
    }
  }

}



class EmptyResponse extends Decodable<EmptyResponse>{
  @override
  EmptyResponse decode(json) {
    return EmptyResponse();
  }
}