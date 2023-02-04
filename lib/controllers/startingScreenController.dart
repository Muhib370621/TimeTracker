import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:blu_time/constants/app_storage.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/breakModel.dart';
import 'package:blu_time/models/project.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/app_colors.dart';
import '../shared/Prompts.dart';
import '../stores/store_services.dart';
import 'bottomNavigationController.dart';

class StartingScreenController extends GetxController {
  ///init state of the controller
  @override
  Future<void> onInit() async {
    determinePosition();
    // isLoading.value = false;
    timeString.value = _formatMainDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.onInit();
    // String roles =
    //     await locator<StoreServices>().getLocal(AppStorage.role, "userid");
    String currentLoc = await locator<StoreServices>()
            .getLocal(AppStorage.currentAddress, "userid") ??
        "";
    String timerStartTime = await locator<StoreServices>()
            .getLocal(AppStorage.timerStartTime, "userid") ??
        "";
    String timerFinishTime = await locator<StoreServices>()
            .getLocal(AppStorage.timeFinishTime, "userid") ??
        "";
    String timerTotalTime = await locator<StoreServices>()
            .getLocal(AppStorage.totalWorkTime, "userid") ??
        "";
    String project = await locator<StoreServices>()
            .getLocal(AppStorage.projectName, "userid") ??
        "";
    String acitivity = await locator<StoreServices>()
            .getLocal(AppStorage.activityName, "userid") ??
        "";
    String checklist = await locator<StoreServices>()
            .getLocal(AppStorage.checkListItemName, "userid") ??
        "";
    String breakStart = await locator<StoreServices>()
            .getLocal(AppStorage.breakStartTime, "userid") ??
        "";
    String breakPausedTime = await locator<StoreServices>()
            .getLocal(AppStorage.breakPausedTime, "userid") ??
        "";
    String breakFinish = await locator<StoreServices>()
            .getLocal(AppStorage.breakFinishTime, "userid") ??
        "";
    String timerInstance = await locator<StoreServices>()
            .getLocal(AppStorage.timerInstance, "userid") ??
        "";
    String projectIn = await locator<StoreServices>()
        .getLocal(AppStorage.projectIndex, "userid") ??
        "";
    // String projectID = await locator<StoreServices>()
    //     .getLocal(AppStorage.projectID, "userid") ?? "";
    // List<dynamic> breakList = await locator<StoreServices>()
    //     .getLocal(AppStorage.listOfBreaks, "userid");
    projectIndex.value = projectIn;
    final BottomNavController controller = Get.put(BottomNavController());
    controller.projectName.value = project;
    controller.activityName.value = acitivity;
    controller.checkListItem.value = checklist;
    Breakstart.value = breakStart;
    finishBreak.value = breakFinish;
    dynamic currentProjectJson = await locator<StoreServices>()
        .getLocal(AppStorage.currentProject, "userid");
    if (currentProjectJson != null) {
      Project? currentProject =
          Project().decode((Map<String, dynamic>.from(currentProjectJson)));
      controller.currentProject.value = currentProject;
    }
    // controller.projectId.value=projectID;
    // role.value = roles;
    currentAddress.value = currentLoc;
    var res =
        DateFormat.jm().format(DateFormat("hh:mm:ss").parse(timerStartTime));
    startTime.value = res;
    finishTime.value = timerFinishTime;
    totalTime.value = timerTotalTime;
    // listOfBreaks = breakList;
    if (startTime.value != "" && finishTime.value == "") {
      print("Run The timer");
      startTimer();
      var dateFormat = DateFormat('hh:mm:ss');
      DateTime currtime = dateFormat.parse(updatedString.value);
      var s = await locator<StoreServices>()
          .getLocal(AppStorage.timerStartTime, "userid");
      DateTime start = dateFormat.parse(s);
      Duration res = currtime.difference(start);
      clockDuration.value = res - breakDuration.value;
    }
    if (Breakstart.value != "" && finishBreak.value == "") {
      // print("Resumed Time $pausedTime");
      // print("Run the break");
      startBreak();
      print("Break Start ${Breakstart.value}");
      var dateFormat = DateFormat('hh:mm:ss');
      print("break Paused Time $breakPausedTime");
      DateTime currtime = dateFormat.parse(Breakstart.value);
      // var s = await locator<StoreServices>()
      //     .getLocal(AppStorage.breakStartTime, "userid");
      DateTime start = dateFormat.parse(breakPausedTime);
      // print("Break Finish ${}");
      Duration res = currtime.difference(start);
      print("res $res");
      breakDuration.value = res;
      print("timer instance ${timerInstance}");
      List<String> parts = timerInstance.split(":");
      print("parts $parts");
      int minutes = int.parse(parts[1]);
      // int seconds = int.parse(parts[2]);
      List<String> subParts = parts[2].split(".");
      print("subparts $subParts");
      int sec = int.parse(subParts[0]);
      // int three = parts[3];
      // Convert minutes and seconds to microseconds
      Duration newDuration = Duration(seconds: sec,minutes: minutes,);
      // var clockValue = Duration(seconds: 10);
      clockDuration.value = newDuration;
    }
  }

