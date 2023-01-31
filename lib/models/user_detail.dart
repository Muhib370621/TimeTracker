import 'package:blu_time/utilities/apis/decodable.dart';

class UserDetail1 extends Decodable<UserDetail1> {
  String? id;

  UserDetail1({this.id});

  UserDetail1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }

  @override
  UserDetail1 decode(json) {
    return UserDetail1.fromJson(json);
  }
}