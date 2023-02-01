import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StopTimerSelector extends StatelessWidget {
  const StopTimerSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
        Get.put(StartingScreenController());
    return Obx(() => Visibility(
          visible: controller.isStopSelecting.value == true,
          child: Center(
            child: Container(
              height: 22.h,
              width: 85.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          controller.isStopSelecting.value = false;
                        },
                        child: Icon(
                          Icons.clear,
                          color: AppColors.hintTextColor.withOpacity(0.6),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 1.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.stopSelector.value = "Pause Timer";
                                controller.stopTimer(
                                    context: context, resets: false);
                                controller.isStopSelecting.value = false;
                              },
                              child: Container(
                                height: 13.h,
                                width: 29.w,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 0, 0, 0.05),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SvgPicture.asset(AppAssets.pauseTimer),
                                    const Text("Pause\nTimer"),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.isStopSelecting.value = false;
                                controller.stopSelector.value = "Finish Work";
                                controller.reset();
                                controller.stopTimer(
                                    context: context, resets: true);
                                // controller.isChecklistConfirm.value = false;
                                controller.isStopSelecting.value = false;
                                // controller.isChecklistConfirm.value = true;
                              },
                              child: Container(
                                height: 13.h,
                                width: 29.w,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 0, 0, 0.05),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SvgPicture.asset(AppAssets.finishWorkIcon),
                                    const Text(
                                      "Close\n Current Task",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
