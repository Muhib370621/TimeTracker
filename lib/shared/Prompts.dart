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

  static confirmationDialog(BuildContext context, String middleText,void Function()? onConfirmTap) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm"),
            content: Text(middleText),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                backgroundColor: AppColors.buttonBlue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed:
                  onConfirmTap,
                child: const Text("Confirm")
              ),
            ],
          );
        });
  }
}
