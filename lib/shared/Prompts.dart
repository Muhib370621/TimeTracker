import 'package:blu_time/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Prompts{

  static showSnackBar({String? msg}) {
    return Get.showSnackbar(
      GetSnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: AppColors.bottomBar,
        messageText: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            msg!,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(seconds: 1),
        forwardAnimationCurve: Curves.fastOutSlowIn,
        reverseAnimationCurve: Curves.fastLinearToSlowEaseIn,
      ),
    );
  }
}