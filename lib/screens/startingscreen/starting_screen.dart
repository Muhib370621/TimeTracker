import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/screens/startingscreen/acitvity.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';
import '../../constants/app_storage.dart';
import '../../controllers/BottomNavigationController.dart';
import '../../shared/Prompts.dart';
import '../../stores/store_services.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> with WidgetsBindingObserver{
  @override
  void initState()  {
    WidgetsBinding.instance.addObserver(this);
    final StartingScreenController controller =
        Get.put(StartingScreenController());
    controller.gpsService(context);
    controller.determinePosition();
    super.initState();
  }

  // @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   final StartingScreenController controller =
  //   Get.put(StartingScreenController());
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       print("Resumed");
  //       print("--------------------------------------------------------------------");
  //       String note = await locator<StoreServices>().getLocal(AppStorage.timerTime, "userid");
  //       await locator<StoreServices>()
  //           .setLocal(AppStorage.appResumedTime, "userid", controller.timeString.value);
  //       String resume = await locator<StoreServices>().getLocal(AppStorage.appResumedTime, "userid");
  //       String paused = await locator<StoreServices>().getLocal(AppStorage.appPausedTime, "userid");
  //       var dateFormat = DateFormat('hh:mm');
  //       var hourDiff;
  //       var minutes_diff;
  //       var seconds_diff;
  //       DateTime start = dateFormat.parse(paused);
  //       DateTime finish = dateFormat.parse(resume);
  //       Duration diff = finish.difference(start);
  //       hourDiff = diff.inHours;
  //       minutes_diff = diff.inMinutes;
  //       // var result = "$hourDiff:$minutes_diff";
  //       String timerTime = await locator<StoreServices>().getLocal(AppStorage.timerTime, "userid");
  //       print(timerTime);
  //       // twoDigits(controller.clockDuration.value.inMinutes.remainder(60)) =
  //       // twoDigits(controller.clockDuration.value.inMinutes.remainder(60))
  //       // +AutofillHints.middleName;
  //       // print("result $result");
  //       // print(note);
  //       // print(resume);
  //       print("before ${controller.clockDuration.value.inMinutes.toString()}");
  //       // var updated =controller.clockDuration.value.inMinutes+ minutes_diff;
  //       // print("updated $updated");
  //       if(controller.clockRunning.value==true){
  //       controller.clockDuration.value = controller.clockDuration.value+Duration(minutes: minutes_diff.toInt());}
  //       // controller.startTimer();
  //       // controller.clockDuration.value.inHours + hourDiff;
  //       print("difference $minutes_diff");
  //       print("after ${controller.clockDuration.value.inMinutes.toString()}");
  //       // controller.startTimer();
  //       break;
  //     case AppLifecycleState.paused:
  //       print("Paused");
  //       print("--------------------------------------------------------------------");
  //       await locator<StoreServices>()
  //           .setLocal(AppStorage.timerTime, "userid", " ${twoDigits(controller.clockDuration.value.inHours.remainder(60))}:${twoDigits(controller.clockDuration.value.inMinutes.remainder(60))}:${twoDigits(controller.clockDuration.value.inSeconds.remainder(60))}");
  //       await locator<StoreServices>()
  //           .setLocal(AppStorage.appPausedTime, "userid", controller.timeString.value);
  //       String paused = await locator<StoreServices>().getLocal(AppStorage.appPausedTime, "userid");
  //       print(paused);
  //       // controller.stopTimer(context: context);
  //       // String timerTime = await locator<StoreServices>().getLocal(AppStorage.timerTime, "userid");
  //       // print(timerTime);
  //       break;
  //     case AppLifecycleState.inactive:
  //       print("Inactive");
  //       print("--------------------------------------------------------------------");
  //       break;
  //     case AppLifecycleState.detached:
  //       print("Detached");
  //       print("--------------------------------------------------------------------");
  //       String note = await locator<StoreServices>().getLocal(AppStorage.timerTime, "userid");
  //       await locator<StoreServices>()
  //           .setLocal(AppStorage.appResumedTime, "userid", controller.timeString.value);
  //       String resume = await locator<StoreServices>().getLocal(AppStorage.appResumedTime, "userid");
  //       String paused = await locator<StoreServices>().getLocal(AppStorage.appPausedTime, "userid");
  //       var dateFormat = DateFormat('hh:mm');
  //       var hourDiff;
  //       var minutes_diff;
  //       var seconds_diff;
  //       DateTime start = dateFormat.parse(paused);
  //       DateTime finish = dateFormat.parse(resume);
  //       Duration diff = finish.difference(start);
  //       hourDiff = diff.inHours;
  //       minutes_diff = diff.inMinutes;
  //       // var result = "$hourDiff:$minutes_diff";
  //       String timerTime = await locator<StoreServices>().getLocal(AppStorage.timerTime, "userid");
  //       print(timerTime);
  //       // twoDigits(controller.clockDuration.value.inMinutes.remainder(60)) =
  //       // twoDigits(controller.clockDuration.value.inMinutes.remainder(60))
  //       // +AutofillHints.middleName;
  //       // print("result $result");
  //       // print(note);
  //       // print(resume);
  //       print("before ${controller.clockDuration.value.inMinutes.toString()}");
  //       // var updated =controller.clockDuration.value.inMinutes+ minutes_diff;
  //       // print("updated $updated");
  //       if(controller.clockRunning.value==true){
  //         controller.clockDuration.value = controller.clockDuration.value+Duration(minutes: minutes_diff.toInt());}
  //       // controller.startTimer();
  //       // controller.clockDuration.value.inHours + hourDiff;
  //       print("difference $minutes_diff");
  //       print("after ${controller.clockDuration.value.inMinutes.toString()}");
  //   // controller.startTimer();
  //   break;
  //   }
  // }
  @override
  void dispose() {
    super.dispose();
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
        Get.put(StartingScreenController());
    final BottomNavController bottomController = Get.put(BottomNavController());
    final Size size = MediaQuery.of(context).size;
    var textsize = size.height / size.width;
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
              appBar: const BluTimeAppHeader(
                leadingImage: AppAssets.profilePlaceholder,
                backEnabled: false,
              ),
              body: Obx(
                () => Stack(
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 0.05 * size.height,
                          ),
                          Column(
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
                                    margin: EdgeInsets.only(
                                        left: 0.02 * size.width),
                                    height: 0.025 * size.height,
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
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Center(
                                child: Text(
                                  DateFormat('EEEE, MMM dd')
                                      .format(controller.today.value)
                                      .toString(),
                                  style: TextStyle(
                                    // fontFeatures: [FontFeature.subscripts()],
                                    color: const Color(0xff000000),
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Visibility(
                                visible:
                                    bottomController.projectName.value != "",
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: SizedBox(
                                      width: 72.w,
                                      child: Text(
                                        bottomController.projectName.value
                                            .toString(),
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
                              Visibility(
                                visible:
                                    bottomController.activityName.value != "",
                                child: Text(
                                  bottomController.activityName.value
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.5.sp,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                height: 0.4.h,
                              ),
                              Visibility(
                                visible:
                                    bottomController.checkListItem.value != "",
                                child: Container(
                                  height: 3.h,
                                  width: 45.w,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.timerColor.withOpacity(0.2),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.checkListItem,
                                          height: 2.h,
                                        ),
                                        Expanded(
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
                                        const SizedBox()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: controller.clockRunning.value ||
                                        controller.breakRunning.value == true
                                    ? 0.03 * size.height
                                    : 0.05 * size.height,
                              ),
                              Stack(children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.currentAddress.value == ""
                                        ? controller.getCurrentLocation()
                                        : null;
                                    if (controller.currentAddress.value == "" &&
                                        controller.role.value != "" &&
                                        controller.locationLoading.value ==
                                            false) {
                                      Prompts.showSnackBar(
                                          msg:
                                              "Please wait waiting for your current location",isWarning: true);
                                    } else if (controller.role.value == "" &&
                                        controller.locationLoading.value ==
                                            false) {
                                      Prompts.showSnackBar(
                                          msg: "Please Select your Role",isWarning: true);
                                    } else if (controller.role.value != "") {
                                      if (controller.clockRunning.value ==
                                          true) {
                                        controller.stopTimer(
                                            resets: false, context: context);
                                        final Size size =
                                            MediaQuery.of(context).size;
                                        Get.defaultDialog(
                                            title: "",
                                            content: SizedBox(
                                              height: 0.329 * size.height,
                                              width: 0.95 * size.width,
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    AppAssets.taskCompleted,
                                                    scale: 3,
                                                  ),
                                                  SizedBox(
                                                    height: 0.008 * size.height,
                                                  ),
                                                  Text(
                                                    "Time Marked",
                                                    style: TextStyle(
                                                      fontSize:
                                                          0.017 * size.height,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 0.05 * size.height,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Column(children: [
                                                        Image.asset(
                                                          AppAssets.startWork,
                                                          scale: 3,
                                                        ),
                                                        Text(
                                                          controller
                                                              .startTime.value,
                                                          style: TextStyle(
                                                            fontSize: 0.017 *
                                                                size.height,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .orange,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Start Work",
                                                          style: TextStyle(
                                                            fontSize: 0.017 *
                                                                size.height,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ]),
                                                      Column(children: [
                                                        Image.asset(
                                                          AppAssets.finishWork,
                                                          scale: 2,
                                                        ),
                                                        Text(
                                                          controller
                                                              .finishTime.value,
                                                          style: TextStyle(
                                                            fontSize: 0.017 *
                                                                size.height,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .orange,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Finish Work",
                                                          style: TextStyle(
                                                            fontSize: 0.017 *
                                                                size.height,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ]),
                                                      Column(children: [
                                                        Image.asset(
                                                          AppAssets.breakTime,
                                                          scale: 3,
                                                        ),
                                                        Text(
                                                          controller
                                                              .totalTime.value,
                                                          style: TextStyle(
                                                            fontSize: 0.017 *
                                                                size.height,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .orange,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Total Work",
                                                          style: TextStyle(
                                                            fontSize: 0.017 *
                                                                size.height,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 0.012 * size.height,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      controller
                                                          .currentAddress.value
                                                          .toString(),
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 0.017 *
                                                              size.height,
                                                          color: Colors.black,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ));
                                      } else {
                                        controller.startTimer();
                                        final BottomNavController
                                            bottController =
                                            Get.put(BottomNavController());
                                        bottController.currentIndex.value = 2;
                                      }
                                      controller.startTime.value == ""
                                          ? controller.getStartTime()
                                          : null;
                                    } else if (controller.role.value == "" &&
                                        controller.currentAddress.value == "" &&
                                        controller.locationLoading.value ==
                                            false) {
                                      Prompts.showSnackBar(
                                          msg:
                                              "Please select your role and wait while we are fetching your current location",isWarning: true);
                                    }
                                  },
                                  child: Container(
                                    height: 26.5.h,
                                    width: 64.w,
                                    // Below is the code for Linear Gradient.
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              4), // changes position of shadow
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      gradient: controller.timerStatus.value ==
                                                      false &&
                                                  controller
                                                      .clockRunning.value ||
                                              controller.breakRunning.value ==
                                                  true
                                          ? LinearGradient(
                                              colors: [
                                                AppColors.orange,
                                                AppColors.orange
                                                    .withOpacity(0.9)
                                              ],
                                              begin: Alignment.bottomLeft,
                                              // end: Alignment.topRight,
                                            )
                                          : LinearGradient(
                                              colors: [
                                                const Color(0xff0062BD),
                                                const Color(0xff002D4B)
                                                    .withOpacity(0.9)
                                              ],
                                              begin: Alignment.bottomLeft,
                                              // end: Alignment.topRight,
                                            ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Image.asset(
                                          'assets/images/Group 137.png',
                                          scale: 3,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          " ${twoDigits(controller.clockDuration.value.inHours.remainder(60))}:${twoDigits(controller.clockDuration.value.inMinutes.remainder(60))}:${twoDigits(controller.clockDuration.value.inSeconds.remainder(60))}",
                                          // '00:00:00',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xffFFFFFF),
                                              fontSize: 20.sp),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          controller.timerStatus.value ==
                                                          false &&
                                                      controller
                                                          .clockRunning.value ||
                                                  controller
                                                          .breakRunning.value ==
                                                      true
                                              ? AppLocalizedStrings.finishWork
                                                  .tr()
                                              : AppLocalizedStrings.startWork
                                                  .tr(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xffFFFFFF),
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: controller.breakCounter.value > 0,
                                  child: Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => const Activity());
                                      },
                                      child: Container(
                                        height: 4.5.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          color: AppColors.bottomBar,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            AppAssets.historyIcon,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          SizedBox(
                            height: 0.022 * size.height,
                          ),
                          Center(
                            // padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              children: [
                                Visibility(
                                  visible:
                                      controller.clockRunning.value == true ||
                                          controller.breakRunning.value == true,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.stopTimer(
                                              resets: false, context: context);
                                          if (controller.breakRunning.value ==
                                              true) {
                                            controller.stopBreak(resets: true);
                                            // breakDuration = const Duration();
                                            controller.startTimer();
                                          } else {
                                            // reset();
                                            controller.startBreak();
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 0.05 * size.height,
                                          width: 0.13 * size.width,
                                          decoration: BoxDecoration(
                                              color: controller
                                                          .breakRunning.value ==
                                                      true
                                                  ? AppColors.orange
                                                  : AppColors.buttonBlue,
                                              shape: BoxShape.circle),
                                          child: Image.asset(
                                            AppAssets.breakIcon,
                                            scale: 3,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.breakRunning.value ==
                                                    true
                                                ? AppLocalizedStrings.tapToEnd
                                                    .tr()
                                                : AppLocalizedStrings.tapToStart
                                                    .tr(),
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            AppLocalizedStrings.Break.tr(),
                                            style: TextStyle(
                                              fontSize: 17.sp,
                                              color: controller
                                                          .breakRunning.value ==
                                                      true
                                                  ? AppColors.orange
                                                  : AppColors.buttonBlue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: controller.clockRunning.value ==
                                          false &&
                                      controller.breakRunning.value == false,
                                  child: Text(
                                    controller.isLoading.value &&
                                            controller.sliderOpen.value == false
                                        ? ""
                                        : controller.role.value,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.orange,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: controller.clockRunning.value == true
                                      ? 0.5.h
                                      : 0,
                                ),
                                if (controller.currentAddress.value != "")
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 8),
                                    child: Text(
                                      controller.currentAddress.value
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.5.sp),
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
                            ),
                          ),
                          SizedBox(
                            height: controller.breakRunning.value == true
                                ? 2.h
                                : 2.5.h,
                          ),
                          SizedBox(
                            height:
                                controller.clockRunning.value == true ? 0 : 0.8.h,
                          ),
                          Center(
                            child: Column(
                              children: [
                                Visibility(
                                  visible:
                                      controller.breakRunning.value == false,
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
                                ),
                                Visibility(
                                  visible:
                                      controller.breakRunning.value == true,
                                  child: Container(
                                    height: 11.2.h,
                                    width: 0.9 * size.width,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 1,
                                          offset: const Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 0.01 * size.height,
                                        ),
                                        Container(
                                          height: 0.03 * size.height,
                                          width: 0.2 * size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                8,
                                              ),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 1,
                                                offset: const Offset(0,
                                                    1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Break ${controller.breakCounter.value}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 6.2 * textsize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.007 * size.height,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3.0, right: 3.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(children: [
                                                const Text(
                                                  "Start Time",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13.2),
                                                ),
                                                Container(
                                                  height: 0.028 * size.height,
                                                  width: 0.15 * size.width,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors.buttonBlue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      controller
                                                          .Breakstart.value,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            6.2 * textsize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 1),
                                                child: Text(
                                                  " ${twoDigits(controller.breakDuration.value.inHours.remainder(60))}:${twoDigits(controller.breakDuration.value.inMinutes.remainder(60))}:${twoDigits(controller.breakDuration.value.inSeconds.remainder(60))}",
                                                  style: TextStyle(
                                                    fontSize: 15.2 * textsize,
                                                    color: AppColors.orange,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Column(children: [
                                                const Text(
                                                  "End Time",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13.2),
                                                ),
                                                Container(
                                                  height: 0.028 * size.height,
                                                  width: 0.15 * size.width,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors.buttonBlue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      controller.finishBreak
                                                                  .value ==
                                                              ""
                                                          ? "-----"
                                                          : controller
                                                              .finishBreak
                                                              .value,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            6.2 * textsize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.01 * size.height,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.isLoading.value == true
                        ? Stack(children: [
                            GestureDetector(
                              onTap: () {
                                controller.isLoading.value = false;
                              },
                              child: Container(
                                height: 1 * size.height,
                                width: 1 * size.width,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            Positioned(
                              top: 0.142 * size.height,
                              left: 0.094 * size.width,
                              child: SizedBox(
                                // color: Color(0xffE4E4E4),
                                width: size.width,
                                height: 0.22 * size.height,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          right: 4, top: 3),
                                      // width: 290,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffE4E4E4),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 0.01 * size.width,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 0.01 * size.height,
                                              ),
                                              Image.asset(
                                                "assets/images/FZSnPc.png",
                                                scale: 3,
                                                // height: 0.04 * size.height,
                                              ),
                                              SizedBox(
                                                height: 0.01 * size.height,
                                              ),
                                              RotatedBox(
                                                quarterTurns: 3,
                                                child: Text(
                                                  AppLocalizedStrings.selectRole
                                                      .tr(),
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff000000),
                                                      fontSize:
                                                          0.0215 * size.height,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 0.01 * size.width,
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff0062BD),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ),
                                          )),
                                      onPressed: () {
                                        controller.isLoading.value =
                                            !controller.isLoading.value;
                                      },
                                      child: SizedBox(
                                        height: 0.03 * size.height,
                                        child: controller.isLoading.value ==
                                                false
                                            ? const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: Color(0xffffffff),
                                              )
                                            : const Icon(
                                                Icons.arrow_back_ios_outlined,
                                                color: Color(0xffffffff),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 0.08 * size.width,
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 0.13 * size.height),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff0062BD),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        10,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0,
                                            2.5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  width: 0.38 * size.width,
                                  height: 0.24 * size.height,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            // controller.roleSelected.value==true;

                                            // Get.defaultDialog(
                                            //   title:
                                            //   "Are You Sure You Want To Finish This Action?",
                                            //   titlePadding:
                                            //   const EdgeInsets.all(22),
                                            //   contentPadding:
                                            //   const EdgeInsets.only(
                                            //       left: 22, right: 22),
                                            //   titleStyle: TextStyle(
                                            //     fontSize: 9.8 * textsize,
                                            //     fontWeight: FontWeight.bold,
                                            //   ),
                                            //   actions: <Widget>[
                                            //     Row(children: [
                                            //       Column(
                                            //         children: [
                                            //           GestureDetector(
                                            //             onTap: () {
                                            //               // Dialog.getDialogs(context).pop();
                                            //               // Get.back();
                                            //             },
                                            //             child: Container(
                                            //               height: 0.04 *
                                            //                   size.height,
                                            //               width:
                                            //               0.3 * size.width,
                                            //               decoration:
                                            //               BoxDecoration(
                                            //                 boxShadow: [
                                            //                   BoxShadow(
                                            //                     color: Colors
                                            //                         .grey
                                            //                         .withOpacity(
                                            //                         0.2),
                                            //                     spreadRadius: 3,
                                            //                     blurRadius: 2,
                                            //                     offset: const Offset(
                                            //                         0,
                                            //                         1), // changes position of shadow
                                            //                   ),
                                            //                 ],
                                            //                 color: Colors.white,
                                            //                 borderRadius:
                                            //                 const BorderRadius
                                            //                     .all(
                                            //                   Radius.circular(
                                            //                     10,
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //               child: const Center(
                                            //                 child: Text(
                                            //                   "NO",
                                            //                   style: TextStyle(
                                            //                     fontWeight:
                                            //                     FontWeight
                                            //                         .bold,
                                            //                     fontSize: 18,
                                            //                     color: Color(
                                            //                         0xff0062BD),
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             ),
                                            //           ),
                                            //           const SizedBox(
                                            //             height: 10,
                                            //           )
                                            //         ],
                                            //       ),
                                            //       const SizedBox(
                                            //         width: 15,
                                            //       ),
                                            //       Column(
                                            //         children: [
                                            //           GestureDetector(
                                            //             onTap: () {
                                            //               isLoading = false;
                                            //               Get.back();
                                            //               // Get.off(HomeScreen());
                                            //               // Get.to();
                                            //             },
                                            //             child: Container(
                                            //               height: 0.04 *
                                            //                   size.height,
                                            //               width:
                                            //               0.3 * size.width,
                                            //               decoration:
                                            //               BoxDecoration(
                                            //                 boxShadow: [
                                            //                   BoxShadow(
                                            //                     color: Colors
                                            //                         .grey
                                            //                         .withOpacity(
                                            //                         0.2),
                                            //                     spreadRadius: 3,
                                            //                     blurRadius: 2,
                                            //                     offset: const Offset(
                                            //                         0,
                                            //                         1), // changes position of shadow
                                            //                   ),
                                            //                 ],
                                            //                 color: const Color(
                                            //                     0xff0062BD),
                                            //                 borderRadius:
                                            //                 const BorderRadius
                                            //                     .all(
                                            //                   Radius.circular(
                                            //                     10,
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //               child: const Center(
                                            //                 child: Text(
                                            //                   "YES",
                                            //                   style: TextStyle(
                                            //                     fontWeight:
                                            //                     FontWeight
                                            //                         .bold,
                                            //                     fontSize: 18,
                                            //                     color: Colors
                                            //                         .white,
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             ),
                                            //           ),
                                            //           const SizedBox(
                                            //             height: 10,
                                            //           )
                                            //         ],
                                            //       )
                                            //     ]),
                                            //   ],
                                            //   content: Container(
                                            //     padding:
                                            //     const EdgeInsets.all(12),
                                            //     height: 0.24 * size.height,
                                            //     width: 0.95 * size.width,
                                            //     decoration: BoxDecoration(
                                            //       color: const Color(0xff0062BD)
                                            //           .withOpacity(0.1),
                                            //       borderRadius:
                                            //       const BorderRadius.all(
                                            //         Radius.circular(10),
                                            //       ),
                                            //     ),
                                            //     child: Column(children: [
                                            //       Image.asset(
                                            //         AppAssets.disclaimerIcon,
                                            //         scale: 3,
                                            //       ),
                                            //       const SizedBox(
                                            //         height: 5,
                                            //       ),
                                            //       const Text(
                                            //         "Disclaimer",
                                            //         style: TextStyle(
                                            //           fontWeight:
                                            //           FontWeight.bold,
                                            //           color: Colors.black,
                                            //         ),
                                            //       ),
                                            //       const SizedBox(
                                            //         height: 28,
                                            //       ),
                                            //       Text(
                                            //         "If you end this action your next action will be automatically started",
                                            //         textAlign: TextAlign.center,
                                            //         style: TextStyle(
                                            //             fontSize:
                                            //             6.5 * textsize),
                                            //       ),
                                            //       SizedBox(
                                            //         height: 0.015*size.height,
                                            //       ),
                                            //       Text(
                                            //         "Install on Front Door",
                                            //         style: TextStyle(
                                            //           fontSize: 7.2 * textsize,
                                            //           fontWeight:
                                            //           FontWeight.bold,
                                            //           color: Color(0xff0062BD),
                                            //         ),
                                            //       ),
                                            //     ]),
                                            //   ),
                                            // );

                                            // sliderOpen==true;
                                            controller.clockDuration.value
                                                            .inSeconds
                                                            .remainder(60) >
                                                        0 ||
                                                    controller.clockRunning
                                                            .value ==
                                                        true
                                                ? Prompts.showSnackBar(
                                                    msg:
                                                        "Cant Change the roles when working on Project!!",isWarning: true)
                                                : controller.role.value =
                                                    AppLocalizedStrings
                                                        .electrician
                                                        .tr();
                                            controller.isLoading.value = false;
                                            await locator<StoreServices>()
                                            .setLocal(AppStorage.role, "userid", controller.role.value);
                                          },
                                          child: Container(
                                            height: 0.045 * size.height,
                                            width: 0.29 * size.width,
                                            decoration: BoxDecoration(
                                              color: controller.role.value ==
                                                      AppLocalizedStrings
                                                          .electrician
                                                          .tr()
                                                  ? AppColors.bottomBar
                                                  : Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  12,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    AppAssets.electrician,
                                                    scale: 1,
                                                    color: controller
                                                                .role.value ==
                                                            AppLocalizedStrings
                                                                .electrician
                                                                .tr()
                                                        ? Colors.white
                                                        : AppColors.buttonBlue,
                                                  ),
                                                  Text(
                                                    AppLocalizedStrings
                                                        .electrician
                                                        .tr(),
                                                    style: TextStyle(
                                                      color: controller
                                                                  .role.value ==
                                                              AppLocalizedStrings
                                                                  .electrician
                                                                  .tr()
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 6.2 * textsize,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            controller.clockDuration.value
                                                            .inSeconds
                                                            .remainder(60) >
                                                        0 ||
                                                    controller.clockRunning
                                                            .value ==
                                                        true
                                                ? Prompts.showSnackBar(
                                                    msg:
                                                        "Cant Change the roles when working on Project!!",isWarning: true)
                                                :
                                                // setState(() {
                                                // Get.defaultDialog(
                                                //     title: "",
                                                //     content: SizedBox(
                                                //       height: 0.26 * size.height,
                                                //       width: 0.8 * size.width,
                                                //       child: Column(
                                                //         children: [
                                                //           Image.asset(
                                                //             AppAssets.taskCompleted,
                                                //             scale: 3,
                                                //           ),
                                                //           SizedBox(
                                                //             height:
                                                //                 0.01 * size.height,
                                                //           ),
                                                //           const Text(
                                                //             "Time Marked",
                                                //             style: TextStyle(
                                                //               fontSize: 16,
                                                //               fontWeight:
                                                //                   FontWeight.bold,
                                                //             ),
                                                //           ),
                                                //           SizedBox(
                                                //             height:
                                                //                 0.05 * size.height,
                                                //           ),
                                                //           Row(
                                                //             mainAxisAlignment:
                                                //                 MainAxisAlignment
                                                //                     .spaceEvenly,
                                                //             children: [
                                                //               Column(children: [
                                                //                 Image.asset(
                                                //                   AppAssets
                                                //                       .startWork,
                                                //                   scale: 3,
                                                //                 ),
                                                //                 const Text(
                                                //                   "12:00",
                                                //                   style: TextStyle(
                                                //                     fontSize: 14,
                                                //                     fontWeight:
                                                //                         FontWeight
                                                //                             .bold,
                                                //                     color: AppColors
                                                //                         .orange,
                                                //                   ),
                                                //                 ),
                                                //                 const Text(
                                                //                   "Start Work",
                                                //                   style: TextStyle(
                                                //                     fontSize: 11,
                                                //                     fontWeight:
                                                //                         FontWeight
                                                //                             .bold,
                                                //                     color: Colors
                                                //                         .black,
                                                //                   ),
                                                //                 ),
                                                //               ]),
                                                //               Column(children: [
                                                //                 Image.asset(
                                                //                   AppAssets
                                                //                       .finishWork,
                                                //                   scale: 2,
                                                //                 ),
                                                //                 const Text(
                                                //                   "12:00",
                                                //                   style: TextStyle(
                                                //                     fontSize: 14,
                                                //                     fontWeight:
                                                //                         FontWeight
                                                //                             .bold,
                                                //                     color: AppColors
                                                //                         .orange,
                                                //                   ),
                                                //                 ),
                                                //                 const Text(
                                                //                   "Start Work",
                                                //                   style: TextStyle(
                                                //                     fontSize: 11,
                                                //                     fontWeight:
                                                //                         FontWeight
                                                //                             .bold,
                                                //                     color: Colors
                                                //                         .black,
                                                //                   ),
                                                //                 ),
                                                //               ]),
                                                //               Column(children: [
                                                //                 Image.asset(
                                                //                   AppAssets
                                                //                       .breakTime,
                                                //                   scale: 3,
                                                //                 ),
                                                //                 const Text(
                                                //                   "12:00",
                                                //                   style: TextStyle(
                                                //                     fontSize: 14,
                                                //                     fontWeight:
                                                //                         FontWeight
                                                //                             .bold,
                                                //                     color: AppColors
                                                //                         .orange,
                                                //                   ),
                                                //                 ),
                                                //                 const Text(
                                                //                   "Start Work",
                                                //                   style: TextStyle(
                                                //                     fontSize: 11,
                                                //                     fontWeight:
                                                //                         FontWeight
                                                //                             .bold,
                                                //                     color: Colors
                                                //                         .black,
                                                //                   ),
                                                //                 ),
                                                //               ]),
                                                //             ],
                                                //           ),
                                                //           SizedBox(
                                                //             height:
                                                //                 0.022*size.height,
                                                //           ),
                                                //           const Text(
                                                //             "User current location here",
                                                //             style: TextStyle(
                                                //                 fontSize: 15,
                                                //                 color:
                                                //                     Colors.black),
                                                //           )
                                                //         ],
                                                //       ),
                                                //     ));
                                                controller.role.value =
                                                    AppLocalizedStrings
                                                        .technician
                                                        .tr();
                                            await locator<StoreServices>()
                                            .setLocal(AppStorage.role, "userid", controller.role.value);
                                            controller.isLoading.value = false;
                                          },
                                          child: Container(
                                            height: 0.045 * size.height,
                                            width: 0.29 * size.width,
                                            decoration: BoxDecoration(
                                              color: controller.role.value ==
                                                      AppLocalizedStrings
                                                          .technician
                                                          .tr()
                                                  ? AppColors.bottomBar
                                                  : Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  12,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    AppAssets.technician,
                                                    scale: 3,
                                                    color: controller
                                                                .role.value ==
                                                            "Technician"
                                                        ? Colors.white
                                                        : AppColors.buttonBlue,
                                                  ),
                                                  Text(
                                                    AppLocalizedStrings
                                                        .technician
                                                        .tr(),
                                                    style: TextStyle(
                                                        color: controller.role
                                                                    .value ==
                                                                AppLocalizedStrings
                                                                    .technician
                                                                    .tr()
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontSize:
                                                            6.2 * textsize),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            controller.clockDuration.value
                                                            .inSeconds
                                                            .remainder(60) >
                                                        0 ||
                                                    controller.clockRunning
                                                            .value ==
                                                        true
                                                ? Prompts.showSnackBar(
                                                    msg:
                                                        "Cant Change the roles when working on Project!!",isWarning: true)
                                                :
                                                // setState(() {
                                                // Get.defaultDialog(
                                                //     title: "",
                                                //     content: Column(
                                                //       children: [
                                                //         Row(children: const [
                                                //           Text(
                                                //             "Motion and Fitness",
                                                //             style: TextStyle(
                                                //               fontWeight:
                                                //                   FontWeight.bold,
                                                //               fontSize: 16,
                                                //               color: Colors.black,
                                                //             ),
                                                //           ),
                                                //         ])
                                                //       ],
                                                //     ));
                                                controller.role.value =
                                                    AppLocalizedStrings.plumber
                                                        .tr();
                                            await locator<StoreServices>()
                                            .setLocal(AppStorage.role, "userid", controller.role.value);
                                            controller.isLoading.value = false;
                                          },
                                          child: Container(
                                            height: 0.045 * size.height,
                                            width: 0.29 * size.width,
                                            decoration: BoxDecoration(
                                              color: controller.role.value ==
                                                      AppLocalizedStrings
                                                          .plumber
                                                          .tr()
                                                  ? AppColors.bottomBar
                                                  : Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  12,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    AppAssets.plumber,
                                                    scale: 3,
                                                    color: controller
                                                                .role.value ==
                                                            AppLocalizedStrings
                                                                .plumber
                                                                .tr()
                                                        ? Colors.white
                                                        : AppColors.buttonBlue,
                                                  ),
                                                  Text(
                                                    AppLocalizedStrings.plumber
                                                        .tr(),
                                                    style: TextStyle(
                                                      color: controller
                                                                  .role.value ==
                                                              AppLocalizedStrings
                                                                  .plumber
                                                                  .tr()
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 6.2 * textsize,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // height: 20,
                                ),
                              ],
                            ),
                          ])
                        : Stack(children: [
                            Positioned(
                              top: 0.15 * size.height,
                              child: SizedBox(
                                width: 0.23 * size.width,
                                height: 0.22 * size.height,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 6, right: 6),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffE4E4E4),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 1,
                                              offset: const Offset(0,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 0.01 * size.height,
                                            ),
                                            Image.asset(
                                              "assets/images/FZSnPc.png",
                                              scale: 3,
                                              // height: 0.04 * size.height,
                                            ),
                                            SizedBox(
                                              height: 0.01 * size.height,
                                            ),
                                            RotatedBox(
                                              quarterTurns: 3,
                                              child: Text(
                                                AppLocalizedStrings.selectRole
                                                    .tr(),
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xff000000),
                                                    fontSize:
                                                        0.022 * size.height,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff0062BD),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                            )),
                                        onPressed: () {
                                          controller.isLoading.value =
                                              !controller.isLoading.value;
                                        },
                                        child: SizedBox(
                                          height: 0.06 * size.height,
                                          child: controller.isLoading.value ==
                                                  false
                                              ? const Center(
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    color: Color(0xffffffff),
                                                  ),
                                                )
                                              : const Center(
                                                  child: Icon(
                                                    Icons
                                                        .arrow_back_ios_outlined,
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            controller.locationLoading.value == true &&
                                    controller.currentAddress.value == ""
                                ? Stack(children: [
                                    Container(
                                      height: size.height,
                                      width: size.width,
                                      color:
                                          AppColors.bottomBar.withOpacity(0.7),
                                    ),
                                    Center(
                                      child: Container(
                                        height: 0.15 * size.height,
                                        width: 0.8 * size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(16),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 3,
                                              blurRadius: 1,
                                              offset: const Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: 0.02 * size.height,
                                                ),
                                                Icon(
                                                  Icons.location_on,
                                                  size: 0.05 * size.height,
                                                  color: AppColors.buttonBlue,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Please Wait while we are fetching your current location",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            0.02 * size.height),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const CircularProgressIndicator(
                                              color: AppColors.buttonBlue,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ])
                                : Container(),
                          ]),
                  ],
                ),
              ));
        });
  }
}
