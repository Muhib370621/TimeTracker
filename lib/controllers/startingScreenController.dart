import 'dart:async';
import 'package:android_intent_plus/android_intent.dart';
import 'package:blu_time/constants/app_storage.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/breakModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/app_colors.dart';
import '../stores/store_services.dart';
import '../view_models/checklist_view_model.dart';
import 'BottomNavigationController.dart';

class StartingScreenController extends GetxController {
  @override
  Future<void> onInit() async {
    // RxInt activityIndex = 0.obs;
    // activityName.value="";
    // projectName.value="";
    // checkListItem.value="";
    // clockRunning.value = false;
    determinePosition();
    // reset();
    isLoading.value = false;
    timeString.value = _formatMainDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    // locationLoading.value = true;
    // locationLoading.value = false;
    super.onInit();
    String roles = await locator<StoreServices>().getLocal(AppStorage.role, "userid");

    String currentLoc = await locator<StoreServices>().getLocal(AppStorage.currentAddress, "userid");
    // String timerVal = await locator<StoreServices>().getLocal(AppStorage.timerTime, "userid");
    String timerStartTime = await locator<StoreServices>().getLocal(AppStorage.timerStartTime, "userid");
    String timerFinishTime = await locator<StoreServices>().getLocal(AppStorage.timeFinishTime, "userid");
    String timerTotalTime = await locator<StoreServices>().getLocal(AppStorage.totalWorkTime, "userid");

    String project = await locator<StoreServices>().getLocal(AppStorage.projectName, "userid");
    String acitivity = await locator<StoreServices>().getLocal(AppStorage.activityName, "userid");
    String checklist = await locator<StoreServices>().getLocal(AppStorage.checkListItemName, "userid");
    // var prjName = Get.find<BottomNavController>().projectName.value;
    final BottomNavController controller = Get.put(BottomNavController());
    controller.projectName.value=project;
    controller.activityName.value=acitivity;
    controller.checkListItem.value=checklist;
    // print("prjname $project");
    // print("timer start $timerStartTime");
    // List<BreakModel> breakList = await locator<StoreServices>().getLocal(AppStorage.listOfBreaks, "userid");
    role.value = roles;
    // String resume = await locator<StoreServices>().getLocal(AppStorage.appResumedTime, "userid");
    // String paused = await locator<StoreServices>().getLocal(AppStorage.appPausedTime, "userid");
    // var dateFormat = DateFormat('hh:mm');
      // startTimer();
      // print("Clock is Running");
      // clockRunning.value==true;
      // print(currentLoc);
      currentAddress.value=currentLoc;
      // clockDuration.value.inMinutes+minutes_diff;
      startTime.value=timerStartTime;
      finishTime.value = timerFinishTime;
      totalTime.value = timerTotalTime;
      // listOfBreaks = breakList;
      // print(listOfBreaks.toString());
      // print("minutes diff $minutes_diff");
      // print(timerVal);
    // twoDigits(controller.clockDuration.value.inMinutes.remainder(60)) =
    // twoDigits(controller.clockDuration.value.inMinutes.remainder(60))
    // +AutofillHints.middleName;
    // print("result $result");
    // print(note);
    // print(resume);
    // print("before ${clockDuration.value.inMinutes.toString()}");
    if(startTime.value!="" && finishTime.value ==""){
      startTimer();
      var dateFormat = DateFormat('hh:mm');
      DateTime currtime = dateFormat.parse(timeString.value);
      var s = await locator<StoreServices>().getLocal(AppStorage.timerStartTime, "userid");
      DateTime start = dateFormat.parse(s);
      Duration res =  currtime.difference(start);
      clockDuration.value=res;
      print(res);
    }
    // if(clockRunning.value==false){
    //   clockDuration.value = clockDuration.value+Duration(minutes: minutes_diff.toInt());}
    // if(timer_val!=null){
    //   clockDuration.value = timer_val;
    // }
  }

