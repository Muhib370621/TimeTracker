import 'dart:convert';

import 'decodable.dart';

///A function that creates an object of type [T]

typedef Create<T> = T Function();

///Construct to get object from generic class

abstract class GenericObject<T> {
  Create<Decodable> create;

  GenericObject({required this.create});

  T genericObject(dynamic data) {
    final item = create();
    return item.decode(data);
  }
}

///Construct to wrap response from API.
///
///Used it as return object of APIController to handle any kind of response.

class ResponseWrapper<T> extends GenericObject<T> {
  T? response;
  ErrorResponse? error;

  ResponseWrapper({required Create<Decodable> create, this.error})
      : super(create: create);

  factory ResponseWrapper.init(
      {required Create<Decodable> create,
        required ErrorResponse? error,
        required dynamic json}) {
    final wrapper = ResponseWrapper<T>(create: create);
    wrapper.response = wrapper.genericObject(json);
    wrapper.error = error;
    return wrapper;
  }
}

class QueryResponse<T> extends GenericObject<T>
    implements Decodable<QueryResponse<T>> {
    T? responseData;
    List<dynamic>? links;
    int? count;
    bool? hasMore;
    List<T>? items;
    int? offset;
    int? totalResults;

  QueryResponse({required Create<Decodable> create}) : super(create: create);

  @override
  QueryResponse<T> decode(dynamic json) {
    responseData = genericObject(json);
    count = json['count'];
    hasMore = json['hasMore'];
    if (json['items'] != null) {
      items = <T>[];
      json['items'].forEach((v) {
        items!.add(genericObject(v));
      });
    }
    offset = json['offset'];
    totalResults = json['totalResults'];
    return this;
    // status = json['status'];
    // if (json['ResponseData'] == null) {
    //   responseData = genericObject(json['response_data']);
    // } else {
    //   responseData = genericObject(json['ResponseData']);
    // }
    // return this;
  }
}

class APIListResponse<T> extends GenericObject<T>
    implements Decodable<APIListResponse<T>> {
  List<T>? responseData;

  APIListResponse({required Create<Decodable> create}) : super(create: create);

  @override
  APIListResponse<T> decode(dynamic json) {
    List<T> responseData = [];
    json.forEach((item) {
      responseData.add(genericObject(item));
    });
    responseData = responseData;
    return this;
    // status = json['status'];
    // responseData = [];
    // if (json['ResponseData'] == null) {
    //   json['response_data'].forEach((item) {
    //     responseData?.add(genericObject(item));
    //   });
    // } else {
    //   json['ResponseData'].forEach((item) {
    //     responseData?.add(genericObject(item));
    //   });
    // }

    // return this;
  }
}

class SelectAPIResponse<T> extends GenericObject<T>
    implements Decodable<SelectAPIResponse<T>> {
  String? result;
  T? data;

  SelectAPIResponse({required Create<Decodable> create})
      : super(create: create);

  @override
  SelectAPIResponse<T> decode(dynamic json) {
    result = json['result'];
    if (json['data'] == null) {
      data = genericObject(json['data']);
    } else {
      data = genericObject(json['data']);
    }
    return this;
  }
}

class SelectAPIListResponse<T> extends GenericObject<T>
    implements Decodable<SelectAPIListResponse<T>> {
  String? result;
  List<T>? data;

  SelectAPIListResponse({required Create<Decodable> create})
      : super(create: create);

  @override
  SelectAPIListResponse<T> decode(dynamic json) {
    result = json['result'];
    data = [];
    if (json['data'] == null) {
      json['data'].forEach((item) {
        data?.add(genericObject(item));
      });
    } else {
      json['data'].forEach((item) {
        data?.add(genericObject(item));
      });
    }

    return this;
  }
}

class ErrorResponse implements Exception {
  String message;

  ErrorResponse({required this.message});

  factory ErrorResponse.fromJson(dynamic json) {
    try {
      var response = jsonDecode(json);
      if (response.containsKey('error')) {
        return ErrorResponse(
            message: response['error'] ?? response['Error'] ?? 'Something went wrong.');
      }
      return ErrorResponse(
          message: response['message'] ?? response['Message'] ?? 'Something went wrong.');
    } catch (e) {
      return ErrorResponse(message: json?['message'] ?? json?['Message'] ?? 'Something went wrong.');
    }
  }

  @override
  String toString() {
    return message;
  }
}
