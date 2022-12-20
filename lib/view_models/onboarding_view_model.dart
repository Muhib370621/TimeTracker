import 'dart:io';

import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/roles_response.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:blu_time/view_models/base_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
class OnboardingViewModel extends BaseModel {
  final _issueTokenClient = ApiServices(baseUrl: AppUrls.issueToken).client;
  final _rolesClient = ApiServices(baseUrl: AppUrls.roles).client;
  final _queryClient = ApiServices().client;


  getRoles() async {
    try {
      final result = await _rolesClient.requestList(
          route: APIRoute(APIType.roles),
          data: null,
          create: () => <RoleResponse>[]);
      return result;
    } on ErrorResponse {
      rethrow;
    }
  }

  getToken() async {
      final result = await _issueTokenClient.request<EmptyResponse>(
          route: APIRoute(APIType.issueToken),
          data: null,
          create: () => EmptyResponse());
      return result.response;
  }

  testApi()async{

   Map<String,String> body = {'q':'SELECT entityid,id,custentity_bb_homeowner_customer as homeownerid,BUILTIN.DF(custentity_bb_homeowner_customer) as homeowner FROM job where id=1043851'};

    try {
      final result = await _queryClient.request<EmptyResponse>(
          route: APIRoute(APIType.suiteql, routeParams: "?limit=10"),
          data: body,
          create: () => EmptyResponse());
      return result.response;
    } on ErrorResponse {
     // rethrow;
    }














  }

}



class EmptyResponse extends Decodable<EmptyResponse>{
  @override
  EmptyResponse decode(json) {
    return EmptyResponse();
  }
}