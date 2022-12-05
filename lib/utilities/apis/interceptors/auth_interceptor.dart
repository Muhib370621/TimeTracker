import 'package:blu_time/utilities/apis/api_client.dart';
import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthToken implements Decodable<AuthToken> {

  String accessToken;
  String refreshToken;
  int expiredTime;

  AuthToken({ required this.accessToken, required this.refreshToken, required this.expiredTime });

  @override
  AuthToken decode(dynamic data) {
    expiredTime = data['expired_time'];
    return this;
  }

  Future startRefreshToken() async {
    await Future.delayed(Duration(seconds: 5));
    // assign new access token
    accessToken = 'eyadfj9803924jjdfkasjdfjsdf';
  }

  bool isExpired() {
    return false;
  }
  
}

class AuthInterceptor extends InterceptorsWrapper {

  final APIClient client;
  AuthToken token;

  AuthInterceptor(this.client, this.token); 

  @override
  Future onRequest(
    RequestOptions options, 
    RequestInterceptorHandler handler
  ) async {

    if (options.extra['no_auth'] ?? false) {
      return super.onRequest(options, handler);
    }

    if (token.isExpired()) {
      client.instance.lock();
      debugPrint('Lock request for refreshing token...');
      await token.startRefreshToken();
      client.instance.unlock();
      debugPrint('Refresh token completed!');
    }
    options.headers['Authorization'] = 'Bearer ${token.accessToken}';
    options.headers['Accept'] = 'application/json';

    return super.onRequest(options, handler);

  }

}