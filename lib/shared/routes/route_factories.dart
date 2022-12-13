import 'package:blu_time/app_loader.dart';
import 'package:blu_time/screens/home/home_screen.dart';
import 'package:blu_time/screens/onboarding/login_screen.dart';
import 'package:blu_time/screens/onboarding/verification_screen.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:flutter/material.dart';

class RouteFactories{

  static Route generateRoute(RouteSettings settings){
     switch (settings.name){
       case RouteNames.appLoader:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const AppLoader());
       case RouteNames.login:
         return MaterialPageRoute(
             settings: settings, builder: (context) => LoginScreen());
       case RouteNames.home:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const HomeScreen());
       case RouteNames.verification:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const VerificationScreen(email: "email"));
       default:
         return errorRoute;
     }
  }

  static Route get errorRoute => MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(child: Text('Error')),
      );
    },
  );

}