import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BreakButton extends StatelessWidget {
  const BreakButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
        Get.put(StartingScreenController());
    final Size size = MediaQuery.of(context).size;
    return Obx(() => Visibility(
          visible: controller.clockRunning.value == true ||
              controller.breakRunning.value == true,
          child: InkWell(
            splashColor: AppColors.bottomBar.withOpacity(0.9),
            focusColor: AppColors.bottomBar.withOpacity(0.9),
            highlightColor: AppColors.bottomBar.withOpacity(0.9),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
            onTap: () {
              controller.stopTimer(resets: false, context: context);
              if (controller.breakRunning.value == true) {
                controller.stopBreak(resets: true);
                controller.startTimer();
              } else {
                controller.stopSelector.value = "Pause Timer";
                controller.stopTimer(context: context, resets: false);
                controller.startBreak();
              }
            },
            child: Container(
              height: 6.9.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    25,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 0.05 * size.height,
                    width: 0.13 * size.width,
                    decoration: BoxDecoration(
                        color: controller.breakRunning.value == true
                            ? AppColors.orange
                            : AppColors.buttonBlue,
                        shape: BoxShape.circle),
                    child: Image.asset(
                      AppAssets.breakIcon,
                      scale: 3,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.breakRunning.value == true
                            ? AppLocalizedStrings.tapToEnd.tr()
                            : AppLocalizedStrings.tapToStart.tr(),
                        style: TextStyle(
                          fontSize: 15.5.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        AppLocalizedStrings.Break.tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: controller.breakRunning.value == true
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
          ),
        ));
  }
}