  ///dispose state of the controller
  @override
  Future<void> dispose() async {
    await locator<StoreServices>().setLocal(AppStorage.timerTime, "userid",
        " ${twoDigits(clockDuration.value.inHours.remainder(60))}:${twoDigits(clockDuration.value.inMinutes.remainder(60))}:${twoDigits(clockDuration.value.inSeconds.remainder(60))}");
    await locator<StoreServices>().setLocal(AppStorage.appPausedTime, "userid",
        DateFormat("hh:mm:ss").format(DateTime.now()));
    super.dispose();
  }

  /// all the variables of the controller
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  Rx<DateTime> today = DateTime.now().toLocal().obs;
  List listOfBreaks = <BreakModel>[].obs;
  RxString timer_value = "".obs;
  RxBool isSwitched = false.obs;
  RxBool countDown = false.obs;
  RxBool GPS = false.obs;
  var countdownDuration = const Duration().obs;
  Rx<Duration> clockDuration = const Duration().obs;
  Rx<Duration> breakDuration = const Duration().obs;
  Timer? timer;
  Timer? breakTimer;
  final RxString currentAddress = "".obs;

  // RxString role = "".obs;
  // RxBool isLoading = false.obs;
  // RxBool sliderOpen = true.obs;
  RxBool locationLoading = false.obs;
  RxBool timerStatus = false.obs;
  RxBool clockRunning = false.obs;
  RxBool breakRunning = false.obs;
  RxString startDate = ''.obs;
  RxString startTime = ''.obs;
  RxString finishTime = ''.obs;
  RxString totalTime = ''.obs;
  RxString Breakstart = ''.obs;
  RxString finishBreak = ''.obs;
  RxString totalBreak = ''.obs;
  RxString stopSelector = "".obs;
  RxBool isStopSelecting = false.obs;

  // RxBool isChecklistConfirm = false.obs;
  RxBool isNear = false.obs;
  RxBool addSuccess = false.obs;
  RxBool isEditting = false.obs;
  RxInt editIndex = 0.obs;
  RxBool editSuccess = false.obs;
  RxBool deletionConfirmation = false.obs;
  RxInt deleteIndex = 0.obs;
  final Rx<Position> currentPosition = const Position(
    longitude: 0,
    latitude: 0,
    timestamp: null,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  ).obs;
  final RxString timeString = ''.obs;
  final RxString updatedString = ''.obs;
  RxInt breakCounter = 0.obs;
  RxBool projectSelected = false.obs;
  RxString projectIndex = "".obs;
  RxString breakStopString = "".obs;

  ///----functions of the controller----///
  ///removes the break from break list
  removeBreak(index) {
    listOfBreaks.removeAt(index);
    update();
  }

  ///edits the element from break list
  editBreak(index, bstart, bend, diff) {
    /// create a copy of the original list
    List<BreakModel> newList = List.from(listOfBreaks);
    newList[index] =
        BreakModel(breakStart: bstart, breakEnd: bend, totalBreakTime: diff);
    listOfBreaks = newList;
    update();
  }

