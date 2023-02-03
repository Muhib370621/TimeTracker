// import 'package:flutter/material.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/view_models/project_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/StartingScreen/starting_screen.dart';
import '../screens/chat/chatScreen.dart';
import '../screens/project/projects_screen.dart';
import '../screens/time_card/time_card_screen.dart';

class BottomNavController extends GetxController{

  @override
  void onInit() {
    activityName.value="";
    projectName.value="";
    checkListItem.value="";
    super.onInit();
  }

  ///controller variables
  final List <Widget> pages = [
    const StartingScreen(),
    const TimeCardScreen(),
    const ProjectsScreen(),
    const ChatScreen(),
  ].obs;  /// list of pages which we want show on tap of bottom navigation
  RxBool roleSelected = false.obs;        /// the roles selected such as "electrician","technician" or "plumber"
  RxBool locationLoading = false.obs;     /// when we trigger get location function in starting controller
  RxString activityName = "".obs;         /// name of the activity which is selected when we start the timer
  RxString projectName = "".obs;          /// name of the project which is selected when we start the timer
  RxString checkListItem = "".obs;        /// name of the checklist item which is selected when we start the timer
  RxInt currentIndex = 0.obs;             /// it is the current index of the bottom navigation
  RxBool isSingle = false.obs;
  var projectModel = ProjectViewModel().obs;
  Rx<Project> projectList = Project().obs;
  Rxn<Project> currentProject = Rxn<Project>(); ///Current selected project which is then passed to chat screen


  ///set bottom bar index to the desired value
  setBottomBarIndex(index) {
    currentIndex.value = index;
  }

}