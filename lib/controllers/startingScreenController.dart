import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class StartingScreenController extends GetxController {
  @override
  void onInit() {
    // _gpsService(context);
    // TODO: implement initState
    // setState(() {
    isLoading.value = false;
    _timeString.value = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    locationLoading.value = true;
    // determinePosition();
    _getCurrentLocation();
    locationLoading.value = false;
    // });
    // if(_gpsService()==true){
    //
    // };
    // _checkPermission();
    super.onInit();
  }
  // var context;
  final RxString _currentAddress = "".obs;
  RxString role = "".obs;
  RxBool isLoading = false.obs;
  RxBool sliderOpen = true.obs;
  RxBool locationLoading = false.obs;
  final Rx<Position> _currentPosition = const Position(
    longitude: 0,
    latitude: 0,
    timestamp: null,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  ).obs;

  // DateTime dateTime.obs;
  final RxString _timeString = ''.obs;
  // RxBool GPS = false.obs;
  Rx<DateTime> today = DateTime.now().toLocal().obs;

  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }

  /*Check if gps service is enabled or not*/
  Future _gpsService(context) async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      _checkGps(context);
      return true;
    }
  }

  Future _checkGps(context) async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Can't get current location",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                content:
                    const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        const AndroidIntent intent = AndroidIntent(
                            action:
                                'android.settings.LOCATION_SOURCE_SETTINGS');
                        // Future.delayed(const Duration(seconds: 3));
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                        _gpsService(context);
                      })
                ],
              );
            });
      }
    }
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      // setState(() {
      _currentPosition.value = position;
      _getAddressFromLatLng();
      // });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.value.latitude, _currentPosition.value.longitude);
      Placemark place = placemarks[0];
      // setState(() {
      _currentAddress.value =
          "${place.locality}, ${place.subLocality}, ${place.street}";
      // });
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
    _timeString.value = formattedDateTime;
    // });
  }
}
