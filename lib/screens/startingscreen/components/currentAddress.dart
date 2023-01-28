import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CurrentAddress extends StatelessWidget {
  const CurrentAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
    Get.put(StartingScreenController());
    return Obx(() => Column(
      children: [
        if (controller.currentAddress.value != "")
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 8),
            child: Text(
              controller.currentAddress.value.toString(),
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.5.sp,
              ),
            ),
          ),
        controller.currentAddress.value == ""
            ? Text(
          controller.locationLoading.value == true
              ? AppLocalizedStrings.loadingAddress
              .tr()
              : AppLocalizedStrings.beforeLocation
              .tr(),
          style: TextStyle(
              color: Colors.black,
              fontSize: 15.5.sp),
        )
            : Container(),
      ],
    )
    );
  }
}
