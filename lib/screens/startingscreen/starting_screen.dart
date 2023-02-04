import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/screens/startingscreen/components/breakButton.dart';
import 'package:blu_time/screens/startingscreen/components/breakTimer.dart';
import 'package:blu_time/screens/startingscreen/components/currentAddress.dart';
import 'package:blu_time/screens/startingscreen/components/fetchingLocation.dart';
import 'package:blu_time/screens/startingscreen/components/projectDetails.dart';
import 'package:blu_time/screens/startingscreen/components/stopTimerSelector.dart';
import 'package:blu_time/screens/startingscreen/components/timerButton.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

import '../../constants/app_storage.dart';
import '../../stores/store_services.dart';
import 'components/header.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen>
    with WidgetsBindingObserver {


  ///init state
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    final StartingScreenController controller =
    Get.put(StartingScreenController());
    controller.gpsService(context);
    super.initState();
  }

  ///on dispose
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }



  ///app life cycle
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    final StartingScreenController controller =
        Get.put(StartingScreenController());
    switch (state) {
      ///if the app is paused
      case AppLifecycleState.resumed:
        // controller.clockDuration.value + const Duration(minutes: 2);
        ///storing resumed time to local storage
        await locator<StoreServices>().setLocal(
            AppStorage.appResumedTime, "userid", DateFormat("hh:mm:ss").format(DateTime.now()));
        // String roles =
        //     await locator<StoreServices>().getLocal(AppStorage.role, "userid");

        ///setting role value from local storage
        // controller.role.value = roles;
        break;

      case AppLifecycleState.paused:
      ///when the app is paused
      ///save the timer time to local storage
      //   await locator<StoreServices>().setLocal(AppStorage.timerTime, "userid",
      //       " ${twoDigits(controller.clockDuration.value.inHours.remainder(60))}:${twoDigits(controller.clockDuration.value.inMinutes.remainder(60))}:${twoDigits(controller.clockDuration.value.inSeconds.remainder(60))}");
        ///save the app paused time to to the local storage
        await locator<StoreServices>().setLocal(
            AppStorage.appPausedTime, "userid", controller.timeString.value);
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        ///when the app is killed or removed from background
      ///save app resumed time
        await locator<StoreServices>().setLocal(
            AppStorage.appResumedTime, "userid", DateFormat("hh:mm:ss").format(DateTime.now()));
        break;
    }
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
        Get.put(StartingScreenController());
    final Size size = MediaQuery.of(context).size;
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
                            /// this is the header with local time and date
                            const StartHeader(),
                            SizedBox(
                              height: 3.h,
                            ),
                            ///this is the widget which have project name,action name and checklist item name
                            const ProjectDetails(),
                            SizedBox(height: 1.5.h,),
                            SizedBox(
                              height: controller.clockRunning.value ||
                                      controller.breakRunning.value == true
                                  ? 0.03 * size.height
                                  : 0.03 * size.height,
                            ),
                            ///this is the timer button with acitivity container also
                            const TimerButton(),
                          ],
                        ),
                        SizedBox(
                          height: 0.022 * size.height,
                        ),
                        Center(
                          child: Column(
                            children:  [
                              ///role text
                              // RoleText(),
                              SizedBox(height: 0.9.h,),
                              ///current address
                              const CurrentAddress(),
                              ///break button with text
                              SizedBox(height: 2.h,),

                              const BreakButton(),
                              SizedBox(height: 2.h,),
                              const Center(
                                child:
                                // Column(
                                  // children: const [
                                    ///shows start time, end time and total working time
                                    // TimerStatusWidget(),
                                    ///shows a break timer which starts when we tap break button
                                    BreakTimer(),
                                  // ],
                                // ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: controller.breakRunning.value == true
                        //       ? 2.h
                        //       : 2.5.h,
                        // ),
                        // SizedBox(
                        //   height:
                        //       controller.clockRunning.value == true ? 0 : 0.8.h,
                        // ),

                      ],
                    ),
                  ),
                  // controller.isLoading.value == true
                  //     ? Stack(
                  //         children: [
                  //           ///container with opaque bg
                  //           GestureDetector(
                  //             onTap: () {
                  //               controller.isLoading.value = false;
                  //             },
                  //             child: Container(
                  //               height: 1 * size.height,
                  //               width: 1 * size.width,
                  //               color: Colors.white.withOpacity(0.9),
                  //             ),
                  //           ),
                  //           ///slider with arrow and "select role" text
                  //           const RoleSliderAfter(),
                  //           ///role after selector with selection buttons
                  //           const RoleSelector(),
                  //         ],
                  //       )
                  //     :
                  Stack(
                          children: [
                            ///role before selector with selection buttons
                            // const RoleSliderBefore(),
                            controller.locationLoading.value == true &&
                                    controller.currentAddress.value == ""
                            ///fetching location popup
                                ? const FetchingLocation()
                                : Container(),
                          ],
                        ),

                  ///container with a opaque bg
                  Visibility(
                    visible: controller.isStopSelecting.value,
                        // controller.isChecklistConfirm.value == true

                    child: Container(
                      color: AppColors.bottomBar.withOpacity(0.7),
                    ),
                  ),

                  ///popup on stop timer
                  const StopTimerSelector(),

                  ///checklist confirmation popup
                  // const CheckListConfirmation(),
                ],
              ),
            ),
          );
        });
  }
}
