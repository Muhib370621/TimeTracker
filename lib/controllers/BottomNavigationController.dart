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
  final List <Widget> pages = [
    const StartingScreen(),
    const TimeCardScreen(),
    const ProjectsScreen(),
    const ChatScreen(),
  ].obs;
  RxBool roleSelected = false.obs;
  RxBool locationLoading = false.obs;

  RxString activityName = "".obs;
  RxString projectName = "".obs;
  RxString checkListItem = "".obs;


  RxInt currentIndex = 0.obs;
  setBottomBarIndex(index) {
    currentIndex.value = index;
  }

}