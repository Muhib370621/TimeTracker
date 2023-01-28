import 'package:blu_time/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'widgets/app_common_button.dart';

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
                visible: isWarning ?? false,
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

  static noInternet({String? msg, bool? isWarning}) {
    return Get.showSnackbar(
      GetSnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.redAlert,
        messageText: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Visibility(
                visible: isWarning ?? false,
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
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(seconds: 1),
        forwardAnimationCurve: Curves.fastOutSlowIn,
        reverseAnimationCurve: Curves.fastLinearToSlowEaseIn,
      ),
    );
  }

  static confirmationDialog(
      BuildContext context, String middleText, void Function()? onConfirmTap) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Are you Sure you Want to Select this item?",
              textAlign: TextAlign.center,
              // style: TextStyle(fontFamily: "Montserrat"),
            ),
            titleTextStyle: TextStyle(
                fontFamily: "Montserrat",
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 19.sp),
            content: Text(
              middleText,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Montserrat",
                color: Colors.black,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            // actionsPadding: EdgeInsets.symmetric(vertical: 5),
            actions: <Widget>[
              AppCommonButton(
                title: "NO",
                width: 35.w,
                height: 4.5.h,
                radius: 8,
                color: Colors.white,
                textColor: AppColors.buttonBlue,
                borderColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              AppCommonButton(
                  title: "YES",
                  width: 35.w,
                  height: 4.5.h,
                  radius: 8,
                  color: AppColors.buttonBlue,
                  textColor: Colors.white,
                  onPressed: onConfirmTap
                  // borderColor: Colors.white,
                  ),
            ],
          );
        });
  }

  Widget showSuccess() {
    return Container(
      height: 10.h,
      width: 80.w,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
      ),
    );
  }
}
