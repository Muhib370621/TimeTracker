import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/controllers/bottomNavigationController.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:blu_time/shared/Prompts.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
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
  bool isAddingBreak = false;
  String startTime = "";
  String endTime = "";

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
        Get.put(StartingScreenController());
    final BottomNavController bottController = Get.put(BottomNavController());

    return Scaffold(
        appBar: const BluTimeAppHeader(),
        body: Obx(
          () => Stack(
            children: [
              ///whole screen
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Activity",
                      style: TextStyle(
                          fontSize: 19.sp, fontWeight: FontWeight.bold),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                controller.startDate.value,
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
                                      Center(
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: controller
                                                  .listOfBreaks.isEmpty
                                              ? 0
                                              : controller.listOfBreaks.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Stack(children: [
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.isEditting
                                                            .value = true;
                                                        controller.editIndex
                                                            .value = index;
                                                        isStartTime = false;
                                                      },
                                                      child: Container(
                                                        height: 4.h,
                                                        width: 8.w,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: AppColors
                                                                    .bottomBar,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          8),
                                                                )),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(7.0),
                                                          child: SvgPicture
                                                              .asset(AppAssets
                                                                  .editIcon),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 1.5.w,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Center(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(height: 1.h,),
                                                              Container(
                                                                height: 12.h,
                                                                width: 72.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      Colors.white,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius.circular(
                                                                        12),
                                                                  ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.3),
                                                                      spreadRadius:
                                                                          1,
                                                                      blurRadius: 3,
                                                                      offset: const Offset(
                                                                          0,
                                                                          1), // changes position of shadow
                                                                    ),
                                                                  ],
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
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
                                                                        "Break ${index + 1}",
                                                                        style: TextStyle(
                                                                            fontSize: 15
                                                                                .sp,
                                                                            color: AppColors
                                                                                .buttonBlue,
                                                                            fontWeight:
                                                                                FontWeight.w700),
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
                                                                              height:
                                                                                  3.5.h,
                                                                              width:
                                                                                  21.w,
                                                                              decoration: const BoxDecoration(
                                                                                  color: AppColors.buttonBlue,
                                                                                  borderRadius: BorderRadius.all(
                                                                                    Radius.circular(
                                                                                      8,
                                                                                    ),
                                                                                  )),
                                                                              child:
                                                                                  Center(
                                                                                child:
                                                                                    Text(
                                                                                  controller.listOfBreaks[index].breakStart.toString(),
                                                                                  style: TextStyle(
                                                                                    fontSize: 14.5.sp,
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.bold,
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
                                                                              height:
                                                                                  3.5.h,
                                                                              width:
                                                                                  21.w,
                                                                              decoration: const BoxDecoration(
                                                                                  color: AppColors.buttonBlue,
                                                                                  borderRadius: BorderRadius.all(
                                                                                    Radius.circular(
                                                                                      8,
                                                                                    ),
                                                                                  )),
                                                                              child:
                                                                                  Center(
                                                                                child:
                                                                                    Text(
                                                                                  controller.listOfBreaks[index].breakEnd.toString(),
                                                                                  style: TextStyle(
                                                                                    fontSize: 14.5.sp,
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
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
                                                                              height:
                                                                                  3.5.h,
                                                                              width:
                                                                                  21.w,
                                                                              decoration:
                                                                                  const BoxDecoration(
                                                                                color:
                                                                                    AppColors.buttonBlue,
                                                                                borderRadius:
                                                                                    BorderRadius.all(
                                                                                  Radius.circular(
                                                                                    8,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              child:
                                                                                  Center(
                                                                                child:
                                                                                    Text(
                                                                                  controller.listOfBreaks[index].totalBreakTime.toString(),
                                                                                  style: TextStyle(
                                                                                    fontSize: 14.5.sp,
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.bold,
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
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 0.9.h,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 1.5.w,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.deleteIndex
                                                            .value = index;
                                                        controller
                                                            .deletionConfirmation
                                                            .value = true;
                                                      },
                                                      child: Container(
                                                        height: 4.h,
                                                        width: 8.w,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: AppColors
                                                                    .bottomBar,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          8),
                                                                )),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(7.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            AppAssets
                                                                .deleteIcon,
                                                            color: AppColors
                                                                .redAlert,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]);
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Visibility(
                                        visible:
                                            controller.listOfBreaks.isEmpty,
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
                                            isStartTime = false;
                                          });
                                        },
                                        child: Container(
                                          height: 4.h,
                                          width: 25.w,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                237, 237, 237, 1),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(7),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                spreadRadius: 1,
                                                blurRadius: 2,
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
              ///this is the container with opacity bg
              Visibility(
                visible: isAddingBreak ||
                    controller.addSuccess.value ||
                    controller.isEditting.value ||
                    controller.deletionConfirmation.value,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAddingBreak = false;
                      isStartTime = false;
                      controller.addSuccess.value = false;
                      controller.isEditting.value = false;
                    });
                  },
                  child: Container(
                    color: AppColors.bottomBar.withOpacity(0.8),
                  ),
                ),
              ),
              ///Successfully added break
              Visibility(
                visible: controller.addSuccess.value,
                child: Center(
                  child: Container(
                    height: 16.h,
                    width: 80.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          12,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                            AppAssets.thumbsUpIcon,
                          ),
                          Text(
                            controller.editSuccess.value == true
                                ? "Break Edited Successfully"
                                : "Break Added Successfully!",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.buttonBlue,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ///delete confirmation
              Visibility(
                visible: controller.deletionConfirmation.value,
                child: Center(
                  child: Container(
                    height: 16.h,
                    width: 80.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          12,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Are You Sure You Want To Delete This Break?",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                AppCommonButton(
                                  title: "NO",
                                  width: 35.w,
                                  height: 4.5.h,
                                  radius: 8,
                                  color: Colors.white,
                                  textColor: AppColors.buttonBlue,
                                  borderColor: Colors.white,
                                  onPressed: () {
                                    controller.deletionConfirmation.value = false;
                                  },
                                ),
                                AppCommonButton(
                                  title: "YES",
                                  width: 35.w,
                                  height: 4.5.h,
                                  radius: 8,
                                  color: AppColors.buttonBlue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    controller.removeBreak(
                                        controller.deleteIndex.value);
                                    controller.deletionConfirmation.value = false;
                                    Prompts.showSnackBar(
                                        msg:
                                        "Break Deleted",
                                        isWarning: false);
                                  },
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ///this is the complete time picker
              Visibility(
                visible: isAddingBreak || controller.isEditting.value,
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
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text(
                                controller.isEditting.value
                                    ? "Edit Break"
                                    : "Add Break",
                                style: const TextStyle(
                                  color: AppColors.buttonBlue,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isStartTime
                                            ? AppColors.buttonBlue
                                            : AppColors.hintTextColor
                                                .withOpacity(0.2),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_back_ios_outlined,
                                          color: Colors.white,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 4.h,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.hintTextColor
                                          .withOpacity(0.2),
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
                                            var dateFormat =
                                                DateFormat("hh:mm a");
                                            String timeFormatted =
                                                dateFormat.format(_dateTime);
                                            endTime = timeFormatted;
                                            DateTime start =
                                                dateFormat.parse(startTime);
                                            DateTime end =
                                                dateFormat.parse(endTime);
                                            Duration difference =
                                                end.difference(start);
                                            if (difference.isNegative) {
                                              Prompts.showSnackBar(
                                                  msg:
                                                      "Please Select correct start & End time",
                                                  isWarning: false);
                                            } else {
                                              var hourDiff =
                                                  difference.inHours.toString();
                                              var minutesDiff =
                                                  (difference.inMinutes % 60)
                                                      .toString();
                                              var totalBreak =
                                                  "${hourDiff}h  ${minutesDiff}m";
                                              if (controller.isEditting.value ==
                                                  true) {
                                                controller.editSuccess.value =
                                                    true;
                                              }
                                              controller.addSuccess.value =
                                                  true;
                                              controller.isEditting.value ==
                                                      true
                                                  ? controller.editBreak(
                                                      controller
                                                          .editIndex.value,
                                                      startTime,
                                                      endTime,
                                                      totalBreak)
                                                  : controller.listOfBreaks.add(
                                                      BreakModel(
                                                          breakStart: startTime,
                                                          breakEnd: endTime,
                                                          totalBreakTime:
                                                              totalBreak));
                                              isAddingBreak = false;
                                              controller.isEditting.value =
                                                  false;
                                              if (controller.addSuccess.value =
                                                  true) {
                                                Future.delayed(
                                                    const Duration(seconds: 2),
                                                    () {
                                                  controller.addSuccess.value =
                                                      false;
                                                  controller.editSuccess.value =
                                                      false;
                                                });
                                              }
                                              startTime = "";
                                              endTime = "";
                                            }
                                          }
                                          if (isStartTime == false) {
                                            String formattedTime =
                                                DateFormat("hh:mm a")
                                                    .format(_dateTime);
                                            startTime = formattedTime;
                                            isStartTime = true;
                                          }
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
                                                      fontWeight:
                                                          FontWeight.bold),
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
        ));
  }
}