  ///checks the permission of location in application
  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse) {}
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }

  ///check that the GPS is enabled or not
  Future gpsService(context) async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      _checkGps(context);
      return true;
    } else {}
  }

  ///shows custom prompt for enabling location
  Future _checkGps(context) async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            final StartingScreenController controller =
                Get.put(StartingScreenController());
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.bottomBar.withOpacity(0.6),
                ),
                AlertDialog(
                  insetPadding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  content: Container(
                    height: 0.22 * MediaQuery.of(context).size.height,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Motion And Fitness",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.5.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Obx(
                              () => Switch(
                                activeColor: AppColors.buttonBlue,
                                value: controller.isSwitched.value,
                                onChanged: (value) {
                                  controller.isSwitched.value =
                                      !controller.isSwitched.value;
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Enable Location?',
                          style: TextStyle(
                            fontSize: 16.5.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: Adaptive.h(2),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5),
                          child: Text(
                            'Please make sure you enable GPS and try again',
                            style: TextStyle(
                              fontSize: 15.5.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Adaptive.h(1.5),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (isSwitched.value == true) {
                                const AndroidIntent intent = AndroidIntent(
                                    action:
                                        'android.settings.LOCATION_SOURCE_SETTINGS');
                                intent.launch();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              }
                            },
                            child: Obx(
                              () => Container(
                                height: Adaptive.h(4),
                                width: Adaptive.w(35),
                                decoration: BoxDecoration(
                                  color: isSwitched.value
                                      ? AppColors.buttonBlue
                                      : AppColors.buttonBlue.withOpacity(0.8),
                                  borderRadius: const BorderRadius.all(
                                    //55 +
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Allow",
                                    style: TextStyle(
                                      color: isSwitched.value
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.8),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  /// triggers when you tap on start time after getting current location
  void startTimer() async {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    clockRunning.value = true;
    // FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_EMERG);
    FlutterBeep.beep(false);
    //   if (await Vibrate.canVibrate) {
    Vibrate.vibrate();
    // }
    finishTime.value = "";
    totalTime.value = "";
    startDate.value = DateFormat('EEEE, MMM dd').format(today.value).toString();
    // Prompts.timeTrackingStarted(msg: "Time Tracking Has Started");
    await locator<StoreServices>()
        .setLocal(AppStorage.currentDate, "userid", today.value.toString());
    await locator<StoreServices>()
        .setLocal(AppStorage.timeFinishTime, "userid", "");
    await locator<StoreServices>()
        .setLocal(AppStorage.totalWorkTime, "userid", "");
  }

  /// add a second to the instance of "clock duration"
  void addTime() {
    final addSeconds = countDown.value ? -1 : 1;
    final seconds = clockDuration.value.inSeconds + addSeconds;
    if (seconds > 359999) {
      timer?.cancel();
    } else {
      clockDuration.value = Duration(seconds: seconds);
    }
  }

  ///triggers when tapped on start break button
  void startBreak() async {
    breakTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => addBreakTime());
    breakRunning.value = true;
    breakCounter++;
    getBreakStartTime();
    finishBreak.value = "";
    await locator<StoreServices>()
        .setLocal(AppStorage.breakFinishTime, "userid", "");
    await locator<StoreServices>()
        .setLocal(AppStorage.totalBreakTime, "userid", "");
    await locator<StoreServices>().setLocal(AppStorage.breakPausedTime,
        "userid", DateFormat("hh:mm:ss").format(DateTime.now()));

    print("timer Instance ${clockDuration.value}");
  // }
    // await locator<StoreServices>()
    //     .setLocal(AppStorage.breakStartTime, "userid", Breakstart.value);
  }

  /// add a second to the instance "break duration"
  void addBreakTime() {
    final addSeconds = countDown.value ? -1 : 1;
    final seconds = breakDuration.value.inSeconds + addSeconds;
    if (seconds < 0) {
      breakTimer?.cancel();
    } else {
      breakDuration.value = Duration(seconds: seconds);
    }
  }

  /// get the start time of the timer
  Future<void> getStartTime() async {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    startTime.value = formattedDateTime;
    await locator<StoreServices>().setLocal(AppStorage.timerStartTime, "userid",
        DateFormat('hh:mm:ss').format(now));
  }

  Future<void> getBreakStartTime() async {
    final DateTime now = DateTime.now();
    final String formattedDateTime = DateFormat('hh:mm:ss').format(now);
    Breakstart.value = formattedDateTime;
    await locator<StoreServices>().setLocal(AppStorage.breakStartTime, "userid",
        DateFormat('hh:mm:ss').format(now));
  }

  void getBreakEndTime() async {
    final DateTime now = DateTime.now();
    final String formattedDateTime = DateFormat("hh:mm:ss").format(now);
    finishBreak.value = formattedDateTime;
    await locator<StoreServices>()
        .setLocal(AppStorage.breakFinishTime, "userid", finishBreak.value);
  }

  void subtractTime() async {
    var dateFormat = DateFormat('hh:mm a');
    DateTime start = dateFormat.parse(startTime.value);
    DateTime finish = dateFormat.parse(finishTime.value);
    Duration diff = finish.difference(start);
    var hourDiff = diff.inHours.toString();
    var minutesDiff = (diff.inMinutes % 60).toString();
    totalTime.value = "${hourDiff}h  ${minutesDiff}m";
    await locator<StoreServices>()
        .setLocal(AppStorage.totalWorkTime, "userid", totalTime.value);
  }

  void subtractBreak() async {
    var dateFormat = DateFormat('hh:mm a');
    var startFormat = DateFormat('hh:mm:ss');
    DateTime start = startFormat.parse(Breakstart.value);
    DateTime finish = startFormat.parse(finishBreak.value);
    Duration diff = finish.difference(start);
    var hourDiff = diff.inHours.toString();
    var minutesDiff = (diff.inMinutes % 60).toString();
    totalBreak.value = "${hourDiff}h  ${minutesDiff}m";
    await locator<StoreServices>()
        .setLocal(AppStorage.totalBreakTime, "userid", totalBreak.value);
  }

  void getFinishTime() async {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    finishTime.value = formattedDateTime;
    await locator<StoreServices>()
        .setLocal(AppStorage.timeFinishTime, "userid", finishTime.value);
  }

  void reset() {
    if (countDown.value) {
      clockDuration.value = countdownDuration.value;
    } else {
      clockDuration.value = const Duration();
    }
  }

  void resetBreak() {
    if (countDown.value) {
      breakDuration.value = countdownDuration.value;
    } else {
      breakDuration.value = const Duration();
    }
  }

  void stopTimer({bool resets = true, required context}) async {
    if (resets) {
      reset();
    }
    if (stopSelector.value == "Pause Timer") {
      timer?.cancel();
      clockRunning.value = false;
      getFinishTime();
      subtractTime();
    }
    if (stopSelector.value == "Finish Work") {
      timer?.cancel();
      reset();
      clockRunning.value = false;
      getFinishTime();
      subtractTime();
    }
    stopSelector.value = "";
  }

  Future<void> stopBreak({bool resets = true}) async {
    if (resets) {
      resetBreak();
    }
    breakTimer?.cancel();
    getBreakEndTime();
    subtractBreak();
    listOfBreaks.add(BreakModel(
        breakStart: Breakstart.value,
        breakEnd: finishBreak.value,
        totalBreakTime: totalBreak.value));
    // await locator<StoreServices>()
    //     .setLocal(AppStorage.listOfBreaks, "userid", listOfBreaks.toList());
    // List<dynamic> breakList = await locator<StoreServices>()
    //     .getLocal(AppStorage.listOfBreaks, "userid");
    // print("list break ${breakList.toString()}");
    // Future.delayed(const Duration(seconds: 3), () {
    breakRunning.value = false;
    breakStopString.value = DateFormat("hh:mm:ss").format(DateTime.now());
    await locator<StoreServices>().setLocal(AppStorage.breakPausedTime,
        "userid", DateFormat("hh:mm:ss").format(DateTime.now()));
    // });
  }

  getCurrentLocation() async {
    determinePosition();
    locationLoading.value = true;
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: false,
    );
    _getAddressFromLatLng(position.latitude, position.longitude);
    locationLoading.value = false;
  }

  _getAddressFromLatLng(latitude, longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      currentAddress.value =
          "${place.locality}, ${place.subLocality}, ${place.street}";
      await locator<StoreServices>()
          .setLocal(AppStorage.currentAddress, "userid", currentAddress.value);
      double distanceInMeters = Geolocator.distanceBetween(
          37.788022, -122.399797, latitude, longitude);
      if (distanceInMeters <= 100.0) {
        isNear.value = true;
        // print("The given location is near to your current location");
      } else {
        isNear.value = false;
        // print("The given location is far to your current location");
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == 'IO_ERROR') {
          // handle the network error
          Prompts.noInternet(
              msg: "Please check your Internet Connection", isWarning: true);
        }
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  String _formatMainDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatMainDateTime(now);
    timeString.value = formattedDateTime;
  }
}
