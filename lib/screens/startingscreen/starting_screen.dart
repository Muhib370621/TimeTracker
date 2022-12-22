import 'dart:ui';

import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/screens/home/clock_screen.dart';
import 'package:blu_time/screens/home/projects_screen.dart';
import 'package:blu_time/screens/home/tasks_screen.dart';
import 'package:blu_time/screens/home/time_card_screen.dart';
import 'package:blu_time/shared/routes/route_factories.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:blu_time/view_models/home_view_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:stacked/stacked.dart';


class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  late DateTime dateTime;
  String _timeString = '';

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _getTime();
    });
    super.initState();
  }
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }
  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  Widget bodyTab(HomeViewModel viewModel) {
    return IndexedStack(
      index: viewModel.selectedIndex,
      children: [
        Navigator(
          key: RouteFactories.clockKey,
          onGenerateRoute: RouteFactories.generateRoute,
          initialRoute: RouteNames.clock,
          onGenerateInitialRoutes: (navigator,initialRoute) => [
            MaterialPageRoute(builder: (context) => const ClockScreen())
          ],
        ),
        Navigator(
          key: RouteFactories.timeCardKey,
          onGenerateRoute: RouteFactories.generateRoute,
          initialRoute: RouteNames.timeCard,
          onGenerateInitialRoutes: (navigator,initialRoute) => [
            MaterialPageRoute(builder: (context) => const TimeCardScreen())
          ],
        ),
        Navigator(
          key: RouteFactories.tasksKey,
          onGenerateRoute: RouteFactories.generateRoute,
          initialRoute: RouteNames.task,
          onGenerateInitialRoutes: (navigator,initialRoute) => [
            MaterialPageRoute(builder: (context) => const TasksScreen())
          ],
        ),
        Navigator(
          key: RouteFactories.projectsKey,
          onGenerateRoute: RouteFactories.generateRoute,
          initialRoute: RouteNames.project,
          onGenerateInitialRoutes: (navigator,initialRoute) => [
            MaterialPageRoute(builder: (context) => const ProjectsScreen())
          ],
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return

      ViewModelBuilder<HomeViewModel>.reactive(
          viewModelBuilder: () => HomeViewModel(),
          builder: (context, viewModel, child) {
            return Scaffold(
              // backgroundColor: Colors.white,
              appBar: const BluTimeAppHeader(leadingImage: AppAssets.profilePlaceholder,backEnabled: false,),
              bottomNavigationBar: CustomBottomNavigationBar(
                index: viewModel.selectedIndex,
                onTap: viewModel.onTapItem,
              ),
              body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 55,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('  $_timeString', style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                          color: Color(0xff0062BD)
                      ),),
                      Container(
                        height: 25,
                        width: 36,
                        child: const Center(
                          child:  Card(
                            child: Text('PM', style: TextStyle(
                              color: Color(0xff8B8B8B),
                              fontWeight: FontWeight.w600,
                              fontSize: 12
                            ),),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Text('Tuesday, Dec 06', style:  TextStyle(
                      fontFeatures: [FontFeature.subscripts()],
                      color: Color(0xff000000)
                  ),),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.57,
                    // Below is the code for Linear Gradient.
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      gradient:  LinearGradient(
                        colors: [const Color(0xff0062BD), const Color(0xff002D4B).withOpacity(0.9)],
                        begin: Alignment.bottomLeft,
                        // end: Alignment.topRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height:130,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Image.asset('assets/images/Group 137.png'),
                        ),
                        Container(
                          child: const Text('00:00:00', style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xffFFFFFF),
                            fontSize: 25
                          ),),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text('Start Work', style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xffFFFFFF),
                            fontSize: 11
                          ),),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(
                // padding: const EdgeInsets.symmetric(vertical: 30),
                child:  Text('User Current Location Here', style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),),
              ),
              Container(
                padding: const EdgeInsets.only(left: 50, top:80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 30,
                          child: Image.asset("assets/images/Group 196.png"),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text('00:00', style: TextStyle(
                              color: Color(0xffFF4A00),
                              fontWeight: FontWeight.w700
                          ),),
                        ),
                        Container(
                          // padding: const EdgeInsets.only(top: 10),
                          child: const Text('Start Work', style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w400,
                              fontSize: 10
                          ),),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30,
                          padding: const EdgeInsets.only(left: 45),
                          child: Image.asset("assets/images/Group 197.png"),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10, left: 45),
                          child: const Text('00:00', style: TextStyle(
                              color: Color(0xffFF4A00),
                              fontWeight: FontWeight.w700
                          ),),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 50),
                          child: const Text('Finish Work', style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w400,
                              fontSize: 10
                          ),),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30,
                          padding: const EdgeInsets.only(left: 45),
                          child: Image.asset("assets/images/Group 198.png"),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10, left: 45),
                          child: const Text('00:00', style: TextStyle(
                              color: Color(0xffFF4A00),
                              fontWeight: FontWeight.w700
                          ),),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 50),
                          child: const Text('Total Work', style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w400,
                              fontSize: 10
                          ),),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
              // bodyTab(viewModel),
            );
          });



    //   Scaffold(
    //   appBar: const BluTimeAppHeader(leadingImage: AppAssets.profilePlaceholder,backEnabled: false,),
    //   body: Stack(
    //     children: [
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           const SizedBox(
    //             height: 55,
    //           ),
    //           Column(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text('  $_timeString', style: const TextStyle(
    //                       fontWeight: FontWeight.w600,
    //                       fontSize: 40,
    //                       color: Color(0xff0062BD)
    //                   ),),
    //                   Container(
    //                     height: 25,
    //                     width: 36,
    //                     child: const Center(
    //                       child:  Card(
    //                         child: Text('PM', style: TextStyle(
    //                           color: Color(0xff8B8B8B),
    //                           fontWeight: FontWeight.w600,
    //                           fontSize: 12
    //                         ),),
    //                       ),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //               const Text('Tuesday, Dec 06', style:  TextStyle(
    //                   fontFeatures: [FontFeature.subscripts()],
    //                   color: Color(0xff000000)
    //               ),),
    //               const SizedBox(
    //                 height: 100,
    //               ),
    //               Container(
    //                 height: MediaQuery.of(context).size.height * 0.25,
    //                 width: MediaQuery.of(context).size.width * 0.57,
    //                 // Below is the code for Linear Gradient.
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(150.0),
    //                   gradient:  LinearGradient(
    //                     colors: [const Color(0xff0062BD), const Color(0xff002D4B).withOpacity(0.9)],
    //                     begin: Alignment.bottomLeft,
    //                     // end: Alignment.topRight,
    //                   ),
    //                 ),
    //                 child: Column(
    //                   children: [
    //                     Container(
    //                       height:130,
    //                       padding: const EdgeInsets.symmetric(vertical: 20),
    //                       child: Image.asset('assets/images/Group 137.png'),
    //                     ),
    //                     Container(
    //                       child: const Text('00:00:00', style: TextStyle(
    //                         fontWeight: FontWeight.w700,
    //                         color: Color(0xffFFFFFF),
    //                         fontSize: 25
    //                       ),),
    //                     ),
    //                     Container(
    //                       padding: const EdgeInsets.symmetric(vertical: 10),
    //                       child: const Text('Start Work', style: TextStyle(
    //                         fontWeight: FontWeight.w700,
    //                         color: Color(0xffFFFFFF),
    //                         fontSize: 11
    //                       ),),
    //                     ),
    //
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 30,
    //           ),
    //           const Center(
    //             // padding: const EdgeInsets.symmetric(vertical: 30),
    //             child:  Text('User Current Location Here', style: TextStyle(
    //                 fontWeight: FontWeight.w400,
    //                 fontSize: 14
    //             ),),
    //           ),
    //           Container(
    //             padding: const EdgeInsets.only(left: 50, top:80),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 Column(
    //                   children: [
    //                     Container(
    //                       height: 30,
    //                       child: Image.asset("assets/images/Group 196.png"),
    //                     ),
    //                     Container(
    //                       padding: const EdgeInsets.only(top: 10),
    //                       child: const Text('00:00', style: TextStyle(
    //                           color: Color(0xffFF4A00),
    //                           fontWeight: FontWeight.w700
    //                       ),),
    //                     ),
    //                     Container(
    //                       // padding: const EdgeInsets.only(top: 10),
    //                       child: const Text('Start Work', style: TextStyle(
    //                           color: Color(0xff000000),
    //                           fontWeight: FontWeight.w400,
    //                           fontSize: 10
    //                       ),),
    //                     ),
    //                   ],
    //                 ),
    //                 Column(
    //                   children: [
    //                     Container(
    //                       height: 30,
    //                       padding: const EdgeInsets.only(left: 45),
    //                       child: Image.asset("assets/images/Group 197.png"),
    //                     ),
    //                     Container(
    //                       padding: const EdgeInsets.only(top: 10, left: 45),
    //                       child: const Text('00:00', style: TextStyle(
    //                           color: Color(0xffFF4A00),
    //                           fontWeight: FontWeight.w700
    //                       ),),
    //                     ),
    //                     Container(
    //                       padding: const EdgeInsets.only(left: 50),
    //                       child: const Text('Finish Work', style: TextStyle(
    //                           color: Color(0xff000000),
    //                           fontWeight: FontWeight.w400,
    //                           fontSize: 10
    //                       ),),
    //                     ),
    //                   ],
    //                 ),
    //                 Column(
    //                   children: [
    //                     Container(
    //                       height: 30,
    //                       padding: const EdgeInsets.only(left: 45),
    //                       child: Image.asset("assets/images/Group 198.png"),
    //                     ),
    //                     Container(
    //                       padding: const EdgeInsets.only(top: 10, left: 45),
    //                       child: const Text('00:00', style: TextStyle(
    //                           color: Color(0xffFF4A00),
    //                           fontWeight: FontWeight.w700
    //                       ),),
    //                     ),
    //                     Container(
    //                       padding: const EdgeInsets.only(left: 50),
    //                       child: const Text('Total Work', style: TextStyle(
    //                           color: Color(0xff000000),
    //                           fontWeight: FontWeight.w400,
    //                           fontSize: 10
    //                       ),),
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    //   bottomNavigationBar: CustomBottomNavigationBar(
    //     index: viewModel.selectedIndex,
    //     onTap: viewModel.onTapItem,
    //   ),,
    // );
  }


}


