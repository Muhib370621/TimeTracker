import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/screens/StartingScreen/starting_screen.dart';
import 'package:blu_time/screens/chat/chatScreen.dart';
import 'package:blu_time/screens/project/projects_screen.dart';
import 'package:blu_time/screens/time_card/time_card_screen.dart';
import 'package:flutter/material.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int index;
  final Function(int) onTap;
  const CustomBottomNavigationBar(
      {Key? key, required this.index, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavBarV2(index: index,onTap: onTap,);
    //   BottomNavigationBar(
    //   currentIndex: index,
    //   backgroundColor: AppColors.bottomBar,
    //   onTap: onTap,
    //   iconSize: 24,
    //   selectedItemColor: AppColors.background,
    //   unselectedItemColor: AppColors.timerColor,
    //   selectedLabelStyle: AppTextStyles.semiBold.copyWith(fontSize: 12),
    //   unselectedLabelStyle: AppTextStyles.semiBold.copyWith(fontSize: 12),
    //   type: BottomNavigationBarType.fixed,
    //   elevation: 0,
    //   items: [
    //     BottomNavigationBarItem(
    //       label: "Clock",
    //       icon: Image.asset("assets/images/clock.png", height: 20),
    //       activeIcon: Image.asset("assets/images/selectedClock.png", height: 30),
    //     ),
    //     BottomNavigationBarItem(
    //       label: "Time Cards",
    //       icon: Image.asset("assets/images/timecard.png", height: 20),
    //       activeIcon: const Icon(
    //         Icons.list_alt_outlined,
    //         size: 24,
    //         color: AppColors.background,
    //       ),
    //     ),
    //     BottomNavigationBarItem(
    //       label: "Tasks",
    //       icon: Image.asset("assets/images/task.png", height: 20),
    //
    //       activeIcon: Icon(
    //         Icons.task_sharp,
    //         size: 24,
    //         color: AppColors.background,
    //       ),
    //     ),
    //     BottomNavigationBarItem(
    //       label: "Chat",
    //       icon: Image.asset("assets/images/chat.png", height: 20),
    //       activeIcon: const Icon(
    //         Icons.on_device_training,
    //         size: 24,
    //         color: AppColors.background,
    //       ),
    //     ),
    //   ],
    // );
  }
}

class BottomNavBarV2 extends StatefulWidget {
  final int index;
  final Function(int) onTap;

  const BottomNavBarV2({super.key, required this.index, required this.onTap});
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State(onTap,index);
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  final int index;
  final Function(int) onTap;
  int currentIndex = 0;
  final List pages = [
   const StartingScreen(),
    const TimeCardScreen(),
    const ProjectsScreen(),
    const ChatScreen(),
  ];

  _BottomNavBarV2State( this.onTap, this.index);

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return
      Scaffold(
      body:
      pages[currentIndex],
      bottomNavigationBar:
      Stack(
        children: [
          Container(
            width: size.width,
            height: 90,
            child: Stack(
              clipBehavior: Clip.none,
              // overflow: Overflow.visible,
              children: [
                Stack(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    decoration: const BoxDecoration(
                      color: AppColors.bottomBar,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    width: size.width,
                    height: 120,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.only(top: currentIndex == 0 ? 10 : 35),
                          child: GestureDetector(
                              onTap: () {
                                setBottomBarIndex(0);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: currentIndex == 0
                                        ? size.height * 0.07
                                        : size.height * 0.03,
                                    width: currentIndex == 0
                                        ? size.width * 0.15
                                        : size.width * 0.10,
                                    decoration: BoxDecoration(
                                        color: currentIndex == 0
                                            ? AppColors.buttonBlue
                                            : AppColors.bottomBar,
                                        shape: BoxShape.circle),
                                    child: Image.asset(
                                      AppAssets.clockIcon,
                                      scale: currentIndex == 0 ? 2.5 : 2.6,
                                      color: currentIndex == 0
                                          ? Colors.white
                                          : Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(
                                    height: currentIndex == 0
                                        ? 0
                                        : size.height * 0.008,
                                  ),
                                  Text(
                                    "Clock",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: currentIndex == 0 ? 14 : 13),
                                  )
                                ],
                              )

                            // splashColor: Colors.white,

                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(top: currentIndex == 1 ? 10 : 35),
                          child: GestureDetector(
                              onTap: () {
                                setBottomBarIndex(1);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: currentIndex == 1
                                        ? size.height * 0.07
                                        : size.height * 0.03,
                                    width: currentIndex == 1
                                        ? size.width * 0.15
                                        : size.width * 0.10,
                                    decoration: BoxDecoration(
                                        color: currentIndex == 1
                                            ? AppColors.buttonBlue
                                            : AppColors.bottomBar,
                                        shape: BoxShape.circle),
                                    child: Image.asset(
                                      AppAssets.timeCardIcon,
                                      scale: currentIndex == 1 ? 2.5 : 2.6,
                                      color: currentIndex == 1
                                          ? Colors.white
                                          : Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(
                                    height: currentIndex == 1
                                        ? 0
                                        : size.height * 0.008,
                                  ),
                                  Text(
                                    "Time Cards",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: currentIndex == 1 ? 14 : 13),
                                  )
                                ],
                              )

                            // splashColor: Colors.white,

                          ),
                        ),
                        // SizedBox(
                        //   width: size.width * 0.20,
                        // ),
                        Padding(
                          padding:
                          EdgeInsets.only(top: currentIndex == 2 ? 10 : 35),
                          child: GestureDetector(
                              onTap: () {
                                setBottomBarIndex(2);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: currentIndex == 2
                                        ? size.height * 0.07
                                        : size.height * 0.03,
                                    width: currentIndex == 2
                                        ? size.width * 0.15
                                        : size.width * 0.10,
                                    decoration: BoxDecoration(
                                        color: currentIndex == 2
                                            ? AppColors.buttonBlue
                                            : AppColors.bottomBar,
                                        shape: BoxShape.circle),
                                    child: Image.asset(
                                      AppAssets.taskIcon,
                                      scale: currentIndex == 2 ? 2.5 : 2.6,
                                      color: currentIndex == 2
                                          ? Colors.white
                                          : Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(
                                    height: currentIndex == 2
                                        ? 0
                                        : size.height * 0.008,
                                  ),
                                  Text(
                                    "Projects",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: currentIndex == 2 ? 14 : 13),
                                  )
                                ],
                              )

                            // splashColor: Colors.white,

                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(top: currentIndex == 3 ? 10 : 35),
                          child: GestureDetector(
                              onTap: () {
                                setBottomBarIndex(3);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: currentIndex == 3
                                        ? size.height * 0.07
                                        : size.height * 0.03,
                                    width: currentIndex == 3
                                        ? size.width * 0.15
                                        : size.width * 0.10,
                                    decoration: BoxDecoration(
                                        color: currentIndex == 3
                                            ? AppColors.buttonBlue
                                            : AppColors.bottomBar,
                                        shape: BoxShape.circle),
                                    child: Image.asset(
                                      AppAssets.chatIcon,
                                      scale: currentIndex == 3 ? 2.5 : 2.6,
                                      color: currentIndex == 3
                                          ? Colors.white
                                          : Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(
                                    height: currentIndex ==3
                                        ? 0
                                        : size.height * 0.008,
                                  ),
                                  Text(
                                    "Chat",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: currentIndex == 3 ? 14 : 13),
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
          )
        ],
      ),
    );
  }
}


