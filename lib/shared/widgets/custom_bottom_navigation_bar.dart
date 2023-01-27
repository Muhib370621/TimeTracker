import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:blu_time/shared/Prompts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/BottomNavigationController.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  var data = Get.arguments;
  // final int index;
  CustomBottomNavigationBar({
    super.key,
  });

  final BottomNavController controller = Get.put(BottomNavController());
  final StartingScreenController stController = Get.put(StartingScreenController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: controller.pages,
          ),
          bottomNavigationBar: Container(
            color: Colors.transparent,
            width: size.width,
            height: 0.119 * size.height,
            child: Stack(children: [

              Positioned(
                top: 0.036 * size.height,
                child: Container(
                  // margin: const EdgeInsets.only(top: 30),
                  decoration: const BoxDecoration(
                    color: AppColors.bottomBar,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  width: size.width,
                  height: 0.2 * size.height,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: controller.currentIndex.value == 0 ? 5 : 35.2,
                      ),
                      child: GestureDetector(
                          onTap: () {
                            controller.locationLoading.value == false
                                ? controller.setBottomBarIndex(0)
                                : null;
                          },
                          child: Column(
                            children: [
                              Container(
                                height: controller.currentIndex.value == 0
                                    ? size.height * 0.07
                                    : size.height * 0.03,
                                width: controller.currentIndex.value == 0
                                    ? size.width * 0.15
                                    : size.width * 0.10,
                                decoration: BoxDecoration(
                                    color: controller.currentIndex.value == 0
                                        ? AppColors.buttonBlue
                                        : AppColors.bottomBar,
                                    shape: BoxShape.circle),
                                child: Image.asset(
                                  AppAssets.clockIcon,
                                  scale: controller.currentIndex.value == 0
                                      ? 2.5
                                      : 2.6,
                                  color: controller.currentIndex.value == 0
                                      ? Colors.white
                                      : Colors.blueAccent,
                                ),
                              ),
                              SizedBox(
                                height: controller.currentIndex.value == 0
                                    ? 0
                                    : size.height * 0.008,
                              ),
                              Text(
                                "Clock",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: controller.currentIndex.value == 0
                                        ? 14
                                        : 13),
                              )
                            ],
                          )

                          // splashColor: Colors.white,

                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: controller.currentIndex.value == 1 ? 5 : 35.2),
                      child: GestureDetector(
                          onTap: () {
                            controller.locationLoading.value == false
                                ? controller.setBottomBarIndex(1)
                                : null;
                          },
                          child: Column(
                            children: [
                              Container(
                                height: controller.currentIndex.value == 1
                                    ? size.height * 0.07
                                    : size.height * 0.03,
                                width: controller.currentIndex.value == 1
                                    ? size.width * 0.15
                                    : size.width * 0.10,
                                decoration: BoxDecoration(
                                    color: controller.currentIndex.value == 1
                                        ? AppColors.buttonBlue
                                        : AppColors.bottomBar,
                                    shape: BoxShape.circle),
                                child: Image.asset(
                                  AppAssets.timeCardIcon,
                                  scale: controller.currentIndex.value == 1
                                      ? 2.5
                                      : 2.6,
                                  color: controller.currentIndex.value == 1
                                      ? Colors.white
                                      : Colors.blueAccent,
                                ),
                              ),
                              SizedBox(
                                height: controller.currentIndex.value == 1
                                    ? 0
                                    : size.height * 0.008,
                              ),
                              Text(
                                "Time Cards",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: controller.currentIndex.value == 1
                                        ? 14
                                        : 13),
                              )
                            ],
                          )

                          // splashColor: Colors.white,

                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: controller.currentIndex.value == 2 ? 10 : 35),
                      child: GestureDetector(
                          onTap: () {
                            controller.locationLoading.value == false
                                ? controller.setBottomBarIndex(2)
                                : null;
                          },
                          child: Column(
                            children: [
                              Container(
                                height: controller.currentIndex.value == 2
                                    ? size.height * 0.07
                                    : size.height * 0.03,
                                width: controller.currentIndex.value == 2
                                    ? size.width * 0.15
                                    : size.width * 0.10,
                                decoration: BoxDecoration(
                                    color: controller.currentIndex.value == 2
                                        ? AppColors.buttonBlue
                                        : AppColors.bottomBar,
                                    shape: BoxShape.circle),
                                child: Image.asset(
                                  AppAssets.taskIcon,
                                  scale: controller.currentIndex.value == 2
                                      ? 2.5
                                      : 2.6,
                                  color: controller.currentIndex.value == 2
                                      ? Colors.white
                                      : Colors.blueAccent,
                                ),
                              ),
                              SizedBox(
                                height: controller.currentIndex.value == 2
                                    ? 0
                                    : size.height * 0.008,
                              ),
                              Text(
                                "Projects",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: controller.currentIndex.value == 2
                                        ? 14
                                        : 13),
                              )
                            ],
                          )

                          // splashColor: Colors.white,

                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: controller.currentIndex.value == 3 ? 10 : 35),
                      child: GestureDetector(
                          onTap: () {
                            if (controller.projectId.isEmpty) {
                              Prompts.showSnackBar(msg: "Please select a project");
                              return;
                            }
                            controller.locationLoading.value == false
                                ? controller.setBottomBarIndex(3)
                                : null;
                          },
                          child: Column(
                            children: [
                              Container(
                                height: controller.currentIndex.value == 3
                                    ? size.height * 0.07
                                    : size.height * 0.03,
                                width: controller.currentIndex.value == 3
                                    ? size.width * 0.15
                                    : size.width * 0.10,
                                decoration: BoxDecoration(
                                    color: controller.currentIndex.value == 3
                                        ? AppColors.buttonBlue
                                        : AppColors.bottomBar,
                                    shape: BoxShape.circle),
                                child: Image.asset(
                                  AppAssets.chatIcon,
                                  scale: controller.currentIndex.value == 3
                                      ? 2.5
                                      : 2.6,
                                  color: controller.currentIndex.value == 3
                                      ? Colors.white
                                      : Colors.blueAccent,
                                ),
                              ),
                              SizedBox(
                                height: controller.currentIndex.value == 3
                                    ? 0
                                    : size.height * 0.008,
                              ),
                              Text(
                                "Chat",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: controller.currentIndex.value == 3
                                        ? 14
                                        : 13),
                              )
                            ],
                          )

                          // splashColor: Colors.white,

                          ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: stController.locationLoading.value || stController.isStopSelecting.value || stController.isChecklistConfirm.value==true,
                child: Container(
                  height: 0.2*size.height,
                  color: AppColors.bottomBar.withOpacity(0.7),
                ),
              ),
            ]),
          ),
        ));
  }
}
