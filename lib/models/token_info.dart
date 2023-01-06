import 'package:blu_time/utilities/apis/decodable.dart';

class TokenInfo extends Decodable<TokenInfo>{
  String? tokenId;
  int? roleId;
  String? appName;
  String? tokenSecret;

  TokenInfo({this.tokenId, this.roleId, this.appName, this.tokenSecret});

  TokenInfo.fromJson(Map<String, dynamic> json) {
    tokenId = json['tokenId'];
    roleId = json['roleId'];
    appName = json['appName'];
    tokenSecret = json['tokenSecret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tokenId'] = tokenId;
    data['roleId'] = roleId;
    data['appName'] = appName;
    data['tokenSecret'] = tokenSecret;
    return data;
  }

  @override
  TokenInfo decode(json) {
    return TokenInfo.fromJson(json);
  }
}