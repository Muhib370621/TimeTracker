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
                controller.startTimer();
              } else {
                controller.stopSelector.value =
                "Pause Timer";
                controller.stopTimer(
                    context: context, resets: false);
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
                    ? AppLocalizedStrings.tapToEnd
                    .tr()
                    : AppLocalizedStrings.tapToStart
                    .tr(),
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
              Text(
                AppLocalizedStrings.Break.tr(),
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
    )
    );
  }
}
