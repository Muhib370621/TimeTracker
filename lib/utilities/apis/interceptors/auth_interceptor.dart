import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/utilities/apis/api_client.dart';
import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dart:core';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:collection';
import 'package:crypto/crypto.dart' as crypto;

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
    String apiURL = options.baseUrl + options.path;
    String signature = getOAuthSignature(client.options.method.toUpperCase(), apiURL);

    if (token.isExpired()) {
      client.instance.lock();
      debugPrint('Lock request for refreshing token...');
      await token.startRefreshToken();
      client.instance.unlock();
      debugPrint('Refresh token completed!');
    }
    String headers1 = 'OAuth oauth_consumer_key="${AppUrls.consumerKey}",'
        'oauth_nonce="$nonce",'
        'oauth_signature="${signature}",'
        'oauth_signature_method="HMAC-SHA256",'
        'oauth_timestamp="${timestamp.toString()}",'
        'oauth_token="${AppUrls.token}",'
        'realm="TSTDRV1967913"';
    options.headers['Authorization'] = headers1;
    options.headers['Prefer'] = 'transient';
    options.headers['Accept'] = 'application/json';

    return super.onRequest(options, handler);

  }

}

int timestamp = 1671114149;
String nonce = "KKEmWuF0hoj";

String getOAuthSignature(String requestMethod, String queryUrl) {
  String consumerKey = AppUrls.consumerKey;
  String consumerSecret = AppUrls.consumerSecret;
  String token = AppUrls.token;
  String tokenSecret = AppUrls.secret;
  Uri uri = Uri.parse(queryUrl);
  Map<String,String> queryParams = uri.queryParameters;
  String url = uri.replace(query: '').toString();
  bool containsQueryParams = url.contains("?");

  Random rand = Random();
  List<int> codeUnits = List.generate(10, (index) {
    return rand.nextInt(26) + 97;
  });

  /// Random string uniquely generated to identify each signed request
   nonce = String.fromCharCodes(codeUnits);

  /// The timestamp allows the Service Provider to only keep nonce values for a limited time
   timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

   Map<String,String> authParams = {
     "oauth_consumer_key":consumerKey,
     "oauth_nonce":nonce,
     "oauth_signature_method":"HMAC-SHA256",
     "oauth_timestamp":timestamp.toString(),
     "oauth_token":token,
   };
  if (containsQueryParams == true) {
    authParams.addAll(queryParams);
  }

  authParams = SplayTreeMap.from(authParams, (k1, k2) => k1.compareTo(k2));
  var parameters = authParams.keys.map((key) => '$key=${authParams[key]}').join('&');


  if (containsQueryParams == true) {
    //parameters = parameters + url.split("?")[1];
  } else {
    parameters = parameters.substring(0, parameters.length - 1);
  }

  Map<dynamic, dynamic> params = splitQueryString(parameters);
  Map<dynamic, dynamic> treeMap = SplayTreeMap<dynamic, dynamic>();
  treeMap.addAll(params);

  String parameterString = "";

  for (var key in treeMap.keys) {
    parameterString = "${parameterString +
        Uri.encodeComponent(key) +
        "=" +
        treeMap[key]}&";
  }

  parameterString = parameterString.substring(0, parameterString.length - 1);

  String method = requestMethod;
  String baseString = "$method&${Uri.encodeComponent(containsQueryParams == true ? url.split("?")[0] : url)}&${Uri.encodeComponent(parameterString)}";

  String signingKey = "$consumerSecret&$tokenSecret";
  crypto.Hmac hmacSha256 = crypto.Hmac(crypto.sha256, utf8.encode(signingKey)); // HMAC-SHA1

  /// The Signature is used by the server to verify the
  /// authenticity of the request and prevent unauthorized access.
  /// Here we use HMAC-SHA1 method.
  crypto.Digest signature = hmacSha256.convert(utf8.encode(baseString));

  String finalSignature = base64Encode(signature.bytes);
  return Uri.encodeComponent(finalSignature);
}

Map<String, String> splitQueryString(String query) {
  return query.split("&").fold({}, (map, element) {
    int index = element.indexOf("=");
    if (index == -1) {
      if (element != "") {
        map[element] = "";
      }
    } else if (index != 0) {
      var key = element.substring(0, index);
      var value = element.substring(index + 1);
      map[key] = value;
    }
    return map;
  });
}


class QueryString {
  /// Parses the given query string into a Map.
  static Map parse(String query) {
    var search = new RegExp('([^&=]+)=?([^&]*)');
    var result = new Map();

// Get rid off the beginning ? in query strings.
    if (query.startsWith('?')) query = query.substring(1);

// A custom decoder.
    decode(String s) => Uri.decodeComponent(s.replaceAll('+', ' '));

// Go through all the matches and build the result map.
    for (Match match in search.allMatches(query)) {
      result[decode(match.group(1) ?? "")] = decode(match.group(2) ?? "");
    }

    return result;
  }
}