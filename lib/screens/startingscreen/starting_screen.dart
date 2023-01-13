import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

import '../../shared/Prompts.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);
  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  @override

  void initState() {
    final StartingScreenController controller =
        Get.put(StartingScreenController());
    controller.gpsService(context);
    controller.determinePosition();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
        Get.put(StartingScreenController());
    final Size size = MediaQuery.of(context).size;
    var textsize = size.height / size.width;
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
              // backgroundColor: Colors.white,
              appBar: const BluTimeAppHeader(
                leadingImage: AppAssets.profilePlaceholder,
                backEnabled: false,
              ),
              body: Obx(
                () => Stack(
                  children: [
                    Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 0.05 * size.height,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '  ${controller.timeString.value}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 27.5.sp,
                                    color: AppColors.buttonBlue,
                                  ),
                                ),
                                SizedBox(
                                  width: 0.01 * size.width,
                                ),
                                //Changes required
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  margin:
                                      EdgeInsets.only(left: 0.02 * size.width),
                                  height: 0.025 * size.height,
                                  width: 0.09 * size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(7)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 0,
                                        offset: const Offset(0,
                                            1.5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat('a').format(DateTime.now()),
                                      style: TextStyle(
                                          color: const Color(0xff8B8B8B),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Center(
                              child: Text(
                                DateFormat('EEEE, MMM dd')
                                    .format(controller.today.value)
                                    .toString(),
                                style: TextStyle(
                                  // fontFeatures: [FontFeature.subscripts()],
                                  color: const Color(0xff000000),
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.11 * size.height,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.currentAddress.value == ""
                                    ? controller.getCurrentLocation()
                                    : null;
                                if (controller.currentAddress.value == "" &&
                                    controller.role.value != "" &&
                                    controller.locationLoading.value == false) {
                                  Prompts.showSnackBar(
                                      msg:
                                          "Please wait waiting for your current location");
                                } else if (controller.role.value == "" &&
                                    controller.locationLoading.value == false) {
                                  Prompts.showSnackBar(
                                      msg: "Please Select your Role");
                                } else if (controller.role.value != "") {
                                  controller.clockRunning.value == true
                                      ?
                                      // print(clockRunning);
                                      controller.stopTimer(
                                          resets: false, context: context)
                                      : controller.startTimer();
                                  controller.startTime.value == ""
                                      ? controller.getStartTime()
                                      : null;

                                  // clockRunning = true;
                                } else if (controller.role.value == "" &&
                                    controller.currentAddress.value == "" &&
                                    controller.locationLoading.value == false) {
                                  Prompts.showSnackBar(
                                      msg:
                                          "Please select your role and wait while we are fetching your current location");
                                }
                              },
                              child: Container(
                                height: 26.5.h,
                                width: 55.w,
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
                                  gradient: controller.timerStatus.value ==
                                                  false &&
                                              controller.clockRunning.value ||
                                          controller.breakRunning.value == true
                                      ? LinearGradient(
                                          colors: [
                                            AppColors.orange,
                                            AppColors.orange.withOpacity(0.9)
                                          ],
                                          begin: Alignment.bottomLeft,
                                          // end: Alignment.topRight,
                                        )
                                      : LinearGradient(
                                          colors: [
                                            const Color(0xff0062BD),
                                            const Color(0xff002D4B)
                                                .withOpacity(0.9)
                                          ],
                                          begin: Alignment.bottomLeft,
                                          // end: Alignment.topRight,
                                        ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Image.asset(
                                      'assets/images/Group 137.png',
                                      scale: 3,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      " ${twoDigits(controller.clockDuration.value.inHours.remainder(60))}:${twoDigits(controller.clockDuration.value.inMinutes.remainder(60))}:${twoDigits(controller.clockDuration.value.inSeconds.remainder(60))}",
                                      // '00:00:00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xffFFFFFF),
                                          fontSize: 20.sp),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      controller.timerStatus.value == false &&
                                                  controller
                                                      .clockRunning.value ||
                                              controller.breakRunning.value ==
                                                  true
                                          ? 'FINISH WORK'
                                          : 'START WORK',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xffFFFFFF),
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                ),
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
                              Visibility(
                                visible:
                                    controller.clockRunning.value == true ||
                                        controller.breakRunning.value == true,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.stopTimer(
                                            resets: false, context: context);
                                        if (controller.breakRunning.value ==
                                            true) {
                                          controller.stopBreak(resets: true);
                                          // breakDuration = const Duration();
                                          controller.startTimer();
                                        } else {
                                          // reset();
                                          controller.startBreak();
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 0.05 * size.height,
                                        width: 0.13 * size.width,
                                        decoration: BoxDecoration(
                                            color:
                                                controller.breakRunning.value ==
                                                        true
                                                    ? AppColors.orange
                                                    : AppColors.buttonBlue,
                                            shape: BoxShape.circle),
                                        child: Image.asset(
                                          AppAssets.breakIcon,
                                          scale: 3,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.breakRunning.value == true
                                              ? "Tap To End"
                                              : "Tap To Start",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "Break",
                                          style: TextStyle(
                                            fontSize: 17.sp,
                                            color:
                                                controller.breakRunning.value ==
                                                        true
                                                    ? AppColors.orange
                                                    : AppColors.buttonBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible:
                                    controller.clockRunning.value == false &&
                                        controller.breakRunning.value == false,
                                child: Text(
                                  controller.isLoading.value &&
                                          controller.sliderOpen.value == false
                                      ? ""
                                      : controller.role.value,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.orange,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: controller.clockRunning.value == true
                                    ? 1.h
                                    : 0,
                              ),
                              if (controller.currentAddress.value != "")
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 8),
                                  child: Text(
                                    controller.currentAddress.value.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15.5.sp),
                                  ),
                                ),
                              controller.currentAddress.value == ""
                                  ? Text(
                                      controller.locationLoading.value == true
                                          ? "Loading Address..."
                                          : "Tap Start to get Current Location",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.5.sp),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: controller.breakRunning.value == true
                              ? 4.5.h
                              : 4.5.h,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Visibility(
                                visible: controller.breakRunning.value == false,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          AppAssets.startWork,
                                          scale: 3,
                                        ),
                                        SizedBox(
                                          height: 0.01 * size.height,
                                        ),
                                        Text(
                                          controller.startTime.value == ""
                                              ? '-----'
                                              : controller.startTime.value,
                                          style: TextStyle(
                                            color: const Color(0xffFF4A00),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.5.sp,
                                          ),
                                        ),
                                        Text(
                                          'Start Work',
                                          style: TextStyle(
                                              color: const Color(0xff000000),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.sp),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          AppAssets.finishWork,
                                          scale: 2,
                                        ),
                                        SizedBox(
                                          height: 0.01 * size.height,
                                        ),
                                        Text(
                                          controller.finishTime.value == ""
                                              ? '-----'
                                              : controller.finishTime.value,
                                          style: TextStyle(
                                              color: const Color(0xffFF4A00),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.5.sp),
                                        ),
                                        Text(
                                          'Finish Work',
                                          style: TextStyle(
                                              color: const Color(0xff000000),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.sp),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          AppAssets.breakTime,
                                          scale: 3,
                                        ),
                                        SizedBox(
                                          height: 0.01 * size.height,
                                        ),
                                        Text(
                                          controller.totalTime.value == ""
                                              ? '-----'
                                              : controller.totalTime.value,
                                          style: TextStyle(
                                              color: const Color(0xffFF4A00),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.5.sp),
                                        ),
                                        Text(
                                          'Total Work',
                                          style: TextStyle(
                                              color: const Color(0xff000000),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                  visible:
                                      controller.breakRunning.value == true,
                                  child: Container(
                                    height: 0.11 * size.height,
                                    width: 0.9 * size.width,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 1,
                                          offset: const Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 0.01 * size.height,
                                        ),
                                        Container(
                                          height: 0.03 * size.height,
                                          width: 0.2 * size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                8,
                                              ),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 1,
                                                offset: const Offset(0,
                                                    1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Break 1",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 6.2 * textsize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.007 * size.height,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:3.0,right: 3.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(children: [
                                                const Text(
                                                  "Start Time",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13.2),
                                                ),
                                                Container(
                                                  height: 0.028 * size.height,
                                                  width: 0.15 * size.width,
                                                  decoration: const BoxDecoration(
                                                    color: AppColors.buttonBlue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      controller.Breakstart.value,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 6.2 * textsize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                              Padding(
                                                padding: const EdgeInsets.only(top:1),
                                                child: Text(
                                                  " ${twoDigits(controller.breakDuration.value.inHours.remainder(60))}:${twoDigits(controller.breakDuration.value.inMinutes.remainder(60))}:${twoDigits(controller.breakDuration.value.inSeconds.remainder(60))}",
                                                  style: TextStyle(
                                                    fontSize: 15.2 * textsize,
                                                    color: AppColors.orange,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Column(children: [
                                                const Text(
                                                  "End Time",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13.2),
                                                ),
                                                Container(
                                                  height: 0.028 * size.height,
                                                  width: 0.15 * size.width,
                                                  decoration: const BoxDecoration(
                                                    color: AppColors.buttonBlue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      controller.finishBreak.value==""?"-----":controller.finishBreak.value,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 6.2 * textsize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.01 * size.height,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )),
                    controller.isLoading.value == true
                        ? Stack(children: [
                            GestureDetector(
                              onTap: () {
                                controller.isLoading.value = false;
                              },
                              child: Container(
                                height: 1 * size.height,
                                width: 1 * size.width,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            Positioned(
                              top: 0.142 * size.height,
                              left: 0.094 * size.width,
                              child: SizedBox(
                                // color: Color(0xffE4E4E4),
                                width: size.width,
                                height: 0.22 * size.height,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          right: 4, top: 3),
                                      // width: 290,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffE4E4E4),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 0.01 * size.width,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 0.01 * size.height,
                                              ),
                                              Image.asset(
                                                "assets/images/FZSnPc.png",
                                                scale: 3,
                                                // height: 0.04 * size.height,
                                              ),
                                              RotatedBox(
                                                quarterTurns: 3,
                                                child: Text(
                                                  'SELECT ROLE  ',
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff000000),
                                                      fontSize:
                                                          0.0215 * size.height,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 0.01 * size.width,
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff0062BD),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ),
                                          )),
                                      onPressed: () {
                                        controller.isLoading.value =
                                            !controller.isLoading.value;
                                      },
                                      child: SizedBox(
                                        height: 0.03 * size.height,
                                        child: controller.isLoading.value ==
                                                false
                                            ? const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
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
                                  margin:
                                      EdgeInsets.only(top: 0.13 * size.height),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff0062BD),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        10,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 1,
                                        offset: const Offset(0,
                                            2.5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  width: 0.38 * size.width,
                                  height: 0.24 * size.height,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // controller.roleSelected.value==true;

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
                                            controller.clockDuration.value
                                                            .inSeconds
                                                            .remainder(60) >
                                                        0 ||
                                                    controller.clockRunning
                                                            .value ==
                                                        true
                                                ? Prompts.showSnackBar(
                                                    msg:
                                                        "Cant Change the roles when timer is Running!!")
                                                : controller.role.value =
                                                    "Electrician";
                                            controller.isLoading.value = false;
                                          },
                                          child: Container(
                                            height: 0.045 * size.height,
                                            width: 0.29 * size.width,
                                            decoration: BoxDecoration(
                                              color: controller.role.value ==
                                                      "Electrician"
                                                  ? AppColors.bottomBar
                                                  : Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  12,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    AppAssets.electrician,
                                                    scale: 1,
                                                    color: controller
                                                                .role.value ==
                                                            "Electrician"
                                                        ? Colors.white
                                                        : AppColors.buttonBlue,
                                                  ),
                                                  Text(
                                                    "Electrician",
                                                    style: TextStyle(
                                                      color: controller
                                                                  .role.value ==
                                                              "Electrician"
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
                                            controller.clockDuration.value
                                                            .inSeconds
                                                            .remainder(60) >
                                                        0 ||
                                                    controller.clockRunning
                                                            .value ==
                                                        true
                                                ? Prompts.showSnackBar(
                                                    msg:
                                                        "Cant Change the roles when timer is Running!!")
                                                :
                                                // setState(() {
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
                                                controller.role.value =
                                                    "Technician";
                                            controller.isLoading.value = false;
                                          },
                                          child: Container(
                                            height: 0.045 * size.height,
                                            width: 0.29 * size.width,
                                            decoration: BoxDecoration(
                                              color: controller.role.value ==
                                                      "Technician"
                                                  ? AppColors.bottomBar
                                                  : Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  12,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    AppAssets.technician,
                                                    scale: 3,
                                                    color: controller
                                                                .role.value ==
                                                            "Technician"
                                                        ? Colors.white
                                                        : AppColors.buttonBlue,
                                                  ),
                                                  Text(
                                                    "Technician",
                                                    style: TextStyle(
                                                        color: controller.role
                                                                    .value ==
                                                                "Technician"
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontSize:
                                                            6.2 * textsize),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.clockDuration.value
                                                            .inSeconds
                                                            .remainder(60) >
                                                        0 ||
                                                    controller.clockRunning
                                                            .value ==
                                                        true
                                                ? Prompts.showSnackBar(
                                                    msg:
                                                        "Cant Change the roles when timer is Running!!")
                                                :
                                                // setState(() {
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
                                                controller.role.value =
                                                    "Plumber";
                                            controller.isLoading.value = false;
                                          },
                                          child: Container(
                                            height: 0.045 * size.height,
                                            width: 0.29 * size.width,
                                            decoration: BoxDecoration(
                                              color: controller.role.value ==
                                                      "Plumber"
                                                  ? AppColors.bottomBar
                                                  : Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  12,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    AppAssets.plumber,
                                                    scale: 3,
                                                    color: controller
                                                                .role.value ==
                                                            "Plumber"
                                                        ? Colors.white
                                                        : AppColors.buttonBlue,
                                                  ),
                                                  Text(
                                                    "Plumber",
                                                    style: TextStyle(
                                                      color: controller
                                                                  .role.value ==
                                                              "Plumber"
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
                        : Stack(children: [
                            Positioned(
                              top: 0.15 * size.height,
                              child: SizedBox(
                                width: 0.24 * size.width,
                                height: 0.22 * size.height,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 6, right: 6),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffE4E4E4),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 1,
                                              offset: const Offset(0,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 0.01 * size.height,
                                            ),
                                            Image.asset(
                                              "assets/images/FZSnPc.png",
                                              scale: 3,
                                              // height: 0.04 * size.height,
                                            ),
                                            RotatedBox(
                                              quarterTurns: 3,
                                              child: Text(
                                                'SELECT ROLE  ',
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xff000000),
                                                    fontSize:
                                                        0.022 * size.height,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff0062BD),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                            )),
                                        onPressed: () {
                                          controller.isLoading.value =
                                              !controller.isLoading.value;
                                        },
                                        child: SizedBox(
                                          height: 0.06 * size.height,
                                          child: controller.isLoading.value ==
                                                  false
                                              ? const Center(
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    color: Color(0xffffffff),
                                                  ),
                                                )
                                              : const Center(
                                                  child: Icon(
                                                    Icons
                                                        .arrow_back_ios_outlined,
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
                            controller.locationLoading.value == true &&
                                    controller.currentAddress.value == ""
                                ? Stack(children: [
                                    Container(
                                      height: size.height,
                                      width: size.width,
                                      color:
                                          AppColors.bottomBar.withOpacity(0.7),
                                    ),
                                    Center(
                                      child: Container(
                                        height: 0.15 * size.height,
                                        width: 0.8 * size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(16),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 3,
                                              blurRadius: 1,
                                              offset: const Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: 0.02 * size.height,
                                                ),
                                                Icon(
                                                  Icons.location_on,
                                                  size: 0.05 * size.height,
                                                  color: AppColors.buttonBlue,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Please Wait while we are fetching your current location",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            0.02 * size.height),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const CircularProgressIndicator(
                                              color: AppColors.buttonBlue,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ])
                                : Container(),
                          ]),
                  ],
                ),
              ));
        });
  }
}
