import 'package:blu_time/utilities/apis/decodable.dart';

class RoleResponse extends Decodable<RoleResponse>{
  Account? account;
  Role? role;
  DataCenterURLs? dataCenterURLs;

  RoleResponse({this.account, this.role, this.dataCenterURLs});

  RoleResponse.fromJson(Map<String, dynamic> json) {
    account =
    json['account'] != null ? Account.fromJson(json['account']) : null;
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    dataCenterURLs = json['dataCenterURLs'] != null
        ? DataCenterURLs.fromJson(json['dataCenterURLs'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (account != null) {
      data['account'] = account!.toJson();
    }
    if (role != null) {
      data['role'] = role!.toJson();
    }
    if (dataCenterURLs != null) {
      data['dataCenterURLs'] = dataCenterURLs!.toJson();
    }
    return data;
  }

  @override
  RoleResponse decode(json) {
    account = json['account'] != null ? Account.fromJson(json['account']) : null;
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    dataCenterURLs = json['dataCenterURLs'] != null
        ? DataCenterURLs.fromJson(json['dataCenterURLs'])
        : null;
    return this;
  }
}

class Account extends Decodable<Account>{
  String? internalId;
  String? name;
  String? type;

  Account({this.internalId, this.name, this.type});

  Account.fromJson(Map<String, dynamic> json) {
    internalId = json['internalId'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['internalId'] = internalId;
    data['name'] = name;
    data['type'] = type;
    return data;
  }

  @override
  Account decode(json) {
    return Account.fromJson(json);
  }
}

class Role extends Decodable<Role>{
  int? internalId;
  String? name;

  Role({this.internalId, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    internalId = json['internalId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['internalId'] = internalId;
    data['name'] = name;
    return data;
  }

  @override
  Role decode(json) {
    return Role.fromJson(json);
  }
}

class DataCenterURLs extends Decodable<DataCenterURLs>{
  String? webservicesDomain;
  String? restDomain;
  String? systemDomain;

  DataCenterURLs({this.webservicesDomain, this.restDomain, this.systemDomain});

  DataCenterURLs.fromJson(Map<String, dynamic> json) {
    webservicesDomain = json['webservicesDomain'];
    restDomain = json['restDomain'];
    systemDomain = json['systemDomain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['webservicesDomain'] = webservicesDomain;
    data['restDomain'] = restDomain;
    data['systemDomain'] = systemDomain;
    return data;
  }

  @override
  DataCenterURLs decode(json) {
    return DataCenterURLs.fromJson(json);
  }
}