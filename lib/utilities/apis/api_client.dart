import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/models/error_response.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/connectivity_manager.dart';
import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class APIClient {
  late final BaseOptions options;
  late Dio instance;

  APIClient(this.options) {
    instance = Dio(options);
  }

  Future<ResponseWrapper<T>> request<T extends Decodable>({
    required APIRouteConfigurable route,
    required Create<T> create,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    RequestOptions? config = route.getConfig();
    config?.baseUrl =
        (config.baseUrl != null) ? config.baseUrl : options.baseUrl;
    config?.data = data;

    bool isOnline = await ConnectivityManager.instance.isOnline();
    if (!isOnline) {
      throw Get.defaultDialog(
          title: "Internet Not Available",
          titlePadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.all(12),
          content: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              Image.asset(
                AppAssets.disclaimerIcon,
                scale: 1.7,
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: Text("Please check your internet connection"),
              ),
            ],
          ));
    }
    if (config == null) {
      throw ErrorResponse(message: 'Wrong input');
    }
    if (queryParameters != null) {
      config.queryParameters = queryParameters;
    }
    try {
      instance.options.method = config.method;
      final response = await instance.request(config.path,
          data: data, queryParameters: config.queryParameters);
      final responseData = response.data;
      // handleErrors(responseData);
      if (response.statusCode == 200) {
        return ResponseWrapper.init(
            create: create,
            json: (responseData == null) ? [] : responseData,
            error: null);
      } else {
        return ResponseWrapper.init(
            create: create, json: responseData, error: null);
      }
    } on DioError catch (e) {
      debugPrint(e.response?.statusCode.toString());
      if (e.response?.statusCode == 200) {
        return ResponseWrapper.init(create: create, json: {}, error: null);
      }
      if (e.response?.statusCode == 502 || e.response?.statusCode == 400) {
        ResponseWrapper<BTErrorResponse> errorResponse1 = ResponseWrapper.init(
            create: () => BTErrorResponse(),
            json: e.response?.data,
            error: null);
        final errorResponse = ErrorResponse(
            message: errorResponse1.response?.error?.message ?? "Server error");
        throw errorResponse;
      } else {
        //debugPrint('Error: ${e.response?.data}');
        //debugPrint(e.requestOptions.baseUrl);
      }
      //
      // if (e.response?.statusCode == 403) {

      // }
      // else  if (e.response?.statusCode == 401){

      // }
      handleErrors(e.response?.data);
      final errorResponse = ErrorResponse.fromJson(e.response?.data);
      throw errorResponse;
    }
    //   on SocketException{
    //     throw
    // }
  }

  Future<dynamic> requestList<T extends Decodable>({
    required APIRouteConfigurable route,
    required Create<T> create,
    dynamic data,
    dynamic dataCopy,
    Map<String, dynamic>? queryParameters,
  }) async {
    RequestOptions? config = route.getConfig();
    config?.baseUrl =
        (config.baseUrl != null) ? config.baseUrl : options.baseUrl;
    config?.data = data;

    bool isOnline = await ConnectivityManager.instance.isOnline();
    if (!isOnline) {
      throw ErrorResponse(message: 'No Internet connection available.');
    }
    if (config == null) {
      throw ErrorResponse(message: 'Wrong input');
    }
    if (queryParameters != null) {
      config.queryParameters = queryParameters;
    }
    try {
      instance.options.method = config.method;
      final response = await instance.request(config.path,
          data: data, queryParameters: config.queryParameters);
      // List<Ro> roles = response.data.map((e) => RoleResponse.fromJson(e)).toList;
      return response.data;
    } on DioError catch (e) {
      debugPrint(e.response?.statusCode.toString());
      if (e.response?.statusCode == 200) {
        //return e.response;
      }
      if (e.response?.statusCode == 502 || e.response?.statusCode == 400) {
        final errorResponse = ErrorResponse(message: 'Server error');
        throw errorResponse;
      } else {
        //debugPrint('Error: ${e.response?.data}');
        //debugPrint(e.requestOptions.baseUrl);
      }
      //
      // if (e.response?.statusCode == 403) {

      // }
      // else  if (e.response?.statusCode == 401){

      // }
      handleErrors(e.response?.data);
      final errorResponse = ErrorResponse.fromJson(e.response?.data);
      throw errorResponse;
    }
  }

  handleErrors(dynamic data) {
    if (data is Map) {
      if (data.containsKey('errors') || data.containsKey('message')) {
        var error = 'Something went wrong';
        if (data['errors'] is String) {
          error = data['errors'];
        } else if (data['errors'] is Map) {
          Map errors = data['errors'];
          error = errors.values.join("\n");
        } else if (data['message'] is String) {
          error = data['message'];
        }
        final errorResponse = ErrorResponse(message: error);
        throw errorResponse;
      }
    } else {}
  }
}
