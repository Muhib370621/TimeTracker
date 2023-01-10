import 'dart:async';
import 'package:android_intent_plus/android_intent.dart';
import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/screens/project/projects_screen.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../controllers/BottomNavigationController.dart';

// import 'package:permission_handler/permission_handler.dart';
//
// import 'package:geocoder/geocoder.dart';
// import 'package:location/location.dart';
//
// // import 'lib/constants/app_colors.dart';
class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  @override
  void initState() {
    clockRunning = false;
    _gpsService();
    determinePosition();
    // TODO: implement initState
    setState(() {
      isLoading == false;
      _timeString = _formatDateTime(DateTime.now());
      Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    });
    // if(_gpsService()==true){
    //
    // };

    // _checkPermission();
    super.initState();
    reset();
  }

  bool get wantKeepAlive => true;

  void dispose() {
    //...
    super.dispose();
    //...
  }

  static const countdownDuration = Duration();
  Duration clockDuration = const Duration();
  Duration breakDuration = const Duration();
  Timer? timer;
  Timer? breakTimer;
  bool countDown = false;
  String? _currentAddress;
  String role = "";
  bool isLoading = false;
  bool sliderOpen = true;
  bool locationLoading = false;
  Position? _currentPosition;
  late DateTime dateTime;
  String _timeString = '';
  bool GPS = false;
  bool timerStatus = false;
  bool clockRunning = false;
  bool breakRunning = false;
  String _startTime = '';
  String _finishTime = '';
  String _totalTime = '';
  String _breakStart = '';
  String _breakEnd = '';

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  void startTimer() {
    final BottomNavController controller = Get.put(BottomNavController());
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    clockRunning = true;
    // Get.to(() => const ProjectsScreen());
    if (breakRunning == false) {
      // controller.currentIndex.value = 2;
    }
  }

  void startBreak() {
      breakTimer =
          Timer.periodic(const Duration(seconds: 1), (_) => addBreakTime());
      breakRunning = true;

  }

  void addBreakTime() {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      // breakDuration == Duration();
      final seconds = breakDuration.inSeconds + addSeconds;
      if (seconds < 0) {
        breakTimer?.cancel();
      } else {
        breakDuration = Duration(seconds: seconds);
      }
    });
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = clockDuration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        clockDuration = Duration(seconds: seconds);
      }
    });
  }

  void reset() {
    if (countDown) {
      setState(() => breakDuration = countdownDuration);
    } else {
      setState(() => breakDuration = const Duration());
    }
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
    clockRunning = false;
    _getFinishTime();
    _subtractTime();
    final Size size = MediaQuery.of(context).size;
    var textsize = size.height / size.width;
    // if(clockRunning==false || breakRunning==null) {
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
                    fontSize:0.017 * size.height,
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
                        _startTime,
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
                        _finishTime,
                        style: TextStyle(
                          fontSize: 0.017 * size.height,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange,
                        ),
                      ),
                      Text(
                        "Finish Work",
                        style: TextStyle(
                          fontSize:0.017 * size.height,
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
                        _totalTime,
                        style: TextStyle(
                          fontSize: 0.017 * size.height,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange,
                        ),
                      ),
                      Text(
                        "Total Work",
                        style: TextStyle(
                          fontSize:0.017 * size.height,
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
                    _currentAddress.toString(),
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 0.017 * size.height, color: Colors.black,overflow: TextOverflow.ellipsis),
                  ),
                )
              ],
            ),
          ));
    // }
  }

  void stopBreak({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => breakTimer?.cancel());
    breakRunning = false;
    // _getFinishTime();
    // _subtractTime();
  }

  DateTime today = DateTime.now().toLocal();

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
  Future _gpsService() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      _checkGps();
      return true;
    } else {
      // determinePosition();
      // Future.delayed(Duration(seconds: 3));
      // _getCurrentLocation();
    }
  }

  Future _checkGps() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Motion And Fitness",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                content: Container(
                  height: 60,
                  width: 2560,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: const [
                      Text(
                        'Enable Location?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text('Please make sure you enable GPS and try again'),
                    ],
                  ),
                ),
                actions: <Widget>[
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
                        height: 30,
                        width: 70,
                        decoration: const BoxDecoration(
                          color: AppColors.buttonBlue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Allow",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // TextButton(
                  //     child: const Text('Allow'),
                  //     onPressed: () {
                  //       const AndroidIntent intent = AndroidIntent(
                  //           action:
                  //               'android.settings.LOCATION_SOURCE_SETTINGS');
                  //       // Future.delayed(const Duration(seconds: 3));
                  //       intent.launch();
                  //       Navigator.of(context, rootNavigator: true).pop();
                  //
                  //       // _gpsService();
                  //     }),
                ],
              );
            });
      }
    }
    if ((await Geolocator.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        // _getCurrentLocation();
      }
    }
  }

  _getCurrentLocation() {
    locationLoading = true;
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    ).then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
      locationLoading = false;
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.locality}, ${place.subLocality}, ${place.street}";
      });
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
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  void _getStartTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _startTime = formattedDateTime;
    });
  }

  void _subtractTime() {
    var dateFormat = DateFormat('hh:mm');
    var hourDiff;
    var minutes_diff;
    DateTime start = dateFormat.parse(_startTime);
    DateTime finish = dateFormat.parse(_finishTime);
    Duration diff = finish.difference(start);
    print(diff);
    hourDiff = diff.inHours.toString();
    minutes_diff = diff.inMinutes.toString();
    _totalTime = "${hourDiff}h  ${minutes_diff}m";
    print(_totalTime);
  }

  void _getFinishTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _finishTime = formattedDateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var textsize = size.height / size.width;
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            // backgroundColor: Colors.white,
            appBar: const BluTimeAppHeader(
              leadingImage: AppAssets.profilePlaceholder,
              backEnabled: false,
            ),
            body: Stack(
              children: [
                Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.06 * size.height,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '  $_timeString',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.2 * textsize,
                                color: AppColors.buttonBlue,
                              ),
                            ),
                            SizedBox(
                              width: 0.01 * size.width,
                            ),
                            //Changes required
                            Container(
                              padding: const EdgeInsets.all(3),
                              margin: EdgeInsets.only(left: 0.02 * size.width),
                              height: 0.025 * size.height,
                              width: 0.09 * size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 0,
                                    offset: const Offset(
                                        0, 1.5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  DateFormat('a').format(DateTime.now()),
                                  style: TextStyle(
                                      color: const Color(0xff8B8B8B),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 4.9 * textsize),
                                ),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: Text(
                            DateFormat('EEEE, MMM dd').format(today).toString(),
                            style: TextStyle(
                                // fontFeatures: [FontFeature.subscripts()],
                                color: const Color(0xff000000),
                                fontSize: 6.8 * textsize),
                          ),
                        ),
                        SizedBox(
                          height: 0.11 * size.height,
                        ),
                        GestureDetector(
                          onTap: () {
                            _getCurrentLocation();
                            if (_currentAddress == null &&
                                role != "" &&
                                locationLoading == false) {
                              Get.defaultDialog(
                                  title: "Oops !!",
                                  content: const Text(
                                      "Please wait we are getting your current Location"));
                            } else if (role == "" && _currentAddress != null) {
                              Get.defaultDialog(
                                  title: "Oops !!",
                                  content:
                                      const Text("Please Select Your Role"));
                            } else if (_currentAddress != null && role != "") {
                              clockRunning == true
                                  ?
                                  // print(clockRunning);
                                  stopTimer(resets: false)

                                  : startTimer();
                              _startTime == "" ? _getStartTime() : null;

                              // clockRunning = true;
                            } else if (role == "" &&
                                _currentAddress == null &&
                                locationLoading == false) {
                              Get.defaultDialog(
                                  title: "Oops !!",
                                  content: const Text(
                                      "Select your role and let us fetch your current location"));
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.57,
                            // Below is the code for Linear Gradient.
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.9),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                              shape: BoxShape.circle,
                              gradient: timerStatus == false &&
                                      clockRunning || breakRunning== true
                                  ? LinearGradient(
                                      colors: [
                                        AppColors.orange,
                                        AppColors.orange.withOpacity(0.9)
                                      ],
                                      begin: Alignment.bottomLeft,
                                      // end: Alignment.topRight,
                                    )
                                  : LinearGradient(
                                      colors: [
                                        const Color(0xff0062BD),
                                        const Color(0xff002D4B).withOpacity(0.9)
                                      ],
                                      begin: Alignment.bottomLeft,
                                      // end: Alignment.topRight,
                                    ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 0.04 * size.height,
                                ),
                                Image.asset(
                                  'assets/images/Group 137.png',
                                  scale: 3,
                                ),
                                SizedBox(
                                  height: 0.02 * size.height,
                                ),
                                Text(
                                  " ${twoDigits(clockDuration.inHours.remainder(60))}:${twoDigits(clockDuration.inMinutes.remainder(60))}:${twoDigits(clockDuration.inSeconds.remainder(60))}",
                                  // '00:00:00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xffFFFFFF),
                                      fontSize: 10.2 * textsize),
                                ),
                                SizedBox(
                                  height: 0.01 * size.height,
                                ),
                                Text(
                                  timerStatus == false && clockRunning || breakRunning== true
                                      ? 'Finish Work'
                                      : 'Start Work',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xffFFFFFF),
                                      fontSize: 5.5 * textsize),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                clockRunning == true || breakRunning == true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    stopTimer(resets: false);
                                    if (breakRunning == true) {
                                      stopBreak(resets: true);
                                      // breakDuration = const Duration();
                                      startTimer();
                                    } else {
                                      // reset();
                                      startBreak();
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 0.05 * size.height,
                                    width: 0.13 * size.width,
                                    decoration: BoxDecoration(
                                        color: breakRunning == true
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      breakRunning == true
                                          ? "Tap to End"
                                          : "Tap to Start",
                                      style: TextStyle(
                                        fontSize: 6.2 * textsize,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "Break",
                                      style: TextStyle(
                                        fontSize: 9.2 * textsize,
                                        color: breakRunning == true
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
                            visible:
                                clockRunning == false && breakRunning == false,
                            child: Text(
                              isLoading && sliderOpen == false ? "" : role,
                              style: TextStyle(
                                fontSize: 8.2 * textsize,
                                fontWeight: FontWeight.bold,
                                color: AppColors.orange,
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                clockRunning == true ? 0.007 * size.height : 0,
                          ),
                          if (_currentAddress != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0,right: 8),
                              child: Text(
                                _currentAddress.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 0.017 * size.height),
                              ),
                            ),
                          if (_currentAddress == null)
                            Text(
                              locationLoading == true
                                  ? "Loading Address..."
                                  : "Tap Start to get Current Location",
                              style: const TextStyle(color: Colors.black),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: breakRunning == true
                          ? 0.01 * size.height
                          : 0.045 * size.height,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Visibility(
                            visible: breakRunning == false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      AppAssets.startWork,
                                      scale: 3,
                                    ),
                                    SizedBox(
                                      height: 0.01 * size.height,
                                    ),
                                    Text(
                                      _startTime == "" ? '-----' : _startTime,
                                      style: TextStyle(
                                        color: const Color(0xffFF4A00),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 6.5 * textsize,
                                      ),
                                    ),
                                    Text(
                                      'Start Work',
                                      style: TextStyle(
                                          color: const Color(0xff000000),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 5.2 * textsize),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      AppAssets.finishWork,
                                      scale: 2,
                                    ),
                                    SizedBox(
                                      height: 0.01 * size.height,
                                    ),
                                    Text(
                                      _finishTime == "" ? '-----' : _finishTime,
                                      style: TextStyle(
                                          color: const Color(0xffFF4A00),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 6.2 * textsize),
                                    ),
                                    Text(
                                      'Finish Work',
                                      style: TextStyle(
                                          color: const Color(0xff000000),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 5.2 * textsize),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      AppAssets.breakTime,
                                      scale: 3,
                                    ),
                                    SizedBox(
                                      height: 0.01 * size.height,
                                    ),
                                    Text(
                                      _totalTime == "" ? '-----' : _totalTime,
                                      style: TextStyle(
                                          color: const Color(0xffFF4A00),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 6.5 * textsize),
                                    ),
                                    Text(
                                      'Total Work',
                                      style: TextStyle(
                                          color: const Color(0xff000000),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 5.2 * textsize),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: breakRunning == true,
                              child: Container(
                                height: 0.11 * size.height,
                                width: 0.85 * size.width,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 1,
                                      offset: const Offset(
                                          0, 2), // changes position of shadow
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
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            12,
                                          ),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.22),
                                            spreadRadius: 2,
                                            blurRadius: 1,
                                            offset: const Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Break 1",
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                            decoration: const BoxDecoration(
                                              color: AppColors.buttonBlue,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                _startTime,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 6.2 * textsize,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                        Text(
                                          " ${twoDigits(breakDuration.inHours.remainder(60))}:${twoDigits(breakDuration.inMinutes.remainder(60))}:${twoDigits(breakDuration.inSeconds.remainder(60))}",
                                          style: TextStyle(
                                            fontSize: 15.2 * textsize,
                                            color: AppColors.orange,
                                            fontWeight: FontWeight.bold,
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
                                            decoration: const BoxDecoration(
                                              color: AppColors.buttonBlue,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "02:00",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 6.2 * textsize,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0.01 * size.height,
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                )),
                isLoading == true
                    ? Stack(children: [
                        GestureDetector(
                          onTap: () {
                            isLoading = false;
                          },
                          child: Container(
                            height: 1 * size.height,
                            width: 1 * size.width,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        Positioned(
                          top: 0.142 * size.height,
                          left: 0.063 * size.width,
                          child: SizedBox(
                            // color: Color(0xffE4E4E4),
                            width: 0.98 * size.width,
                            height: 0.17 * size.height,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(right: 4, top: 3),
                                  // width: 290,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffE4E4E4),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Column(
                                      //   children: [
                                      //     SizedBox(
                                      //       height: 12,
                                      //     ),
                                      //     // Container(
                                      //     //   height: 180,
                                      //     //   width: 120,
                                      //     //   decoration: BoxDecoration(
                                      //     //     color: const Color(0xff0062BD),
                                      //     //     borderRadius: BorderRadius.all(
                                      //     //         Radius.circular(10)),
                                      //     //   ),
                                      //     // )
                                      //   ],
                                      // ),
                                      SizedBox(
                                        width: 0.01 * size.width,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 0.015 * size.height,
                                          ),
                                          Image.asset(
                                            "assets/images/FZSnPc.png",
                                            height: 0.029 * size.height,
                                          ),
                                          SizedBox(
                                            height: 0.005 * size.height,
                                          ),
                                          RotatedBox(
                                            quarterTurns: 3,
                                            child: Text(
                                              'Select Role  ',
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff000000),
                                                  fontSize: 6 * textsize,
                                                  fontWeight: FontWeight.w500),
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
                                      backgroundColor: const Color(0xff0062BD),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                        ),
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      isLoading = !isLoading;
                                      // onTapSlider();
                                    });
                                  },
                                  child: SizedBox(
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(10.0),),
                                    // padding: const EdgeInsets.only(left: 10),
                                    height: 0.03 * size.height,
                                    // width: 0.05*size.width,
                                    // width: 50,
                                    // color: const Color(0xff0062BD),
                                    // child: Image.asset("assets/images/cuTOBs.png"),
                                    child: isLoading == false
                                        ? const Icon(
                                            Icons.arrow_forward_ios_outlined,
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
                              margin: EdgeInsets.only(top: 0.13 * size.height),
                              // padding: const EdgeInsets.only(top: 105, bottom: 475),
                              decoration: const BoxDecoration(
                                color: Color(0xff0062BD),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    10,
                                  ),
                                ),
                              ),
                              width: 0.35 * size.width,
                              height: 0.19 * size.height,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
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
                                       clockDuration.inSeconds.remainder(60)>0 || clockRunning==true
                                            ? Get.defaultDialog(
                                                title: "Sorry!!",
                                                content: const Text(
                                                    "Cant Switch roles while timer is running"))
                                            : setState(() {
                                                role = "Electrician";
                                                // roleSelected==true;
                                                isLoading = false;

                                                // Get.to(()=>CustomBottomNavigationBar());
                                                // print(role);
                                              });

                                        // setState(() { isLoading == false;});
                                        // print(isLoading);
                                      },
                                      child: Container(
                                        height: 0.04 * size.height,
                                        width: 0.27 * size.width,
                                        decoration: BoxDecoration(
                                          color: role == "Electrician"
                                              ? AppColors.bottomBar
                                              : Colors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                AppAssets.electrician,
                                                scale: 1,
                                                color: role == "Electrician"
                                                    ? Colors.white
                                                    : AppColors.buttonBlue,
                                              ),
                                              Text(
                                                "Electrician",
                                                style: TextStyle(
                                                  color: role == "Electrician"
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 6.2 * textsize,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        clockDuration.inSeconds.remainder(60)>0|| clockRunning == true
                                            ? Get.defaultDialog(
                                                title: "Sorry!!",
                                                content: const Text(
                                                    "Cant Switch roles while timer is running"))
                                            : setState(() {
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

                                                role = "Technician";
                                                isLoading = false;
                                                // print(role);
                                              });
                                      },
                                      child: Container(
                                        height: 0.04 * size.height,
                                        width: 0.27 * size.width,
                                        decoration: BoxDecoration(
                                          color: role == "Technician"
                                              ? AppColors.bottomBar
                                              : Colors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                AppAssets.technician,
                                                scale: 3,
                                                color: role == "Technician"
                                                    ? Colors.white
                                                    : AppColors.buttonBlue,
                                              ),
                                              Text(
                                                "Technician",
                                                style: TextStyle(
                                                    color: role == "Technician"
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 6.2 * textsize),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        clockDuration.inSeconds.remainder(60)>0||clockRunning == true
                                            ? Get.defaultDialog(
                                                title: "Sorry!!",
                                                content: const Text(
                                                    "Cant Switch roles while timer is running"))
                                            : setState(() {
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
                                                role = "Plumber";
                                                isLoading = false;
                                                // print(role);
                                              });
                                      },
                                      child: Container(
                                        height: 0.04 * size.height,
                                        width: 0.27 * size.width,
                                        decoration: BoxDecoration(
                                          color: role == "Plumber"
                                              ? AppColors.bottomBar
                                              : Colors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                AppAssets.plumber,
                                                scale: 3,
                                                color: role == "Plumber"
                                                    ? Colors.white
                                                    : AppColors.buttonBlue,
                                              ),
                                              Text(
                                                "Plumber",
                                                style: TextStyle(
                                                  color: role == "Plumber"
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
                            // color: Color(0xffE4E4E4),
                            width: 0.24 * size.width,
                            height: 0.22 * size.height,
                            // padding: EdgeInsets.only(
                            //     top: 0.15 * size.height, bottom: 0.5 * size.height),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 6, right: 6),
                                  decoration: const BoxDecoration(
                                    color: Color(0xffE4E4E4),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 0.03 * size.height,
                                      ),
                                      Image.asset(
                                        "assets/images/FZSnPc.png",
                                        height: 0.05 * size.height,
                                      ),
                                      RotatedBox(
                                        quarterTurns: 3,
                                        child: Text(
                                          'Select Role  ',
                                          style: TextStyle(
                                              color: const Color(0xff000000),
                                              fontSize: 0.02 * size.height,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                    // ElevatedButton(
                                    //     style: ElevatedButton.styleFrom(
                                    //       backgroundColor: const Color(0xffE4E4E4),
                                    //         shape: const RoundedRectangleBorder(
                                    //           borderRadius: BorderRadius.only(
                                    //             topRight: Radius.circular(30),
                                    //             bottomRight: Radius.circular(30),
                                    //           ),
                                    //         )
                                    //     ),
                                    //     onPressed: () {
                                    //       setState(() {
                                    //         // load=true;
                                    //       });
                                    //     },
                                    //     child: Column(
                                    //       children: [
                                    //         const SizedBox(
                                    //           height: 20,
                                    //         ),
                                    //         Container(
                                    //             child: Image.asset("assets/images/FZSnPc.png")),
                                    //         Container(
                                    //           child: const RotatedBox(
                                    //             quarterTurns: 3,
                                    //             child: Text(
                                    //               'Select Role  ',
                                    //               style: TextStyle(
                                    //                   color: Color(0xff000000),
                                    //                   fontSize: 14,
                                    //                   fontWeight: FontWeight.w500),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     )),
                                    ),
                                Expanded(
                                  child: ElevatedButton(
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
                                      setState(() {
                                        isLoading = !isLoading;
                                        // onTapSlider();
                                      });
                                    },
                                    child: SizedBox(
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(10.0),),
                                      // padding: const EdgeInsets.only(left: 10),
                                      height: 0.06 * size.height,
                                      // width: 50,
                                      // color: const Color(0xff0062BD),
                                      // child: Image.asset("assets/images/cuTOBs.png"),
                                      child: isLoading == false
                                          ? const Center(
                                              child: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: Color(0xffffffff),
                                              ),
                                            )
                                          : const Center(
                                              child: Icon(
                                                Icons.arrow_back_ios_outlined,
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
                        locationLoading == true && _currentAddress == null
                            ? Center(
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
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
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
                                        // crossAxisAlignment: CrossAxisAlignment.,
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
                                                  fontSize: 0.02 * size.height),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const CircularProgressIndicator(color: AppColors.buttonBlue,),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ]),
              ],
            ),
          );
        });
  }
}
