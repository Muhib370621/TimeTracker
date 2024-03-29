import 'package:shared_preferences/shared_preferences.dart';

abstract class StoreServices {

  String getAccessToken();
  Future<bool> setAccessToken(String value);
  String getTokenSecret();
  Future<bool> setTokenSecret(String value);
  String getUsername();
  Future<bool> setUsername(String value);
  String getPassword();
  Future<bool> setPassword(String value);
  String getAccountID();
  Future<bool> setAccountID(String value);

  dynamic getUserProfile();
  Future<bool> setUserProfile(value);
}

class StoreServicesImpl extends StoreServices {
  StoreServicesImpl(SharedPreferences sharedPreferences) : super() {
    _prefs = sharedPreferences;
  }

  late SharedPreferences _prefs;

  final String _kAccessTokenPrefs = "accessToken";
  final String _kTokenSecretPrefs = "_kTokenSecretPrefs";
  final String _kUsername = "_kUsername";
  final String _password = "_password";
  final String _accountID = "_accountID";

  @override
  String getAccessToken() {
    return _prefs.getString(_kAccessTokenPrefs) ?? '';
  }

  @override
  Future<bool> setAccessToken(String value) async {
    return _prefs.setString(_kAccessTokenPrefs, value);
  }

  @override
  String getUsername() {
    return _prefs.getString(_kUsername) ?? '';
  }

  @override
  Future<bool> setUsername(String value) async {
    return _prefs.setString(_kUsername, value);
  }

  @override
  String getPassword() {
    return _prefs.getString(_password) ?? '';
  }

  @override
  Future<bool> setPassword(String value) async {
    return _prefs.setString(_password, value);
  }

  @override
  String getAccountID() {
    return _prefs.getString(_accountID) ?? '';
  }

  @override
  Future<bool> setAccountID(String value) async {
    return _prefs.setString(_accountID, value);
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

  @override
  String getTokenSecret() {
    return _prefs.getString(_kTokenSecretPrefs) ?? '';
  }

  @override
  Future<bool> setTokenSecret(String value) {
    return _prefs.setString(_kTokenSecretPrefs, value);
  }

}
