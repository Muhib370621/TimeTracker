import 'package:blu_time/app_loader.dart';
import 'package:blu_time/screens/home/clock_screen.dart';
import 'package:blu_time/screens/home/home_screen.dart';
import 'package:blu_time/screens/home/projects_screen.dart';
import 'package:blu_time/screens/home/tasks_screen.dart';
import 'package:blu_time/screens/home/time_card_detail_screen.dart';
import 'package:blu_time/screens/home/time_card_screen.dart';
import 'package:blu_time/screens/onboarding/change_password.dart';
import 'package:blu_time/screens/onboarding/forgot_password.dart';
import 'package:blu_time/screens/onboarding/login_screen.dart';
import 'package:blu_time/screens/onboarding/verification_screen.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:flutter/material.dart';

class RouteFactories{

  static final GlobalKey<NavigatorState> clockKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> timeCardKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> tasksKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> projectsKey = GlobalKey<NavigatorState>();

  static const int clockIndex = 0;
  static const int timeCardIndex = 1;
  static const int taskIndex = 2;
  static const int projectIndex = 3;

  static GlobalKey<NavigatorState> _currentNavigator = clockKey;
  static GlobalKey<NavigatorState> get currentNavigator => _currentNavigator;

  static void updateCurrentNavigator(int currentIndex) {
    switch (currentIndex) {
      case clockIndex:
        _currentNavigator = clockKey;
        break;
      case timeCardIndex:
        _currentNavigator = timeCardKey;
        break;
      case taskIndex:
        _currentNavigator = tasksKey;
        break;
      case projectIndex:
        _currentNavigator = projectsKey;
        break;
    }
  }

  static void popCurrentRouteToFirst() {
    if (currentNavigator.currentState != null) {
      currentNavigator.currentState!.popUntil((route) => route.isFirst);
    }
  }


  static Route generateRoute(RouteSettings settings){
     switch (settings.name){
       case RouteNames.appLoader:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const AppLoader());
       case RouteNames.clock:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const ClockScreen());
       case RouteNames.timeCard:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const TimeCardScreen());
       case RouteNames.task:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const TasksScreen());
       case RouteNames.project:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const ProjectsScreen());
       case RouteNames.login:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const LoginScreen());
       case RouteNames.home:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const HomeScreen());
       case RouteNames.verification:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const VerificationScreen(email: "email"));
       case RouteNames.forgotPassword:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const ForgotPassword());
       case RouteNames.changePassword:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const ChangePassword());
       case RouteNames.timeCardDetail:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const TimeCardDetailScreen());
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