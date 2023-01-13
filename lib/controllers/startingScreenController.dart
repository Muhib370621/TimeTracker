import 'dart:async';
import 'package:android_intent_plus/android_intent.dart';
import 'package:blu_time/shared/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import 'BottomNavigationController.dart';

class StartingScreenController extends GetxController {
  @override
  void onInit() {
    clockRunning.value = false;
    determinePosition();
    reset();
    isLoading.value = false;
    timeString.value = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    locationLoading.value = true;
    locationLoading.value = false;
    super.onInit();
  }

  Rx<DateTime> today = DateTime.now().toLocal().obs;
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

  void startTimer() {
    final BottomNavController controller = Get.put(BottomNavController());
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    clockRunning.value = true;
    controller.currentIndex.value=2;
    if (breakRunning.value == false) {}
    finishTime.value="";
    totalTime.value="";
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

  void startBreak() {
    breakTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => addBreakTime());
    breakRunning.value = true;
    getBreakStartTime();
    finishBreak.value="";

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

  void getStartTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    startTime.value = formattedDateTime;
  }

  void getBreakStartTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    Breakstart.value = formattedDateTime;
  }

  void getBreakEndTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    finishBreak.value = formattedDateTime;
  }

  void subtractTime() {
    var dateFormat = DateFormat('hh:mm');
    var hourDiff;
    var minutes_diff;
    DateTime start = dateFormat.parse(startTime.value);
    DateTime finish = dateFormat.parse(finishTime.value);
    Duration diff = finish.difference(start);
    print(diff);
    hourDiff = diff.inHours.toString();
    minutes_diff = diff.inMinutes.toString();
    totalTime.value = "${hourDiff}h  ${minutes_diff}m";
    print(totalTime.value);
  }

  void getFinishTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    finishTime.value = formattedDateTime;
  }

  void reset() {
    if (countDown.value) {
      breakDuration.value = countdownDuration.value;
    } else {
      breakDuration.value = const Duration();
    }
  }

  void stopTimer({bool resets = true, required context}) {
    if (resets) {
      reset();
    }
    timer?.cancel();
    clockRunning.value = false;

    getFinishTime();
    subtractTime();
    final Size size = MediaQuery.of(context).size;
    if (
    breakRunning.value==false) {
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
                    fontSize: 0.017 * size.height,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 0.05 * size.height,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      Image.asset(
                        AppAssets.startWork,
                        scale: 3,
                      ),
                      Text(
                        startTime.value,
                        style: TextStyle(
                          fontSize: 0.017 * size.height,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange,
                        ),
                      ),
                      Text(
                        "Start Work",
                        style: TextStyle(
                          fontSize: 0.017 * size.height,
                          fontWeight: FontWeight.bold,
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
                        finishTime.value,
                        style: TextStyle(
                          fontSize: 0.017 * size.height,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange,
                        ),
                      ),
                      Text(
                        "Finish Work",
                        style: TextStyle(
                          fontSize: 0.017 * size.height,
                          fontWeight: FontWeight.bold,
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
                        totalTime.value,
                        style: TextStyle(
                          fontSize: 0.017 * size.height,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange,
                        ),
                      ),
                      Text(
                        "Total Work",
                        style: TextStyle(
                          fontSize: 0.017 * size.height,
                          fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    currentAddress.value.toString(),
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 0.017 * size.height,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis),
                  ),
                )
              ],
            ),
          ));
    }
  }

  void stopBreak({bool resets = true}) {
    if (resets) {
      reset();
    }
    breakTimer?.cancel();
    getBreakEndTime();
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
    } catch (e) {
      print(e);
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    // setState(() {
    timeString.value = formattedDateTime;
    // });
  }
}
