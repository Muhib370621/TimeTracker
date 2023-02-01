// import 'package:blu_time/constants/app_assets.dart';
// import 'package:blu_time/constants/app_colors.dart';
// import 'package:blu_time/controllers/startingScreenController.dart';
// import 'package:blu_time/shared/widgets/app_common_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// class CheckListConfirmation extends StatelessWidget {
//   const CheckListConfirmation({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final StartingScreenController controller =
//         Get.put(StartingScreenController());
//     return Obx(
//       () => Visibility(
//         visible: controller.isChecklistConfirm.value == true,
//         child: Center(
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             height: 30.h,
//             width: 80.w,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(15),
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   height: 20.h,
//                   width: 70.w,
//                   decoration: BoxDecoration(
//                     color: AppColors.blueLightBackground.withOpacity(0.08),
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(10),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Image.asset(
//                         AppAssets.disclaimerIcon,
//                         scale: 2.2,
//                       ),
//                       Text(
//                         "Disclaimer",
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Text(
//                             "If you finish this checklist item, your next checklist item will be automatically selected",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 15.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           )),
//                       Text(
//                         "Next Checklist Item Here",
//                         style: TextStyle(
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.buttonBlue,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     AppCommonButton(
//                       title: "NO",
//                       width: 35.w,
//                       height: 4.5.h,
//                       radius: 8,
//                       color: Colors.white,
//                       textColor: AppColors.buttonBlue,
//                       borderColor: Colors.white,
//                       onPressed: () {
//                         controller.isChecklistConfirm.value = false;
//                         controller.isStopSelecting.value = false;
//                       },
//                     ),
//                     AppCommonButton(
//                       title: "YES",
//                       width: 35.w,
//                       height: 4.5.h,
//                       radius: 8,
//                       color: AppColors.buttonBlue,
//                       textColor: Colors.white,
//                       onPressed: () {
//                         controller.stopSelector.value = "Finish Work";
//                         controller.reset();
//                         controller.stopTimer(context: context, resets: true);
//                         controller.isChecklistConfirm.value = false;
//                         controller.isStopSelecting.value = false;
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
