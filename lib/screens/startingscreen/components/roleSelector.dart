// import 'package:blu_time/constants/app_assets.dart';
// import 'package:blu_time/constants/app_colors.dart';
// import 'package:blu_time/constants/app_localized_strings.dart';
// import 'package:blu_time/constants/app_storage.dart';
// import 'package:blu_time/controllers/startingScreenController.dart';
// import 'package:blu_time/helpers/locator.dart';
// import 'package:blu_time/shared/Prompts.dart';
// import 'package:blu_time/stores/store_services.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class RoleSelector extends StatelessWidget {
//   const RoleSelector({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final StartingScreenController controller =
//         Get.put(StartingScreenController());
//     final Size size = MediaQuery.of(context).size;
//     var textsize = size.height / size.width;
//     return Row(
//       children: [
//         SizedBox(
//           width: 0.08 * size.width,
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 0.13 * size.height),
//           decoration: BoxDecoration(
//             color: const Color(0xff0062BD),
//             borderRadius: const BorderRadius.all(
//               Radius.circular(
//                 10,
//               ),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: const Offset(0, 2.5), // changes position of shadow
//               ),
//             ],
//           ),
//           width: 0.38 * size.width,
//           height: 0.24 * size.height,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                   onTap: () async {
//                     controller.clockDuration.value.inSeconds
//                                     .remainder(60) >
//                                 0 ||
//                             controller.clockRunning.value == true
//                         ? Prompts.showSnackBar(
//                             msg:
//                                 "Cant Change the roles when working on Project!!",
//                             isWarning: true)
//                         : controller.role.value =
//                             AppLocalizedStrings.electrician.tr();
//                     controller.isLoading.value = false;
//                     await locator<StoreServices>().setLocal(
//                         AppStorage.role, "userid", controller.role.value);
//                   },
//                   child: Container(
//                     height: 0.045 * size.height,
//                     width: 0.29 * size.width,
//                     decoration: BoxDecoration(
//                       color: controller.role.value ==
//                               AppLocalizedStrings.electrician.tr()
//                           ? AppColors.bottomBar
//                           : Colors.white,
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           12,
//                         ),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Image.asset(
//                           AppAssets.electrician,
//                           scale: 1,
//                           color: controller.role.value ==
//                                   AppLocalizedStrings.electrician.tr()
//                               ? Colors.white
//                               : AppColors.buttonBlue,
//                         ),
//                         Text(
//                           AppLocalizedStrings.electrician.tr(),
//                           style: TextStyle(
//                             color: controller.role.value ==
//                                     AppLocalizedStrings.electrician.tr()
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontSize: 6.2 * textsize,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () async {
//                     controller.clockDuration.value.inSeconds
//                                     .remainder(60) >
//                                 0 ||
//                             controller.clockRunning.value == true
//                         ? Prompts.showSnackBar(
//                             msg:
//                                 "Cant Change the roles when working on Project!!",
//                             isWarning: true)
//                         : controller.role.value =
//                             AppLocalizedStrings.technician.tr();
//                     await locator<StoreServices>().setLocal(
//                         AppStorage.role, "userid", controller.role.value);
//                     controller.isLoading.value = false;
//                   },
//                   child: Container(
//                     height: 0.045 * size.height,
//                     width: 0.29 * size.width,
//                     decoration: BoxDecoration(
//                       color: controller.role.value ==
//                               AppLocalizedStrings.technician.tr()
//                           ? AppColors.bottomBar
//                           : Colors.white,
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           12,
//                         ),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Image.asset(
//                           AppAssets.technician,
//                           scale: 3,
//                           color: controller.role.value == "Technician"
//                               ? Colors.white
//                               : AppColors.buttonBlue,
//                         ),
//                         Text(
//                           AppLocalizedStrings.technician.tr(),
//                           style: TextStyle(
//                               color: controller.role.value ==
//                                       AppLocalizedStrings.technician.tr()
//                                   ? Colors.white
//                                   : Colors.black,
//                               fontSize: 6.2 * textsize),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () async {
//                     controller.clockDuration.value.inSeconds
//                                     .remainder(60) >
//                                 0 ||
//                             controller.clockRunning.value == true
//                         ? Prompts.showSnackBar(
//                             msg:
//                                 "Cant Change the roles when working on Project!!",
//                             isWarning: true)
//                         : controller.role.value =
//                             AppLocalizedStrings.plumber.tr();
//                     await locator<StoreServices>().setLocal(
//                         AppStorage.role, "userid", controller.role.value);
//                     controller.isLoading.value = false;
//                   },
//                   child: Container(
//                     height: 0.045 * size.height,
//                     width: 0.29 * size.width,
//                     decoration: BoxDecoration(
//                       color: controller.role.value ==
//                               AppLocalizedStrings.plumber.tr()
//                           ? AppColors.bottomBar
//                           : Colors.white,
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           12,
//                         ),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Image.asset(
//                           AppAssets.plumber,
//                           scale: 3,
//                           color: controller.role.value ==
//                                   AppLocalizedStrings.plumber.tr()
//                               ? Colors.white
//                               : AppColors.buttonBlue,
//                         ),
//                         Text(
//                           AppLocalizedStrings.plumber.tr(),
//                           style: TextStyle(
//                             color: controller.role.value ==
//                                     AppLocalizedStrings.plumber.tr()
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontSize: 6.2 * textsize,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
