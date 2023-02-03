import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/controllers/bottomNavigationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomController = Get.put(BottomNavController());
    return Obx(() => Column(
      children: [
        Visibility(
          visible: bottomController.projectName.value != "",
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: 72.w,
                child: Text(
                  bottomController.projectName.value
                      .toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.buttonBlue,
                      fontSize: 17.8.sp,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Visibility(
          visible:
          bottomController.activityName.value != "",
          child: Text(
            bottomController.activityName.value.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.5.sp,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Visibility(
          visible:
          bottomController.checkListItem.value != "",
          child: Container(
            height: 3.h,
            width: 50.w,
            // padding: EdgeInsets.only(left: 2),
            decoration: BoxDecoration(
              color: AppColors.timerColor.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(
                      0, 2),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  SizedBox(width: 1.w,),
                  SvgPicture.asset(
                    AppAssets.checkListItem,
                    height: 2.h,
                  ),
                  SizedBox(width: 1.w,),

                  // SizedBox(width: 2.w,),
                  SizedBox(
                    width: 44.w,
                    child: Text(
                      bottomController.checkListItem.value
                          .toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  // const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ],
    )
    );
  }
}
