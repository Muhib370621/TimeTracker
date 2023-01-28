import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BreakTimer extends StatelessWidget {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  const BreakTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
    Get.put(StartingScreenController());
    final Size size = MediaQuery.of(context).size;
    var textsize = size.height / size.width;
    return Obx(() => Visibility(
      visible: controller.breakRunning.value == true,
      child: Container(
        height: 11.2.h,
        width: 0.9 * size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(
                  0, 2), // changes position of shadow
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
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                    Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Break ${controller.listOfBreaks.length+1}",
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
              padding: const EdgeInsets.only(
                  left: 3.0, right: 3.0),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Start Time",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.2),
                      ),
                      Container(
                        height: 0.028 * size.height,
                        width: 0.15 * size.width,
                        decoration:
                        const BoxDecoration(
                          color: AppColors.buttonBlue,
                          borderRadius:
                          BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            controller
                                .Breakstart.value,
                            maxLines: 1,
                            textAlign:
                            TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              6.2 * textsize,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 1),
                    child: Text(
                      " ${twoDigits(controller.breakDuration.value.inHours.remainder(60))}:${twoDigits(controller.breakDuration.value.inMinutes.remainder(60))}:${twoDigits(controller.breakDuration.value.inSeconds.remainder(60))}",
                      style: TextStyle(
                        fontSize: 15.2 * textsize,
                        color: AppColors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        "End Time",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.2),
                      ),
                      Container(
                        height: 0.028 * size.height,
                        width: 0.15 * size.width,
                        decoration:
                        const BoxDecoration(
                          color: AppColors.buttonBlue,
                          borderRadius:
                          BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            controller.finishBreak
                                .value ==
                                ""
                                ? "-----"
                                : controller
                                .finishBreak
                                .value,
                            maxLines: 1,
                            textAlign:
                            TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              6.2 * textsize,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.01 * size.height,
            ),
          ],
        ),
      ),
    )
    );
  }
}
