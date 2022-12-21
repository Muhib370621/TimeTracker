import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/apis/api_client.dart';
import 'package:blu_time/utilities/apis/interceptors/auth_interceptor.dart';
import 'package:blu_time/utilities/apis/interceptors/log_interceptor.dart';
import 'package:dio/dio.dart';

class ApiServices {
  ApiServices({String baseUrl =  ""}) {
    getAPIClient(baseUrl);
  }
  late APIClient client;

  Future<APIClient> getAPIClient(String baseUrl) async {
    // if (client == null) {
    client = APIClient(BaseOptions(baseUrl: baseUrl,followRedirects:false));
    final interceptors = [
      AuthInterceptor(
          client,
          AuthToken(
              expiredTime: 0,
              accessToken: locator<StoreServices>().getAccessToken(),
              refreshToken: '')),
      APILogInterceptor(),
    ];
    client.instance.interceptors.addAll(interceptors);
    return client;
  }

}
