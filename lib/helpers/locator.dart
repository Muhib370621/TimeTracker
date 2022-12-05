import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<StoreServices>(() => StoreServicesImpl(sharedPreferences));
  locator.registerLazySingleton(() => ApiServices());
}