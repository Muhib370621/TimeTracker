import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TimerStatusWidget extends StatelessWidget {
  const TimerStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
    Get.put(StartingScreenController());
    final Size size = MediaQuery.of(context).size;
    return Obx(() => Visibility(
      visible: controller.breakRunning.value == false || controller.clockRunning.value == false || controller.breakRunning.value==true,
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment:
            MainAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.startWork,
                scale: 3,
              ),
              SizedBox(
                height: 0.01 * size.height,
              ),
              Text(
                controller.startTime.value == ""
                    ? '-----'
                    : controller.startTime.value,
                style: TextStyle(
                  color: const Color(0xffFF4A00),
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5.sp,
                ),
              ),
              Text(
                'Start Work',
                style: TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp),
              ),
            ],
          ),
          Column(
            mainAxisAlignment:
            MainAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.finishWork,
                scale: 2,
              ),
              SizedBox(
                height: 0.01 * size.height,
              ),
              Text(
                controller.finishTime.value == ""
                    ? '-----'
                    : controller.finishTime.value,
                style: TextStyle(
                    color: const Color(0xffFF4A00),
                    fontWeight: FontWeight.w700,
                    fontSize: 14.5.sp),
              ),
              Text(
                'Finish Work',
                style: TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp),
              ),
            ],
          ),
          Column(
            mainAxisAlignment:
            MainAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.breakTime,
                scale: 3,
              ),
              SizedBox(
                height: 0.01 * size.height,
              ),
              Text(
                controller.totalTime.value == ""
                    ? '-----'
                    : controller.totalTime.value,
                style: TextStyle(
                    color: const Color(0xffFF4A00),
                    fontWeight: FontWeight.w700,
                    fontSize: 14.5.sp),
              ),
              Text(
                'Total Work',
                style: TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp),
              ),
            ],
          ),
        ],
      ),
    )
    );
  }
}
