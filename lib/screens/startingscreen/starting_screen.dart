import 'dart:ui';

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
  void doNothing(BuildContext context) {}

  bool isLoading = false;
  Widget onTapSlider(){
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      // key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: doNothing,
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Container(
        // color: Color(0xffE4E4E4),
        width: 90,
        padding: const EdgeInsets.only(top: 115, bottom: 405),
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
                          child: Image.asset("assets/images/FZSnPc.png",height: 30,)),
                      Container(
                        child: const RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            'Select Role  ',
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 14,
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
                    )
                ),
                onPressed: () {
                  setState(() {
                    isLoading=true;
                    // onTapSlider();
                  });
                },
                child:Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10.0),),
                  // padding: const EdgeInsets.only(left: 10),
                  height: 45,
                  // width: 50,
                  // color: const Color(0xff0062BD),
                  // child: Image.asset("assets/images/cuTOBs.png"),
                  child: const Icon(Icons.arrow_forward_ios_outlined, color: Color(0xffffffff),),
                ),),

            ),
          ],
        ),
      ),
    );

  }
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
                isLoading==true?onTapSlider():Container(
                  // color: Color(0xffE4E4E4),
                  width: 90,
                  padding: const EdgeInsets.only(top: 115, bottom: 405),
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
                                  child: Image.asset("assets/images/FZSnPc.png",height: 30,)),
                              Container(
                                child: const RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    'Select Role  ',
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 14,
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
                               )
                           ),
                           onPressed: () {
                             setState(() {
                               isLoading=true;
                               // onTapSlider();
                             });
                           },
                           child:Container(
                             // decoration: BoxDecoration(
                             //   borderRadius: BorderRadius.circular(10.0),),
                             // padding: const EdgeInsets.only(left: 10),
                             height: 45,
                             // width: 50,
                             // color: const Color(0xff0062BD),
                             // child: Image.asset("assets/images/cuTOBs.png"),
                             child: const Icon(Icons.arrow_forward_ios_outlined, color: Color(0xffffffff),),
                           ),),

                     ),
                    ],
                  ),
                ),
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
                            Text(
                              '  $_timeString',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 40,
                                  color: Color(0xff0062BD)),
                            ),
                            //Changes required
                            Container(
                              height: 25,
                              width: 36,
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
                        const Text(
                          'Tuesday, Dec 06',
                          style: TextStyle(
                              fontFeatures: [FontFeature.subscripts()],
                              color: Color(0xff000000)),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.57,
                          // Below is the code for Linear Gradient.
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150.0),
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
                      padding: const EdgeInsets.only(left: 50, top: 80),
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
                )
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
