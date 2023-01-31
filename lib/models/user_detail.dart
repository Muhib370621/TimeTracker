import 'package:blu_time/utilities/apis/decodable.dart';

class UserDetail extends Decodable<UserDetail> {
  String? id;

  UserDetail({this.id});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }

  @override
  UserDetail decode(json) {
    return UserDetail.fromJson(json);
  }
}