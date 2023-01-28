import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/controllers/bottomNavigationController.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:blu_time/screens/startingscreen/acitvity.dart';
import 'package:blu_time/shared/Prompts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TimerButton extends StatelessWidget {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  const TimerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
    Get.put(StartingScreenController());
    final BottomNavController bottomController = Get.put(BottomNavController());
    return Obx(() =>Stack(children: [
      GestureDetector(
        onTap: () {
          controller.currentAddress.value == ""
              ? controller.getCurrentLocation()
              : null;
          if (controller.currentAddress.value == "" &&
              controller.role.value != "" &&
              controller.locationLoading.value ==
                  false) {
            Prompts.showSnackBar(
                msg:
                "Please wait fetching for your current location",
                isWarning: true);
          } else if (controller.role.value == "" &&
              controller.locationLoading.value ==
                  false) {
            Prompts.showSnackBar(
                msg: "Please Select your Role",
                isWarning: true);
          } else if (controller.role.value != "") {
            if (controller.clockRunning.value == true) {
              controller.stopTimer(
                  resets: false, context: context);
              controller.isStopSelecting.value = true;
            } else {
              controller.breakRunning.value == false
                  ? controller.startTimer()
                  : Prompts.showSnackBar(
                  msg: "Stop the Break first!",
                  isWarning: true);
              bottomController.projectName.value == ""
                  ? bottomController
                  .currentIndex.value = 2
                  : null;
            }
            controller.startTime.value == ""
                ? controller.getStartTime()
                : null;
          } else if (controller.role.value == "" &&
              controller.currentAddress.value == "" &&
              controller.locationLoading.value ==
                  false) {
            Prompts.showSnackBar(
                msg:
                "Please select your role and wait while we are fetching your current location",
                isWarning: true);
          }
          else if(controller.locationLoading.value==false && controller.currentAddress.value==""){
            Prompts.noInternet(msg: "Please check you Internet Connection", isWarning: true);

          }
        },
        child: Container(
          height: 26.5.h,
          width: 64.w,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(
                    0, 4),
              ),
            ],
            shape: BoxShape.circle,
            gradient: controller.timerStatus.value ==
                false &&
                controller.clockRunning.value ||
                controller.breakRunning.value ==
                    true
                ? LinearGradient(
              colors: [
                AppColors.orange,
                AppColors.orange.withOpacity(0.9)
              ],
              begin: Alignment.bottomLeft,
            )
                : LinearGradient(
              colors: [
                const Color(0xff0062BD),
                const Color(0xff002D4B)
                    .withOpacity(0.9)
              ],
              begin: Alignment.bottomLeft,
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
                    ? AppLocalizedStrings.finishWork
                    .tr()
                    : AppLocalizedStrings.startWork
                    .tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xffFFFFFF),
                    fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      Visibility(
        visible: controller.breakCounter.value > 0,
        child: Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              Get.to(() => const Activity());
            },
            child: Container(
              height: 4.5.h,
              width: 10.w,
              decoration: const BoxDecoration(
                color: AppColors.bottomBar,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  AppAssets.historyIcon,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ),
      ),
    ],)
    );
  }
}
