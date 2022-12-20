import 'package:blu_time/utilities/apis/decodable.dart';

class BTErrorResponse extends Decodable<BTErrorResponse>{
  String? type;
  String? title;
  int? status;
  RestletsError? error;
  List<OErrorDetails>? oErrorDetails;

  BTErrorResponse(
      {this.type, this.title, this.status, this.error, this.oErrorDetails});

  BTErrorResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    status = json['status'];
    error = json['error'] != null ? RestletsError.fromJson(json['error']) : null;
    if (json['o:errorDetails'] != null) {
      oErrorDetails = <OErrorDetails>[];
      json['o:errorDetails'].forEach((v) {
        oErrorDetails!.add(OErrorDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['status'] = status;
    if (error != null) {
      data['error'] = error!.toJson();
    }
    if (oErrorDetails != null) {
      data['o:errorDetails'] =
          oErrorDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  BTErrorResponse decode(json) {
    return BTErrorResponse.fromJson(json);
  }
}

class RestletsError {
  String? code;
  String? message;

  RestletsError({this.code, this.message});

  RestletsError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class OErrorDetails {
  String? detail;
  String? oErrorQueryParam;
  String? oErrorCode;

  OErrorDetails({this.detail, this.oErrorQueryParam, this.oErrorCode});

  OErrorDetails.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    oErrorQueryParam = json['o:errorQueryParam'];
    oErrorCode = json['o:errorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    data['o:errorQueryParam'] = oErrorQueryParam;
    data['o:errorCode'] = oErrorCode;
    return data;
  }
}