  @override
  Future<void> dispose() async {
    print("Paused");
    print("--------------------------------------------------------------------");
    await locator<StoreServices>()
    .setLocal(AppStorage.timerTime, "userid",
    " ${twoDigits(clockDuration.value.inHours.remainder(60))}:${twoDigits(clockDuration.value.inMinutes.remainder(60))}:${twoDigits(clockDuration.value.inSeconds.remainder(60))}");
    await locator<StoreServices>()
        .setLocal(AppStorage.appPausedTime, "userid", timeString.value);
    String paused = await locator<StoreServices>().getLocal(AppStorage.appPausedTime, "userid");
    print(paused);
    // _timer?.cancel();
    super.dispose();
  }
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  Rx<DateTime> today = DateTime.now().toLocal().obs;
  List listOfBreaks = <BreakModel>[].obs;
  // List<dynamic> actions = [].obs;

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
  RxString role = "".obs;
  RxBool isLoading = false.obs;
  RxBool sliderOpen = true.obs;
  RxBool locationLoading = false.obs;
  RxBool timerStatus = false.obs;
  RxBool clockRunning = false.obs;
  RxBool breakRunning = false.obs;
  RxString startTime = ''.obs;
  RxString finishTime = ''.obs;
  RxString totalTime = ''.obs;
  RxString Breakstart = ''.obs;
  RxString finishBreak = ''.obs;
  RxString totalBreak = ''.obs;
  RxString stopSelector = "".obs;
  RxBool isStopSelecting = false.obs;
  RxBool isChecklistConfirm = false.obs;
  RxBool isNear = false.obs;
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
  RxInt breakCounter = 0.obs;

  // RxString activityName = "".obs;
  // RxString projectName = "".obs;
  // RxString checkListItem = "".obs;

