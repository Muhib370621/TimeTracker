import 'package:blu_time/constants/app_urls.dart';
import 'package:dio/dio.dart';

enum APIType {
  register,
  login,
  verify,
  resendCode,
  suiteql,
  issueToken,
  roles,
}

class APIRoute implements APIRouteConfigurable {
  final APIType type;
  final String? routeParams;
  final String apiVersion;

  APIRoute(this.type, {this.routeParams, this.apiVersion = '/'});

  /// Return config of api (method, url, header)
  @override
  RequestOptions? getConfig() {
    switch (type) {
      case APIType.register:
        return RequestOptions(
          path: '${apiVersion}signup',
          method: APIMethod.post,
        );
      case APIType.login:
        return RequestOptions(
          path: '${apiVersion}authenticate',
          method: APIMethod.post,
        );
      case APIType.verify:
        return RequestOptions(
          path: '${apiVersion}verify-email',
          method: APIMethod.post,
        );
      case APIType.resendCode:
        return RequestOptions(
          path: '${apiVersion}resend-verification',
          method: APIMethod.post,
        );
      case APIType.suiteql:
        return RequestOptions(
          path: '${apiVersion}query/v1/suiteql?limit=10',
          method: APIMethod.post,
        );
      case APIType.issueToken:
        return RequestOptions(
          path: apiVersion,
          method: APIMethod.get,
          baseUrl: AppUrls.issueToken
        );
      case APIType.roles:
        return RequestOptions(
            path: apiVersion,
            method: APIMethod.get,
            baseUrl: AppUrls.roles
        );
    }
  }
}

// ignore: one_member_abstracts
abstract class APIRouteConfigurable {
  RequestOptions? getConfig();
}

class APIMethod {
  static const get = 'get';
  static const post = 'post';
  static const put = 'put';
  static const patch = 'patch';
  static const delete = 'delete';
}
