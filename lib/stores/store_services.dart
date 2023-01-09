import 'package:blu_time/constants/app_storage.dart';
import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:hive/hive.dart';
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

  Future<List<T>> getLocal<T extends Decodable>(String key, T type);
  setLocal(String key,dynamic value);
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

  @override
  Future<List<T>> getLocal<T extends Decodable>(String key, T type) async {
    var box = await Hive.openBox(AppStorage.localBox);
    try {
      List<dynamic> testing = box.get(key);
      return (testing.map((e) => type.decode(Map<String, dynamic>.from(e)))).cast<T>().toList();
    } catch (e) {
      return [];
    }
  }


   @override
  setLocal(String key,dynamic value) async {
    var box = await Hive.openBox(AppStorage.localBox);
    try {
     await box.put(key, value.map((e) => e.toJson()).toList());
    } catch (e) {
      return [];
    }
  }

}


