import 'package:blu_time/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Prompts {
  static showSnackBar({String? msg, bool? isWarning}) {
    return Get.showSnackbar(
      GetSnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: AppColors.background,
        messageText: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Visibility(
                visible: isWarning!,
                child: Icon(
                  Icons.warning_rounded,
                  color: Colors.white,
                  size: 32.sp,
                ),
              ),
              Text(
                msg!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.TOP,
        animationDuration: const Duration(seconds: 1),
        forwardAnimationCurve: Curves.fastOutSlowIn,
        reverseAnimationCurve: Curves.fastLinearToSlowEaseIn,
      ),
    );
  }

}
