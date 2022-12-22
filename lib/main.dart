import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/shared/routes/route_factories.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupLocator();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EasyLocalization(
      supportedLocales: const [Locale('en', ''), Locale('es', '')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', ''),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      // localizationsDelegates: const [
      //   AppLocalizations.delegate, // Add this line
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // //locale:Locale('en', ''),
      // supportedLocales: const [
      //   Locale('en', ''), // English, no country code
      //   Locale('es', ''), // Spanish, no country code
      // ],
      //locale:Locale('en', ''),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
