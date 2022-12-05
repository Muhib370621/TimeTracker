import 'package:shared_preferences/shared_preferences.dart';

abstract class StoreServices {

  String getAccessToken();
  Future<bool> setAccessToken(String value);
  dynamic getUserProfile();
  Future<bool> setUserProfile(value);
}

class StoreServicesImpl extends StoreServices {
  StoreServicesImpl(SharedPreferences sharedPreferences) : super() {
    _prefs = sharedPreferences;
  }

  late SharedPreferences _prefs;

  final String _kAccessTokenPrefs = "accessToken";

  @override
  String getAccessToken() {
    return _prefs.getString(_kAccessTokenPrefs) ?? '';
  }

  @override
  Future<bool> setAccessToken(String value) async {
    return _prefs.setString(_kAccessTokenPrefs, value);
  }

  @override
  dynamic? getUserProfile() {
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }

  @override
  Future<bool> setUserProfile(value) {
    // TODO: implement setUserProfile
    throw UnimplementedError();
  }

}
