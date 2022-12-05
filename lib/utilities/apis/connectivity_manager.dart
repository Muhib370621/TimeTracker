import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityManager{
  final Connectivity connectivity = Connectivity();
  ConnectivityManager._privateConstructor();
  static final ConnectivityManager _instance = ConnectivityManager._privateConstructor();
  static ConnectivityManager get instance => _instance;

  Future<bool> isOnline() async {
    ConnectivityResult connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

}