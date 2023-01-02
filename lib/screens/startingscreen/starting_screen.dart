import 'dart:ui';
import 'dart:async';
import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/screens/home/clock_screen.dart';
import 'package:blu_time/screens/home/tasks_screen.dart';
import 'package:blu_time/screens/project/projects_screen.dart';
import 'package:blu_time/screens/time_card/time_card_screen.dart';
import 'package:blu_time/shared/routes/route_factories.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:blu_time/view_models/home_view_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';
// import 'lib/constants/app_colors.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  late DateTime dateTime;
  String _timeString = '';
  DateTime today = DateTime.now().toLocal();

  // var day = today.day;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      // Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
      // Timer.periodic(Duration(seconds: 1), Timer => _getTime());
      isLoading == false;
      _timeString = _formatDateTime(DateTime.now());
      Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
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

  String role = "";

  void doNothing(BuildContext context) {}
  bool isLoading = false;

  // Widget onTapSlider() {
  //   return Slidable(
  //     // Specify a key if the Slidable is dismissible.
  //     // key: const ValueKey(0),
  //
  //     // The start action pane is the one at the left or the top side.
  //     startActionPane: ActionPane(
  //       // A motion is a widget used to control how the pane animates.
  //       motion: const ScrollMotion(),
  //
  //       // A pane can dismiss the Slidable.
  //       dismissible: DismissiblePane(onDismissed: () {}),
  //
  //       // All actions are defined in the children parameter.
  //       children: [
  //         // A SlidableAction can have an icon and/or a label.
  //         SlidableAction(
  //           flex: 1,
  //           onPressed: doNothing,
  //           backgroundColor: Color(0xFFFE4A49),
  //           foregroundColor: Colors.white,
  //           icon: Icons.delete,
  //           label: 'Delete',
  //         ),
  //         SlidableAction(
  //           onPressed: doNothing,
  //           backgroundColor: Color(0xFF21B7CA),
  //           foregroundColor: Colors.white,
  //           icon: Icons.share,
  //           label: 'Share',
  //         ),
  //       ],
  //     ),
  //
  //     // The end action pane is the one at the right or the bottom side.
  //     // endActionPane: ActionPane(
  //     //   motion: ScrollMotion(),
  //     //   children: [
  //     //     SlidableAction(
  //     //       // An action can be bigger than the others.
  //     //       flex: 2,
  //     //       onPressed: doNothing,
  //     //       backgroundColor: Color(0xFF7BC043),
  //     //       foregroundColor: Colors.white,
  //     //       icon: Icons.archive,
  //     //       label: 'Archive',
  //     //     ),
  //     //     SlidableAction(
  //     //       onPressed: doNothing,
  //     //       backgroundColor: Color(0xFF0392CF),
  //     //       foregroundColor: Colors.white,
  //     //       icon: Icons.save,
  //     //       label: 'Save',
  //     //     ),
  //     //   ],
  //     // ),
  //
  //     // The child of the Slidable is what the user sees when the
  //     // component is not dragged.
  //     child: Container(
  //       // color: Color(0xffE4E4E4),
  //       width: 280,
  //       padding: const EdgeInsets.only(top: 115, bottom: 405),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Container(
  //               decoration: const BoxDecoration(
  //                 color: Color(0xffE4E4E4),
  //                 borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(30),
  //                   bottomRight: Radius.circular(30),
  //                 ),
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Container(
  //                       child: Image.asset(
  //                     "assets/images/FZSnPc.png",
  //                     height: 30,
  //                   )),
  //                   Container(
  //                     child: const RotatedBox(
  //                       quarterTurns: 3,
  //                       child: Text(
  //                         'Select Role  ',
  //                         style: TextStyle(
  //                             color: Color(0xff000000),
  //                             fontSize: 14,
  //                             fontWeight: FontWeight.w500),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //             // ElevatedButton(
  //             //     style: ElevatedButton.styleFrom(
  //             //       backgroundColor: const Color(0xffE4E4E4),
  //             //         shape: const RoundedRectangleBorder(
  //             //           borderRadius: BorderRadius.only(
  //             //             topRight: Radius.circular(30),
  //             //             bottomRight: Radius.circular(30),
  //             //           ),
  //             //         )
  //             //     ),
  //             //     onPressed: () {
  //             //       setState(() {
  //             //         // load=true;
  //             //       });
  //             //     },
  //             //     child: Column(
  //             //       children: [
  //             //         const SizedBox(
  //             //           height: 20,
  //             //         ),
  //             //         Container(
  //             //             child: Image.asset("assets/images/FZSnPc.png")),
  //             //         Container(
  //             //           child: const RotatedBox(
  //             //             quarterTurns: 3,
  //             //             child: Text(
  //             //               'Select Role  ',
  //             //               style: TextStyle(
  //             //                   color: Color(0xff000000),
  //             //                   fontSize: 14,
  //             //                   fontWeight: FontWeight.w500),
  //             //             ),
  //             //           ),
  //             //         ),
  //             //       ],
  //             //     )),
  //           ),
  //           Expanded(
  //             child: ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                   backgroundColor: const Color(0xff0062BD),
  //                   shape: const RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.only(
  //                       topRight: Radius.circular(30),
  //                       bottomRight: Radius.circular(30),
  //                     ),
  //                   )),
  //               onPressed: () {
  //                 setState(() {
  //                   isLoading = !isLoading;
  //                   onTapSlider();
  //                 });
  //               },
  //               child: Container(
  //                 // decoration: BoxDecoration(
  //                 //   borderRadius: BorderRadius.circular(10.0),),
  //                 // padding: const EdgeInsets.only(left: 10),
  //                 height: 45,
  //                 width: 50,
  //                 // color: const Color(0xff0062BD),
  //                 // child: Image.asset("assets/images/cuTOBs.png"),
  //                 child: isLoading == false
  //                     ? const Icon(
  //                         Icons.arrow_forward_ios_outlined,
  //                         color: Color(0xffffffff),
  //                       )
  //                     : Icon(
  //                         Icons.arrow_back_ios_outlined,
  //                         color: Color(0xffffffff),
  //                       ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            // backgroundColor: Colors.white,
            appBar: const BluTimeAppHeader(
              leadingImage: AppAssets.profilePlaceholder,
              backEnabled: false,
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
              index: viewModel.selectedIndex,
              onTap: viewModel.onTapItem,
            ),
            body: Stack(
              children: [
                Center(
                    child: Column(
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
                            Text(
                              '  $_timeString',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 40,
                                  color: Color(0xff0062BD)),
                            ),
                            //Changes required
                            Container(
                              padding: EdgeInsets.all(4),
                              height: 35,
                              width: 46,
                              child: const Center(
                                child: Card(
                                  child: Text(
                                    'PM',
                                    style: TextStyle(
                                        color: Color(0xff8B8B8B),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          DateFormat('EEEE-MMM-yyyy').format(today).toString(),
                          style: TextStyle(
                              fontFeatures: [FontFeature.subscripts()],
                              color: Color(0xff000000),
                              fontSize: 20),
                        ),
                        // Text(DateFormat('EEEE').format(now)),
                        const SizedBox(
                          height: 100,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.57,
                          // Below is the code for Linear Gradient.
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff0062BD),
                                const Color(0xff002D4B).withOpacity(0.9)
                              ],
                              begin: Alignment.bottomLeft,
                              // end: Alignment.topRight,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 130,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child:
                                    Image.asset('assets/images/Group 137.png'),
                              ),
                              Container(
                                child: const Text(
                                  '00:00:00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffFFFFFF),
                                      fontSize: 25),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: const Text(
                                  'Start Work',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffFFFFFF),
                                      fontSize: 11),
                                ),
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
                      child: Text(
                        'User Current Location Here',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 85, top: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 30,
                                child:
                                    Image.asset("assets/images/Group 196.png"),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: const Text(
                                  '00:00',
                                  style: TextStyle(
                                      color: Color(0xffFF4A00),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                // padding: const EdgeInsets.only(top: 10),
                                child: const Text(
                                  'Start Work',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 30,
                                padding: const EdgeInsets.only(left: 45),
                                child:
                                    Image.asset("assets/images/Group 197.png"),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 45),
                                child: const Text(
                                  '00:00',
                                  style: TextStyle(
                                      color: Color(0xffFF4A00),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 50),
                                child: const Text(
                                  'Finish Work',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 30,
                                padding: const EdgeInsets.only(left: 45),
                                child:
                                    Image.asset("assets/images/Group 198.png"),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 45),
                                child: const Text(
                                  '00:00',
                                  style: TextStyle(
                                      color: Color(0xffFF4A00),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 50),
                                child: const Text(
                                  'Total Work',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )),
                isLoading == true
                    ? Stack(children: [
                        Container(
                          color: Colors.white.withOpacity(0.9),
                        ),
                        Container(
                          // color: Color(0xffE4E4E4),
                          width: 392,
                          padding: const EdgeInsets.only(top: 105, bottom: 475),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // width: 290,
                                decoration: const BoxDecoration(
                                  color: Color(0xffE4E4E4),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // Column(
                                    //   children: [
                                    //     SizedBox(
                                    //       height: 12,
                                    //     ),
                                    //     // Container(
                                    //     //   height: 180,
                                    //     //   width: 120,
                                    //     //   decoration: BoxDecoration(
                                    //     //     color: const Color(0xff0062BD),
                                    //     //     borderRadius: BorderRadius.all(
                                    //     //         Radius.circular(10)),
                                    //     //   ),
                                    //     // )
                                    //   ],
                                    // ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                            child: Image.asset(
                                          "assets/images/FZSnPc.png",
                                          height: 30,
                                        )),
                                        Container(
                                          child: const RotatedBox(
                                            quarterTurns: 3,
                                            child: Text(
                                              'Select Role  ',
                                              style: TextStyle(
                                                  color: Color(0xff000000),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff0062BD),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                    )),
                                onPressed: () {
                                  setState(() {
                                    isLoading = !isLoading;
                                    // onTapSlider();
                                  });
                                },
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(10.0),),
                                  // padding: const EdgeInsets.only(left: 10),
                                  height: 45,
                                  // width: 50,
                                  // color: const Color(0xff0062BD),
                                  // child: Image.asset("assets/images/cuTOBs.png"),
                                  child: isLoading == false
                                      ? const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Color(0xffffffff),
                                        )
                                      : const Icon(
                                          Icons.arrow_back_ios_outlined,
                                          color: Color(0xffffffff),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 100, bottom: 465),
                          // padding: const EdgeInsets.only(top: 105, bottom: 475),
                          decoration: BoxDecoration(
                            color: const Color(0xff0062BD),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                10,
                              ),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          width: 150,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Get.defaultDialog(
                                        title:
                                            "Are You Sure You Want To Finish This Action?",
                                        titlePadding: EdgeInsets.all(22),
                                        contentPadding: EdgeInsets.only(
                                            left: 22, right: 22),
                                        titleStyle: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        actions: <Widget>[
                                          Row(children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: 35,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 3,
                                                        blurRadius: 2,
                                                        offset: Offset(0,
                                                            1), // changes position of shadow
                                                      ),
                                                    ],
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "NO",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: const Color(
                                                            0xff0062BD),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  height: 35,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 3,
                                                        blurRadius: 2,
                                                        offset: Offset(0,
                                                            1), // changes position of shadow
                                                      ),
                                                    ],
                                                    color:
                                                        const Color(0xff0062BD),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "YES",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            )
                                          ]),
                                        ],
                                        content: Container(
                                          padding: EdgeInsets.all(12),
                                          height: 195,
                                          width: 320,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff0062BD)
                                                .withOpacity(0.1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(children: [
                                            Image.asset(
                                              AppAssets.disclaimerIcon,
                                              scale: 3,
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              "Disclaimer",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 28,
                                            ),
                                            Text(
                                              "If you end this action your next action will be automatically started",
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Text(
                                              "Install on Front Door",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff0062BD),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      );
                                      role = "Electrician";
                                      print(role);
                                    });
                                  },
                                  child: Container(
                                    height: 38,
                                    width: 105,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          12,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            AppAssets.electrician,
                                            scale: 1,
                                          ),
                                          Text(
                                            "Electrician",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      role = "Technician";
                                      print(role);
                                    });
                                  },
                                  child: Container(
                                    height: 38,
                                    width: 105,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          12,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            AppAssets.technician,
                                            scale: 3,
                                          ),
                                          Text(
                                            "Technician",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      role = "Plumber";
                                      print(role);
                                    });
                                  },
                                  child: Container(
                                    height: 38,
                                    width: 105,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          12,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            AppAssets.plumber,
                                            scale: 3,
                                          ),
                                          Text(
                                            "Plumber",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // height: 20,
                        ),
                      ])
                    : Container(
                        // color: Color(0xffE4E4E4),
                        width: 90,
                        padding: const EdgeInsets.only(top: 105, bottom: 475),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xffE4E4E4),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      child: Image.asset(
                                    "assets/images/FZSnPc.png",
                                    height: 30,
                                  )),
                                  Container(
                                    child: const RotatedBox(
                                      quarterTurns: 3,
                                      child: Text(
                                        'Select Role  ',
                                        style: TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                // ElevatedButton(
                                //     style: ElevatedButton.styleFrom(
                                //       backgroundColor: const Color(0xffE4E4E4),
                                //         shape: const RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.only(
                                //             topRight: Radius.circular(30),
                                //             bottomRight: Radius.circular(30),
                                //           ),
                                //         )
                                //     ),
                                //     onPressed: () {
                                //       setState(() {
                                //         // load=true;
                                //       });
                                //     },
                                //     child: Column(
                                //       children: [
                                //         const SizedBox(
                                //           height: 20,
                                //         ),
                                //         Container(
                                //             child: Image.asset("assets/images/FZSnPc.png")),
                                //         Container(
                                //           child: const RotatedBox(
                                //             quarterTurns: 3,
                                //             child: Text(
                                //               'Select Role  ',
                                //               style: TextStyle(
                                //                   color: Color(0xff000000),
                                //                   fontSize: 14,
                                //                   fontWeight: FontWeight.w500),
                                //             ),
                                //           ),
                                //         ),
                                //       ],
                                //     )),
                                ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff0062BD),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                    )),
                                onPressed: () {
                                  setState(() {
                                    isLoading = !isLoading;
                                    // onTapSlider();
                                  });
                                },
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(10.0),),
                                  // padding: const EdgeInsets.only(left: 10),
                                  height: 45,
                                  // width: 50,
                                  // color: const Color(0xff0062BD),
                                  // child: Image.asset("assets/images/cuTOBs.png"),
                                  child: isLoading == false
                                      ? const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Color(0xffffffff),
                                        )
                                      : const Icon(
                                          Icons.arrow_back_ios_outlined,
                                          color: Color(0xffffffff),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
            // bottomSheet: isLoading == true
            //     ? Container(
            //   height: 30,
            //         color: Colors.red,
            //       )
            //     : null,
          );
        });
  }
}
