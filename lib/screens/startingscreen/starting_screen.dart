import 'dart:async';
import 'dart:ui';
import '';
import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
// import 'lib/constants/app_colors.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  Permission _permissionStatus = Permission.unknown;
  late DateTime dateTime;
  String _timeString = '';
  DateTime today = DateTime.now().toLocal();

  // var day = today.day;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading == false;
      _timeString = _formatDateTime(DateTime.now());
      Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    });
    _checkPermission();
    super.initState();
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }
// method to check the location permission
//   void _checkPermission() async {
//     final permissionStatus = await Permission.;
//     setState(() {
//       _permissionStatus = permissionStatus;
//     });
//   }
  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String role = "";
  bool isLoading = false;
  bool sliderOpen = true;

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
    // final safePad = MediaQuery.of(context).padding;
    final Size size = MediaQuery.of(context).size;
    var textsize = size.height / size.width;
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            // backgroundColor: Colors.white,
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Padding(
                padding: EdgeInsets.only(top: 7),
                child: BluTimeAppHeader(
                  leadingImage: AppAssets.profilePlaceholder,
                  backEnabled: false,
                ),
              ),
            ),
            body: Stack(
              children: [
                Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.06 * size.height,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '  $_timeString',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.2 * textsize,
                                color: AppColors.buttonBlue,
                              ),
                            ),
                            SizedBox(
                              width: 0.01 * size.width,
                            ),
                            //Changes required
                            Container(
                              padding: const EdgeInsets.all(3),
                              margin: EdgeInsets.only(left: 0.02 * size.width),
                              height: 0.025 * size.height,
                              width: 0.09 * size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 0,
                                    offset: const Offset(
                                        0, 1.5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'PM',
                                  style: TextStyle(
                                      color: const Color(0xff8B8B8B),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 4.9 * textsize),
                                ),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: Text(
                            DateFormat('EEEE, MMM dd').format(today).toString(),
                            style: TextStyle(
                                // fontFeatures: [FontFeature.subscripts()],
                                color: const Color(0xff000000),
                                fontSize: 6.8 * textsize),
                          ),
                        ),
                        // Text(DateFormat('EEEE').format(now)),
                        SizedBox(
                          height: 0.15 * size.height,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.57,
                          // Below is the code for Linear Gradient.
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.9),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 4), // changes position of shadow
                              ),
                            ],
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
                              SizedBox(
                                height: 0.04 * size.height,
                              ),
                              Image.asset(
                                'assets/images/Group 137.png',
                                scale: 3,
                              ),
                              Text(
                                '00:00:00',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xffFFFFFF),
                                    fontSize: 10.2 * textsize),
                              ),
                              SizedBox(
                                height: 0.015 * size.height,
                              ),
                              Text(
                                'Start Work',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xffFFFFFF),
                                    fontSize: 5.5 * textsize),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.022 * size.height,
                    ),
                    Center(
                      // padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        children: [
                          Text(
                            isLoading && sliderOpen == false ? "" : role,
                            style: TextStyle(
                              fontSize: 8.2 * textsize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.orange,
                            ),
                          ),
                          const Text(
                            'User Current Location Here',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.06 * size.height,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                AppAssets.startWork,
                                scale: 3,
                              ),
                              SizedBox(
                                height: 0.01 * size.height,
                              ),
                              Text(
                                '00:00',
                                style: TextStyle(
                                  color: const Color(0xffFF4A00),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 6.5 * textsize,
                                ),
                              ),
                              Text(
                                'Start Work',
                                style: TextStyle(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 5.2 * textsize),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                AppAssets.finishWork,
                                scale: 2,
                              ),
                              SizedBox(
                                height: 0.01 * size.height,
                              ),
                              Text(
                                '00:00',
                                style: TextStyle(
                                    color: const Color(0xffFF4A00),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 6.2 * textsize),
                              ),
                              Text(
                                'Finish Work',
                                style: TextStyle(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 5.2 * textsize),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                AppAssets.breakTime,
                                scale: 3,
                              ),
                              SizedBox(
                                height: 0.01 * size.height,
                              ),
                              Text(
                                '00:00',
                                style: TextStyle(
                                    color: const Color(0xffFF4A00),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 6.5 * textsize),
                              ),
                              Text(
                                'Total Work',
                                style: TextStyle(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 5.2 * textsize),
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
                        GestureDetector(
                          onTap: () {
                            isLoading = false;
                          },
                          child: Container(
                            height: 1 * size.height,
                            width: 1 * size.width,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        Positioned(
                          top: 0.15 * size.height,
                          left: 0.07 * size.width,
                          child: SizedBox(
                            // color: Color(0xffE4E4E4),
                            width: 0.98 * size.width,
                            height: 0.16 * size.height,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        width: 0.029 * size.width,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 0.01 * size.height,
                                          ),
                                          Image.asset(
                                            "assets/images/FZSnPc.png",
                                            height: 0.029 * size.height,
                                          ),
                                          RotatedBox(
                                            quarterTurns: 3,
                                            child: Text(
                                              'Select Role  ',
                                              style: TextStyle(
                                                  color: const Color(0xff000000),
                                                  fontSize: 6 * textsize,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 0.03 * size.width,
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
                                  child: SizedBox(
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(10.0),),
                                    // padding: const EdgeInsets.only(left: 10),
                                    height: 0.03 * size.height,
                                    // width: 0.05*size.width,
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
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 0.08 * size.width,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0.13 * size.height),
                              // padding: const EdgeInsets.only(top: 105, bottom: 475),
                              decoration: const BoxDecoration(
                                color: Color(0xff0062BD),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    10,
                                  ),
                                ),
                              ),
                              width: 0.35 * size.width,
                              height: 0.19 * size.height,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Get.defaultDialog(
                                        //   title:
                                        //   "Are You Sure You Want To Finish This Action?",
                                        //   titlePadding:
                                        //   const EdgeInsets.all(22),
                                        //   contentPadding:
                                        //   const EdgeInsets.only(
                                        //       left: 22, right: 22),
                                        //   titleStyle: TextStyle(
                                        //     fontSize: 9.8 * textsize,
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        //   actions: <Widget>[
                                        //     Row(children: [
                                        //       Column(
                                        //         children: [
                                        //           GestureDetector(
                                        //             onTap: () {
                                        //               // Dialog.getDialogs(context).pop();
                                        //               // Get.back();
                                        //             },
                                        //             child: Container(
                                        //               height: 0.04 *
                                        //                   size.height,
                                        //               width:
                                        //               0.3 * size.width,
                                        //               decoration:
                                        //               BoxDecoration(
                                        //                 boxShadow: [
                                        //                   BoxShadow(
                                        //                     color: Colors
                                        //                         .grey
                                        //                         .withOpacity(
                                        //                         0.2),
                                        //                     spreadRadius: 3,
                                        //                     blurRadius: 2,
                                        //                     offset: const Offset(
                                        //                         0,
                                        //                         1), // changes position of shadow
                                        //                   ),
                                        //                 ],
                                        //                 color: Colors.white,
                                        //                 borderRadius:
                                        //                 const BorderRadius
                                        //                     .all(
                                        //                   Radius.circular(
                                        //                     10,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //               child: const Center(
                                        //                 child: Text(
                                        //                   "NO",
                                        //                   style: TextStyle(
                                        //                     fontWeight:
                                        //                     FontWeight
                                        //                         .bold,
                                        //                     fontSize: 18,
                                        //                     color: Color(
                                        //                         0xff0062BD),
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //           const SizedBox(
                                        //             height: 10,
                                        //           )
                                        //         ],
                                        //       ),
                                        //       const SizedBox(
                                        //         width: 15,
                                        //       ),
                                        //       Column(
                                        //         children: [
                                        //           GestureDetector(
                                        //             onTap: () {
                                        //               isLoading = false;
                                        //               Get.back();
                                        //               // Get.off(HomeScreen());
                                        //               // Get.to();
                                        //             },
                                        //             child: Container(
                                        //               height: 0.04 *
                                        //                   size.height,
                                        //               width:
                                        //               0.3 * size.width,
                                        //               decoration:
                                        //               BoxDecoration(
                                        //                 boxShadow: [
                                        //                   BoxShadow(
                                        //                     color: Colors
                                        //                         .grey
                                        //                         .withOpacity(
                                        //                         0.2),
                                        //                     spreadRadius: 3,
                                        //                     blurRadius: 2,
                                        //                     offset: const Offset(
                                        //                         0,
                                        //                         1), // changes position of shadow
                                        //                   ),
                                        //                 ],
                                        //                 color: const Color(
                                        //                     0xff0062BD),
                                        //                 borderRadius:
                                        //                 const BorderRadius
                                        //                     .all(
                                        //                   Radius.circular(
                                        //                     10,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //               child: const Center(
                                        //                 child: Text(
                                        //                   "YES",
                                        //                   style: TextStyle(
                                        //                     fontWeight:
                                        //                     FontWeight
                                        //                         .bold,
                                        //                     fontSize: 18,
                                        //                     color: Colors
                                        //                         .white,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //           const SizedBox(
                                        //             height: 10,
                                        //           )
                                        //         ],
                                        //       )
                                        //     ]),
                                        //   ],
                                        //   content: Container(
                                        //     padding:
                                        //     const EdgeInsets.all(12),
                                        //     height: 0.24 * size.height,
                                        //     width: 0.95 * size.width,
                                        //     decoration: BoxDecoration(
                                        //       color: const Color(0xff0062BD)
                                        //           .withOpacity(0.1),
                                        //       borderRadius:
                                        //       const BorderRadius.all(
                                        //         Radius.circular(10),
                                        //       ),
                                        //     ),
                                        //     child: Column(children: [
                                        //       Image.asset(
                                        //         AppAssets.disclaimerIcon,
                                        //         scale: 3,
                                        //       ),
                                        //       const SizedBox(
                                        //         height: 5,
                                        //       ),
                                        //       const Text(
                                        //         "Disclaimer",
                                        //         style: TextStyle(
                                        //           fontWeight:
                                        //           FontWeight.bold,
                                        //           color: Colors.black,
                                        //         ),
                                        //       ),
                                        //       const SizedBox(
                                        //         height: 28,
                                        //       ),
                                        //       Text(
                                        //         "If you end this action your next action will be automatically started",
                                        //         textAlign: TextAlign.center,
                                        //         style: TextStyle(
                                        //             fontSize:
                                        //             6.5 * textsize),
                                        //       ),
                                        //       SizedBox(
                                        //         height: 0.015*size.height,
                                        //       ),
                                        //       Text(
                                        //         "Install on Front Door",
                                        //         style: TextStyle(
                                        //           fontSize: 7.2 * textsize,
                                        //           fontWeight:
                                        //           FontWeight.bold,
                                        //           color: Color(0xff0062BD),
                                        //         ),
                                        //       ),
                                        //     ]),
                                        //   ),
                                        // );

                                        // sliderOpen==true;
                                        setState(() {
                                          role = "Electrician";
                                          // print(role);
                                        });
                                        // setState(() { isLoading == false;});
                                      },
                                      child: Container(
                                        height: 0.04 * size.height,
                                        width: 0.27 * size.width,
                                        decoration: BoxDecoration(
                                          color: role == "Electrician"
                                              ? AppColors.bottomBar
                                              : Colors.white,
                                          borderRadius: const BorderRadius.all(
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
                                                color: role == "Electrician"
                                                    ? Colors.white
                                                    : AppColors.buttonBlue,
                                              ),
                                              Text(
                                                "Electrician",
                                                style: TextStyle(
                                                  color: role == "Electrician"
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 6.2 * textsize,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // Get.defaultDialog(
                                          //     title: "",
                                          //     content: SizedBox(
                                          //       height: 0.26 * size.height,
                                          //       width: 0.8 * size.width,
                                          //       child: Column(
                                          //         children: [
                                          //           Image.asset(
                                          //             AppAssets.taskCompleted,
                                          //             scale: 3,
                                          //           ),
                                          //           SizedBox(
                                          //             height:
                                          //                 0.01 * size.height,
                                          //           ),
                                          //           const Text(
                                          //             "Time Marked",
                                          //             style: TextStyle(
                                          //               fontSize: 16,
                                          //               fontWeight:
                                          //                   FontWeight.bold,
                                          //             ),
                                          //           ),
                                          //           SizedBox(
                                          //             height:
                                          //                 0.05 * size.height,
                                          //           ),
                                          //           Row(
                                          //             mainAxisAlignment:
                                          //                 MainAxisAlignment
                                          //                     .spaceEvenly,
                                          //             children: [
                                          //               Column(children: [
                                          //                 Image.asset(
                                          //                   AppAssets
                                          //                       .startWork,
                                          //                   scale: 3,
                                          //                 ),
                                          //                 const Text(
                                          //                   "12:00",
                                          //                   style: TextStyle(
                                          //                     fontSize: 14,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold,
                                          //                     color: AppColors
                                          //                         .orange,
                                          //                   ),
                                          //                 ),
                                          //                 const Text(
                                          //                   "Start Work",
                                          //                   style: TextStyle(
                                          //                     fontSize: 11,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold,
                                          //                     color: Colors
                                          //                         .black,
                                          //                   ),
                                          //                 ),
                                          //               ]),
                                          //               Column(children: [
                                          //                 Image.asset(
                                          //                   AppAssets
                                          //                       .finishWork,
                                          //                   scale: 2,
                                          //                 ),
                                          //                 const Text(
                                          //                   "12:00",
                                          //                   style: TextStyle(
                                          //                     fontSize: 14,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold,
                                          //                     color: AppColors
                                          //                         .orange,
                                          //                   ),
                                          //                 ),
                                          //                 const Text(
                                          //                   "Start Work",
                                          //                   style: TextStyle(
                                          //                     fontSize: 11,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold,
                                          //                     color: Colors
                                          //                         .black,
                                          //                   ),
                                          //                 ),
                                          //               ]),
                                          //               Column(children: [
                                          //                 Image.asset(
                                          //                   AppAssets
                                          //                       .breakTime,
                                          //                   scale: 3,
                                          //                 ),
                                          //                 const Text(
                                          //                   "12:00",
                                          //                   style: TextStyle(
                                          //                     fontSize: 14,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold,
                                          //                     color: AppColors
                                          //                         .orange,
                                          //                   ),
                                          //                 ),
                                          //                 const Text(
                                          //                   "Start Work",
                                          //                   style: TextStyle(
                                          //                     fontSize: 11,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold,
                                          //                     color: Colors
                                          //                         .black,
                                          //                   ),
                                          //                 ),
                                          //               ]),
                                          //             ],
                                          //           ),
                                          //           SizedBox(
                                          //             height:
                                          //                 0.022*size.height,
                                          //           ),
                                          //           const Text(
                                          //             "User current location here",
                                          //             style: TextStyle(
                                          //                 fontSize: 15,
                                          //                 color:
                                          //                     Colors.black),
                                          //           )
                                          //         ],
                                          //       ),
                                          //     ));

                                          role = "Technician";
                                          // print(role);
                                        });
                                      },
                                      child: Container(
                                        height: 0.04 * size.height,
                                        width: 0.27 * size.width,
                                        decoration: BoxDecoration(
                                          color: role == "Technician"
                                              ? AppColors.bottomBar
                                              : Colors.white,
                                          borderRadius: const BorderRadius.all(
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
                                                color: role == "Technician"
                                                    ? Colors.white
                                                    : AppColors.buttonBlue,
                                              ),
                                              Text(
                                                "Technician",
                                                style: TextStyle(
                                                    color: role == "Technician"
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 6.2 * textsize),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // Get.defaultDialog(
                                          //     title: "",
                                          //     content: Column(
                                          //       children: [
                                          //         Row(children: const [
                                          //           Text(
                                          //             "Motion and Fitness",
                                          //             style: TextStyle(
                                          //               fontWeight:
                                          //                   FontWeight.bold,
                                          //               fontSize: 16,
                                          //               color: Colors.black,
                                          //             ),
                                          //           ),
                                          //         ])
                                          //       ],
                                          //     ));
                                          role = "Plumber";
                                          // print(role);
                                        });
                                      },
                                      child: Container(
                                        height: 0.04 * size.height,
                                        width: 0.27 * size.width,
                                        decoration: BoxDecoration(
                                          color: role == "Plumber"
                                              ? AppColors.bottomBar
                                              : Colors.white,
                                          borderRadius: const BorderRadius.all(
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
                                                color: role == "Plumber"
                                                    ? Colors.white
                                                    : AppColors.buttonBlue,
                                              ),
                                              Text(
                                                "Plumber",
                                                style: TextStyle(
                                                  color: role == "Plumber"
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 6.2 * textsize,
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
                          ],
                        ),
                      ])
                    : Positioned(
                        top: 0.15 * size.height,
                        child: Container(
                          // color: Color(0xffE4E4E4),
                          width: 0.22 * size.width,
                          height: 0.22 * size.height,
                          // padding: EdgeInsets.only(
                          //     top: 0.15 * size.height, bottom: 0.5 * size.height),
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
                                    Image.asset(
                                      "assets/images/FZSnPc.png",
                                      height: 30,
                                    ),
                                    RotatedBox(
                                      quarterTurns: 3,
                                      child: Text(
                                        'Select Role  ',
                                        style: TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 6.8 * textsize,
                                            fontWeight: FontWeight.w500),
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
                                  child: SizedBox(
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(10.0),),
                                    // padding: const EdgeInsets.only(left: 10),
                                    height: 0.06 * size.height,
                                    // width: 50,
                                    // color: const Color(0xff0062BD),
                                    // child: Image.asset("assets/images/cuTOBs.png"),
                                    child: isLoading == false
                                        ? const Center(
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Color(0xffffffff),
                                            ),
                                          )
                                        : const Center(
                                            child: Icon(
                                              Icons.arrow_back_ios_outlined,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          );
        });
  }
}