  // getNextValue(ChecklistViewModel model,int index){
  //   var value = model.checklist[index+1].custrecordBbPachklistTitle;
  //   return value;
  // }
  removeBreak(index){
  listOfBreaks.removeAt(index);
  update();
}

  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse) {
        // _getCurrentLocation();
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    // Geolocator.ena;
    return await Geolocator.getCurrentPosition();
  }

  /*Check if gps service is enabled or not*/
  Future gpsService(context) async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      _checkGps(context);
      return true;
    } else {
      // determinePosition();
      // Future.delayed(Duration(seconds: 3));
      // _getCurrentLocation();
    }
  }

  Future _checkGps(context) async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              final StartingScreenController controller =
                  Get.put(StartingScreenController());
              // final Size size = MediaQuery.of(context).size;
              return Stack(children: [
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
                                  // setState(() {
                                  controller.isSwitched.value =
                                      !controller.isSwitched.value;
                                  print(controller.isSwitched.value);
                                  // });
                                  // isSwitched= value;
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
                            style: TextStyle(fontSize: 15.5.sp),
                          ),
                        ),
                        SizedBox(
                          height: Adaptive.h(1.5),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              const AndroidIntent intent = AndroidIntent(
                                  action:
                                      'android.settings.LOCATION_SOURCE_SETTINGS');
                              // Future.delayed(const Duration(seconds: 3));
                              intent.launch();
                              Navigator.of(context, rootNavigator: true).pop();

                              // _gpsService();
                            },
                            child: Container(
                              height: Adaptive.h(4),
                              width: Adaptive.w(35),
                              decoration: const BoxDecoration(
                                color: AppColors.buttonBlue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Allow",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
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
              ]);
            });
      }
    }
  }

  void startTimer() async{
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    clockRunning.value = true;
    finishTime.value = "";
    totalTime.value = "";
    await locator<StoreServices>()
        .setLocal(AppStorage.currentDate, "userid", today.value.toString());
    // print("-----------------------");
    // print("saved properly");
    // String timerStartTime = await locator<StoreServices>().getLocal(AppStorage.timerStartTime, "userid");
    // print(timerStartTime);
    // print("done");
    await locator<StoreServices>()
        .setLocal(AppStorage.timeFinishTime, "userid", "");
    await locator<StoreServices>()
        .setLocal(AppStorage.totalWorkTime, "userid", "");
    // String rolesHeaders = 'NLAuth nlauth_account=${locator<StoreServices>().getAccountID()}, nlauth_email=${locator<StoreServices>().getUsername()}, nlauth_signature=${locator<StoreServices>().getPassword()}, nlauth_role=1172';
    // print(rolesHeaders);
    // Prompts.showSnackBar(msg: "Note saved locally");
  }

  void addTime() {
    final addSeconds = countDown.value ? -1 : 1;
    final seconds = clockDuration.value.inSeconds + addSeconds;
    if (seconds < 0) {
      timer?.cancel();
    } else {
      clockDuration.value = Duration(seconds: seconds);
    }
  }

  void startBreak() async {
    breakTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => addBreakTime());
    breakRunning.value = true;
    breakCounter++;
    getBreakStartTime();
    finishBreak.value = "";
    await locator<StoreServices>()
        .setLocal(AppStorage.breakStartTime, "userid", Breakstart.value);
    // List<dynamic> note = await locator<StoreServices>().getLocal(AppStorage.timerStartTime, "userid");
    // print(note);
  }

  void addBreakTime() {
    final addSeconds = countDown.value ? -1 : 1;
    final seconds = breakDuration.value.inSeconds + addSeconds;
    if (seconds < 0) {
      breakTimer?.cancel();
    } else {
      breakDuration.value = Duration(seconds: seconds);
    }
    // });
  }

  Future<void> getStartTime() async {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    startTime.value = formattedDateTime;
    await locator<StoreServices>()
    .setLocal(AppStorage.timerStartTime, "userid", startTime.value.toString());
  }

  void getBreakStartTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    Breakstart.value = formattedDateTime;
  }

  void getBreakEndTime() async{
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    finishBreak.value = formattedDateTime;
    await locator<StoreServices>()
    .setLocal(AppStorage.breakFinishTime, "userid", finishBreak.value);
  }

  void subtractTime() async{
    var dateFormat = DateFormat('hh:mm a');
    // var hourDiff;
    // var minutes_diff;
    DateTime start = dateFormat.parse(startTime.value);
    DateTime finish = dateFormat.parse(finishTime.value);
    Duration diff = finish.difference(start);
    // print(diff);
    var hourDiff = diff.inHours.toString();
    var minutesDiff = diff.inMinutes.toString();
    totalTime.value = "${hourDiff}h  ${minutesDiff}m";
    await locator<StoreServices>()
    .setLocal(AppStorage.totalWorkTime, "userid", totalTime.value);
    // print(totalTime.value);
  }

  void subtractBreak() async {
    var dateFormat = DateFormat('hh:mm a');
    var hourDiff;
    var minutes_diff;
    DateTime start = dateFormat.parse(Breakstart.value);
    DateTime finish = dateFormat.parse(finishBreak.value);
    Duration diff = finish.difference(start);
    print(diff);
    hourDiff = diff.inHours.toString();
    minutes_diff = diff.inMinutes.toString();
    totalBreak.value = "${hourDiff}h  ${minutes_diff}m";
    print(totalBreak.value);
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
    // isStopSelecting.value=true;
    if(stopSelector.value =="Pause Timer") {
      timer?.cancel();
    clockRunning.value = false;
      getFinishTime();
      subtractTime();
      print("-------------------------------");
      // List<dynamic>? note = await locator<StoreServices>().getLocal(AppStorage.listOfBreaks, "userid");
      // print(note!.length);
    }
    if(stopSelector.value =="Finish Work") {
      timer?.cancel();
      reset();
      clockRunning.value = false;
      getFinishTime();
      subtractTime();
      print("-------------------------------");
      // List<dynamic>? note = await locator<StoreServices>().getLocal(AppStorage.listOfBreaks, "userid");
      // print(note!.length);
    }

    stopSelector.value="";
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
    await locator<StoreServices>()
    .setLocal(AppStorage.listOfBreaks, "userid",listOfBreaks);
    List<dynamic> breakList = await locator<StoreServices>().getLocal(AppStorage.listOfBreaks, "userid");
    print("list break ${breakList[0].toString()}");
    Future.delayed(const Duration(seconds: 3), () {
      breakRunning.value = false;
    });
  }

  getCurrentLocation() async {
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
      double distanceInMeters = Geolocator.distanceBetween(37.788022, -122.399797, latitude, longitude);
      if (distanceInMeters <= 100.0) {
        isNear.value=true;
        print("The given location is near to your current location");
      } else {
        isNear.value=false;
        print("The given location is far to your current location");
      }
    } catch (e) {
      print(e);
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
    // setState(() {
    timeString.value = formattedDateTime;
    // });
  }

}
