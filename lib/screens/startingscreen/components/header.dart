import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../constants/app_colors.dart';

class StartHeader extends StatelessWidget {
  const StartHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final StartingScreenController controller =
    Get.put(StartingScreenController());
    return Obx(() => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '  ${controller.timeString.value}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 27.5.sp,
                color: AppColors.buttonBlue,
              ),
            ),
            SizedBox(
              width: 0.01 * size.width,
            ),
            //Changes required
            Container(
              padding: const EdgeInsets.all(3),
              margin:
              EdgeInsets.only(left: 0.02 * size.width),
              height: 0.03 * size.height,
              width: 0.09 * size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                    Radius.circular(7)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 0,
                    offset: const Offset(0,
                        1.5), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  DateFormat('a').format(DateTime.now()),
                  style: TextStyle(
                      color: const Color(0xff8B8B8B),
                      fontWeight: FontWeight.w600,
                      fontSize: 15.5.sp),
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            DateFormat('EEEE, MMM dd')
                .format(controller.today.value)
                .toString(),
            style: TextStyle(
              color: const Color(0xff000000),
              fontSize: 18.sp,
            ),
          ),
        ),
      ],
    )
    );
  }
}
