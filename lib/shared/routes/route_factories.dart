import 'package:blu_time/app_loader.dart';
import 'package:blu_time/screens/StartingScreen/starting_screen.dart';
import 'package:blu_time/screens/home/clock_screen.dart';
import 'package:blu_time/screens/home/home_screen.dart';
import 'package:blu_time/screens/profile/profile_screen.dart';
import 'package:blu_time/screens/project/add_note_screen.dart';
import 'package:blu_time/screens/project/checklist_screen.dart';
import 'package:blu_time/screens/project/note_list_screen.dart';
import 'package:blu_time/screens/project/project_detail_holder_screen.dart';
import 'package:blu_time/screens/project/project_detail_screen.dart';
import 'package:blu_time/screens/project/projects_screen.dart';
import 'package:blu_time/screens/home/tasks_screen.dart';
import 'package:blu_time/screens/time_card/time_card_detail_screen.dart';
import 'package:blu_time/screens/onboarding/change_password.dart';
import 'package:blu_time/screens/onboarding/forgot_password.dart';
import 'package:blu_time/screens/onboarding/login_screen.dart';
import 'package:blu_time/screens/onboarding/verification_screen.dart';
import 'package:blu_time/screens/time_card/time_card_screen.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:flutter/material.dart';

class RouteFactories{

  static final GlobalKey<NavigatorState> clockKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> clockStartKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> timeCardKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> tasksKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> projectsKey = GlobalKey<NavigatorState>();

  static const int clockIndex = 0;
  static const int clockStartIndex = 1;
  static const int timeCardIndex = 2;
  static const int taskIndex = 3;
  static const int projectIndex =4;

  static GlobalKey<NavigatorState> _currentNavigator = clockKey;
  static GlobalKey<NavigatorState> get currentNavigator => _currentNavigator;

  static void updateCurrentNavigator(int currentIndex) {
    switch (currentIndex) {
      case clockIndex:
        _currentNavigator = clockKey;
        break;
      case clockStartIndex:
        _currentNavigator = clockStartKey;
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
       case RouteNames.startScreen:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const StartingScreen());
       case RouteNames.projectDetailHolder:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const ProjectDetailHolderScreen());
       case RouteNames.projectDetail:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const ProjectDetailScreen());
         case RouteNames.noteList:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const NoteListScreen());
       case RouteNames.addNote:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const AddNoteScreen());
       case RouteNames.profile:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const ProfileScreen());
       case RouteNames.checklist:
         return MaterialPageRoute(
             settings: settings, builder: (context) => const CheckListScreen());
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