// import 'package:blu_time/constants/app_colors.dart';
// import 'package:blu_time/controllers/startingScreenController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// class RoleText extends StatelessWidget {
//   const RoleText({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final StartingScreenController controller =
//     Get.put(StartingScreenController());
//     return Obx(() =>  Visibility(
//       visible:
//       controller.clockRunning.value == false &&
//           controller.breakRunning.value == false,
//       child: Text(
//         controller.isLoading.value &&
//             controller.sliderOpen.value == false
//             ? ""
//             : controller.role.value,
//         style: TextStyle(
//           fontSize: 18.sp,
//           fontWeight: FontWeight.bold,
//           color: AppColors.orange,
//         ),
//       ),
//     )
//     );
//   }
// }
