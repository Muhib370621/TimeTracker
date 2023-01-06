import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/BottomNavigationController.dart';

// class CustomBottomNavigationBar extends StatelessWidget {
//   final int index;
//   final Function(int) onTap;
//
//   const CustomBottomNavigationBar(
//       {Key? key, required this.index, required this.onTap})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavBarV2(
//       index: index,
//       onTap: onTap,
//     );
//     //   BottomNavigationBar(
//     //   currentIndex: index,
//     //   backgroundColor: AppColors.bottomBar,
//     //   onTap: onTap,
//     //   iconSize: 24,
//     //   selectedItemColor: AppColors.background,
//     //   unselectedItemColor: AppColors.timerColor,
//     //   selectedLabelStyle: AppTextStyles.semiBold.copyWith(fontSize: 12),
//     //   unselectedLabelStyle: AppTextStyles.semiBold.copyWith(fontSize: 12),
//     //   type: BottomNavigationBarType.fixed,
//     //   elevation: 0,
//     //   items: [
//     //     BottomNavigationBarItem(
//     //       label: "Clock",
//     //       icon: Image.asset("assets/images/clock.png", height: 20),
//     //       activeIcon: Image.asset("assets/images/selectedClock.png", height: 30),
//     //     ),
//     //     BottomNavigationBarItem(
//     //       label: "Time Cards",
//     //       icon: Image.asset("assets/images/timecard.png", height: 20),
//     //       activeIcon: const Icon(
//     //         Icons.list_alt_outlined,
//     //         size: 24,
//     //         color: AppColors.background,
//     //       ),
//     //     ),
//     //     BottomNavigationBarItem(
//     //       label: "Tasks",
//     //       icon: Image.asset("assets/images/task.png", height: 20),
//     //
//     //       activeIcon: Icon(
//     //         Icons.task_sharp,
//     //         size: 24,
//     //         color: AppColors.background,
//     //       ),
//     //     ),
//     //     BottomNavigationBarItem(
//     //       label: "Chat",
//     //       icon: Image.asset("assets/images/chat.png", height: 20),
//     //       activeIcon: const Icon(
//     //         Icons.on_device_training,
//     //         size: 24,
//     //         color: AppColors.background,
//     //       ),
//     //     ),
//     //   ],
//     // );
//   }
// }

class CustomBottomNavigationBar extends StatelessWidget {
  // final int index;
  // final Function(int) onTap;
   CustomBottomNavigationBar({
    super.key,
  });

  final BottomNavController controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(() => Scaffold(
          body: controller.pages[controller.currentIndex.value],
          bottomNavigationBar: SizedBox(
            width: size.width,
            height: 0.119 * size.height,
            child: Stack(
              children: [
                Stack(children: [
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
                            top: controller.currentIndex.value == 0 ? 10 : 35.2,
                          ),
                          child: GestureDetector(
                              onTap: () {
                                controller.setBottomBarIndex(0);
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
                                        color:
                                            controller.currentIndex.value == 0
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
                                        fontSize:
                                            controller.currentIndex.value == 0
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
                              top: controller.currentIndex.value == 1
                                  ? 10
                                  : 35.2),
                          child: GestureDetector(
                              onTap: () {
                                controller.setBottomBarIndex(1);
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
                                        color:
                                            controller.currentIndex.value == 1
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
                                        fontSize:
                                            controller.currentIndex.value == 1
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
                              top:
                                  controller.currentIndex.value == 2 ? 10 : 35),
                          child: GestureDetector(
                              onTap: () {
                                controller.setBottomBarIndex(2);
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
                                        color:
                                            controller.currentIndex.value == 2
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
                                        fontSize:
                                            controller.currentIndex.value == 2
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
                              top:
                                  controller.currentIndex.value == 3 ? 10 : 35),
                          child: GestureDetector(
                              onTap: () {
                                controller.setBottomBarIndex(3);
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
                                        color:
                                            controller.currentIndex.value == 3
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
                                        fontSize:
                                            controller.currentIndex.value == 3
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
                ])
              ],
            ),
          ),
        ));
  }
}
