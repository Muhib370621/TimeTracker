import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/screens/StartingScreen/starting_screen.dart';
import 'package:blu_time/screens/home/tasks_screen.dart';
import 'package:blu_time/screens/time_card/time_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:blu_time/shared/routes/route_factories.dart';
import 'package:blu_time/shared/routes/route_names.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int index;
  final Function(int) onTap;
  const CustomBottomNavigationBar(
      {Key? key, required this.index, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      backgroundColor: AppColors.bottomBar,
      onTap: onTap,
      iconSize: 24,
      selectedItemColor: AppColors.background,
      unselectedItemColor: AppColors.timerColor,
      selectedLabelStyle: AppTextStyles.semiBold.copyWith(fontSize: 12),
      unselectedLabelStyle: AppTextStyles.semiBold.copyWith(fontSize: 12),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          label: "Clock",
          icon: Image.asset("assets/images/clock.png", height: 20),
          activeIcon: Image.asset("assets/images/selectedClock.png", height: 30),
        ),
        BottomNavigationBarItem(
          label: "Time Cards",
          icon: Image.asset("assets/images/timecard.png", height: 20),
          activeIcon: const Icon(
            Icons.list_alt_outlined,
            size: 24,
            color: AppColors.background,
          ),
        ),
        BottomNavigationBarItem(
          label: "Tasks",
          icon: Image.asset("assets/images/task.png", height: 20),

          activeIcon: Icon(
            Icons.task_sharp,
            size: 24,
            color: AppColors.background,
          ),
        ),
        BottomNavigationBarItem(
          label: "Chat",
          icon: Image.asset("assets/images/chat.png", height: 20),
          activeIcon: const Icon(
            Icons.on_device_training,
            size: 24,
            color: AppColors.background,
          ),
        ),
      ],
    );
  }
}

class BottomNavBarV2 extends StatefulWidget {
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  int currentIndex = 0;
  final List pages = [
   StartingScreen(),
    TimeCardScreen(),
    TasksScreen(),
    StartingScreen(),
  ];

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
                // CustomPaint(
                //   size: Size(size.width, 80),
                //   painter: BNBCustomPainter(),
                // ),
                // Center(
                //   heightFactor: 0.6,
                //   child: FloatingActionButton(
                //       backgroundColor: Colors.orange,
                //       child: Icon(Icons.shopping_basket),
                //       elevation: 0.1,
                //       onPressed: () {}),
                // ),
                Stack(children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
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
      )
    );
  }
}

// class BNBCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = new Paint()
//       ..color = Colors.black12
//       ..style = PaintingStyle.fill;
//
//     Path path = Path();
//     path.moveTo(0, 0); // Start
//     // path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
//     // path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
//     // path.arcToPoint(Offset(size.width * 0.60, 20),
//     //     radius: Radius.circular(20.0), clockwise: false);
//     // path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
//     // path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
//     // path.lineTo(size.width, size.height);
//     // path.lineTo(0, size.height);
//     // path.lineTo(0, 0);
//     canvas.drawShadow(path, Colors.black, 5, true);
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

