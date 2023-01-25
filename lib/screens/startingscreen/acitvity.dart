import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/controllers/BottomNavigationController.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:blu_time/shared/Prompts.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../models/breakModel.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  bool isDelete = false;
  bool isEdit = false;
  bool isStartTime = false;
  DateTime _dateTime = DateTime.now();
  // DateTime _dateTime1 = DateTime.now();

  bool isAddingBreak = false;
  String startTime = "";
  String endTime = "";

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
    Get.put(StartingScreenController());
    final BottomNavController bottController =
    Get.put(BottomNavController());

    return Scaffold(
      appBar: const BluTimeAppHeader(),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Activity",
                  style:
                  TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            // height: 65.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 6,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, top: 18, right: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bottController.activityName.value,
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Start Date",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.buttonBlue,
                                            ),
                                          ),
                                          Text(
                                            "End Date",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.buttonBlue,
                                            ),
                                          ),
                                          Text(
                                            "Start Time",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.buttonBlue,
                                            ),
                                          ),
                                          Text(
                                            "End Time",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.buttonBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 18.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Tue 06 Dec",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.timerColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "-------",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.timerColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            controller.startTime.value,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.timerColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "-------",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.timerColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    "Breaks",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.buttonBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Center(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: controller.listOfBreaks.isEmpty
                                          ? 0
                                          : controller.listOfBreaks.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return
                                          Stack(children: [
                                          Positioned(
                                            top: 25,
                                            child: Container(
                                              height: 4.5.h,
                                              width: 10.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                    Radius.circular(8),
                                                  )),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(7.0),
                                                child: SvgPicture.asset(
                                                    AppAssets.editIcon),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 1,
                                            top: 25,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.removeBreak(index);
                                                setState(() {});
                                                Prompts.showSnackBar(
                                                    msg: "Break Deleted",
                                                    isWarning: false);
                                                // controller.listOfBreaks.removeAt(index);
                                                // controller.listOfBreaks.length--;
                                              },
                                              child: Container(
                                                height: 4.5.h,
                                                width: 10.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                      Radius.circular(8),
                                                    )),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(7.0),
                                                  child: SvgPicture.asset(
                                                    AppAssets.deleteIcon,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onHorizontalDragEnd:
                                                (DragEndDetails details) {
                                              setState(() {
                                                isDelete = true;
                                              });
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    height: 12.h,
                                                    width: 72.w,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                        Radius.circular(12),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.4),
                                                          spreadRadius: 3,
                                                          blurRadius: 6,
                                                          offset: const Offset(
                                                              0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 12,
                                                        top: 12,
                                                        right: 12),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            "Break ${index +
                                                                1}",
                                                            style: TextStyle(
                                                                fontSize: 15.sp,
                                                                color: AppColors
                                                                    .buttonBlue,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                  "Start Time",
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    14.5.sp,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 3.5.h,
                                                                  width: 21.w,
                                                                  decoration:
                                                                  const BoxDecoration(
                                                                      color: AppColors
                                                                          .buttonBlue,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                        Radius
                                                                            .circular(
                                                                          8,
                                                                        ),
                                                                      )),
                                                                  child: Center(
                                                                    child: Text(
                                                                      controller
                                                                          .listOfBreaks[
                                                                      index]
                                                                          .breakStart
                                                                          .toString(),
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                        14.5.sp,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  "End Time",
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    14.5.sp,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 3.5.h,
                                                                  width: 21.w,
                                                                  decoration:
                                                                  const BoxDecoration(
                                                                      color: AppColors
                                                                          .buttonBlue,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                        Radius
                                                                            .circular(
                                                                          8,
                                                                        ),
                                                                      )),
                                                                  child: Center(
                                                                    child: Text(
                                                                      controller
                                                                          .listOfBreaks[
                                                                      index]
                                                                          .breakEnd
                                                                          .toString(),
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                        14.5.sp,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  "Total Time",
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    14.5.sp,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 3.5.h,
                                                                  width: 21.w,
                                                                  decoration:
                                                                  const BoxDecoration(
                                                                    color: AppColors
                                                                        .buttonBlue,
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                      Radius
                                                                          .circular(
                                                                        8,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      controller
                                                                          .listOfBreaks[
                                                                      index]
                                                                          .totalBreakTime
                                                                          .toString(),
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                        14.5.sp,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: isDelete == true,
                                            child: Positioned(
                                              right: 1,
                                              top: 25,
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.removeBreak(index);
                                                  setState(() {});
                                                  Prompts.showSnackBar(
                                                      msg: "Break Deleted",
                                                      isWarning: false);
                                                  // controller.listOfBreaks.removeAt(index);
                                                  // controller.listOfBreaks.length--;
                                                },
                                                child: Container(
                                                  height: 4.5.h,
                                                  width: 10.w,
                                                  decoration:
                                                  const BoxDecoration(
                                                      color: AppColors
                                                          .bottomBar,
                                                      borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(8),
                                                      )),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        7.0),
                                                    child: SvgPicture.asset(
                                                      AppAssets.deleteIcon,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]);
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: controller.listOfBreaks.isEmpty,
                                    child: Column(
                                      children: [
                                        Text(
                                          "No Breaks Found!",
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isAddingBreak = true;
                                      });
                                    },
                                    child: Container(
                                      height: 4.h,
                                      width: 25.w,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            237, 237, 237, 1),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(7),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 1,
                                            offset: const Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: AppColors.buttonBlue,
                                              size: 18.sp,
                                            ),
                                            Text(
                                              "Add Break",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          ///insert the time picker here when tapped on add break
          Visibility(
            visible: isAddingBreak,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isAddingBreak = false;
                });
              },
              child: Container(
                color: AppColors.bottomBar.withOpacity(0.8),
              ),
            ),
          ),
          Visibility(
            visible: isAddingBreak,
            child: Center(
              child: Container(
                height: 40.h,
                width: 80.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 12),
                        height: 5.h,
                        width: 75.w,
                        decoration: const BoxDecoration(
                            color: AppColors.buttonBlue,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            // SizedBox(width: 1.w,),
                            VerticalDivider(
                              indent: 5,
                              endIndent: 5,
                              thickness: 1.5,
                              color: Colors.white,
                            ),
                            VerticalDivider(
                              indent: 5,
                              endIndent: 5,
                              thickness: 1.5,
                              color: Colors.white,
                            ),
                            // SizedBox(width: 1.w,),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const Text(
                            "Add Break",
                            style: TextStyle(
                              color: AppColors.buttonBlue,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isStartTime = false;
                                  });
                                },
                                child: Container(
                                  height: 4.h,
                                  width: 8.w,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isStartTime
                                        ? AppColors.buttonBlue
                                        : AppColors.hintTextColor
                                        .withOpacity(0.2),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                              Container(
                                height: 4.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color:
                                  AppColors.hintTextColor.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    isStartTime == false
                                        ? "Start Time"
                                        : "End Time",
                                    style: const TextStyle(
                                      color: AppColors.hintTextColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isStartTime = true;
                                  });
                                },
                                child: Container(
                                  height: 4.h,
                                  width: 8.w,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isStartTime == false
                                        ? AppColors.buttonBlue
                                        : AppColors.hintTextColor
                                        .withOpacity(0.2),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              TimePickerSpinner(
                                is24HourMode: false,
                                normalTextStyle: const TextStyle(
                                  fontSize: 24,
                                  color: AppColors.hintTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                highlightedTextStyle: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                spacing: 40,
                                itemHeight: 60,
                                isForce2Digits: true,
                                onTimeChange: (time) {
                                  setState(() {
                                    _dateTime = time;
                                  });
                                },
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (isStartTime == true) {
                                        var dateFormat = DateFormat("h:m a");
                                        String timeFormatted =dateFormat.format(_dateTime);
                                        print("formatted time $timeFormatted");
                                        endTime = timeFormatted;
                                        // parse the start and end times into DateTime objects
                                        DateTime start = dateFormat.parse(startTime);
                                        print("estart $start");
                                        DateTime end =dateFormat.parse(endTime);
                                        print("end $end");
                                        Duration difference = end.difference(start);
                                        // Duration abc = dateFormat.format(difference);

                                        // String formattedDuration = difference.toString().substring(0,8);
                                        // print(formattedDuration);
                                        // print("difference $difference");
                                        print("differ : ${dateFormat.format(dateFormat)}");
                                        // var hourDiff, minutes_diff, totalBreak;
                                        var hourDiff = difference.inHours.toString();
                                        print(hourDiff);
                                        var minutesDiff = difference.inMinutes.toString();
                                        print(minutesDiff);
                                        var totalBreak = "${hourDiff}h  ${minutesDiff}m";
                                        print("total break $totalBreak");
                                        // endTime!=""?isAddingBreak = false:null;
                                        isStartTime=false;
                                        isAddingBreak=false;
                                        controller.listOfBreaks.add(BreakModel(
                                            breakStart: startTime,
                                            breakEnd: endTime,
                                            totalBreakTime: totalBreak));
                                        Prompts.showSnackBar(
                                            msg: "Break Added !",
                                            isWarning: false);
                                        startTime="";
                                        endTime="";
                                      }
                                      if (isStartTime == false) {
                                        String formattedTime =
                                        DateFormat("hh:mm a")
                                            .format(_dateTime);
                                        startTime = formattedTime;
                                        print("start Time : $startTime");
                                        isStartTime = true;
                                      }
                                      // startTime="";
                                      // endTime="";
                                    });
                                  },
                                  child: Container(
                                    height: 4.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      color: isStartTime == false
                                          ? Colors.white
                                          : AppColors.buttonBlue,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    padding: isStartTime == false
                                        ? const EdgeInsets.only(right: 20.0)
                                        : null,
                                    child: isStartTime == false
                                        ? Icon(
                                      Icons.check,
                                      color: AppColors.buttonBlue,
                                      size: 24.sp,
                                    )
                                        : Center(
                                      child: Text(
                                        "Save",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
