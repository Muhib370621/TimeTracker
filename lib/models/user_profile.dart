import 'package:blu_time/utilities/apis/decodable.dart';

class UserProfile extends Decodable<UserProfile>{

  String? id;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? mobile;

  UserProfile(
      {this.id,
        this.email,
        this.password,
        this.firstName,
        this.lastName,
        this.mobile});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    return data;
  }

  @override
  UserProfile decode(json) {
   return UserProfile.fromJson(json);
  }


}