import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/shared/routes/route_factories.dart';
import 'package:blu_time/shared/routes/route_names.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
     // builder: DevicePreview.appBuilder,
     // locale: DevicePreview.,
     // locale: DevicePreview.locale(context),
      title: 'bluTime',
      theme: ThemeData(
        backgroundColor: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Montserrat",
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.appLoader,
      onGenerateRoute: RouteFactories.generateRoute,
    );
  }
}
