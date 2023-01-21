import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:blu_time/shared/Prompts.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
        Get.put(StartingScreenController());
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
                style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemCount: 2,
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
                                  "Pick Up new Through Bolt",
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
                                          "12:00 PM",
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
                                      return Stack(children: [
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
                                        GestureDetector(
                                          onHorizontalDragEnd:
                                              (DragEndDetails details) {
                                            print("dragged right");
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
                                                        const BorderRadius.all(
                                                      Radius.circular(12),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.4),
                                                        spreadRadius: 3,
                                                        blurRadius: 6,
                                                        offset: const Offset(0,
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
                                                          "Break ${index + 1}",
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
                                                                            BorderRadius.all(
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
                                                                            BorderRadius.all(
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
                                              decoration: const BoxDecoration(
                                                  color: AppColors.bottomBar,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  )),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: SvgPicture.asset(
                                                  AppAssets.deleteIcon,
                                                  color: Colors.red,
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
                                  onTap: () {},
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
      ]),
    );
  }
}
