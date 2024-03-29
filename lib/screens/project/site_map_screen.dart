import 'dart:async';

import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SiteMapScreen extends StatefulWidget {
  const SiteMapScreen({Key? key}) : super(key: key);

  @override
  State<SiteMapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<SiteMapScreen>
    with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            GoogleMap(
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.pin_drop),
                            const Text("Location address")
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: MyDeliveryProgress(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class MyDeliveryProgress extends StatefulWidget {
  const MyDeliveryProgress({super.key});

  @override
  StepperState createState() => StepperState();
}

class StepperState extends State<MyDeliveryProgress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Start Time',
                style: AppTextStyles.normal
                    .copyWith(color: Colors.black, fontSize: 11),
              ),
              Text(
                'End Time',
                style: AppTextStyles.normal
                    .copyWith(color: Colors.black, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height:2,),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('9:00',
                  style: AppTextStyles.bold.copyWith(
                      color: AppColors.buttonBlue, fontSize: 13)),
              const SizedBox(width:2,),
              const Expanded(
                child: StepProgressIndicator(
                  totalSteps: 20,
                  currentStep: 6,
                  selectedColor: AppColors.buttonBlue,
                  unselectedColor: Colors.grey,
                  roundedEdges: Radius.circular(10),
                ),
              ),
              const SizedBox(width:2,),
              Text('16:00',
                  style: AppTextStyles.bold.copyWith(
                      color: AppColors.buttonBlue, fontSize: 13)),
            ],
          ),
        ],
      ),
    )));
  }
}

class MyProgressLine extends CustomPainter {
  MyProgressLine({required this.shipped, required this.estDelivery});

  final DateTime shipped;
  final DateTime estDelivery;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    double endPointsRadius = 5.0;
    double width = size.width;

    int totalDays =
        ((estDelivery.millisecondsSinceEpoch - shipped.millisecondsSinceEpoch) /
                86400000)
            .floor();
    int currentDay = ((DateTime.now().millisecondsSinceEpoch -
                shipped.millisecondsSinceEpoch) /
            86400000)
        .floor();
    double stepPerDay = width / totalDays;

    // Draws starting point
    canvas.drawCircle(Offset.zero, endPointsRadius, paint);
    canvas.drawLine(Offset(endPointsRadius, 0.0),
        Offset(endPointsRadius + stepPerDay * currentDay, 0.0), paint);

    // Draws current progress line
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(endPointsRadius + stepPerDay * currentDay, 0.0), 3.0, paint);

    // Draws endpoint
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.grey.withOpacity(0.5);
    canvas.drawLine(Offset(endPointsRadius + stepPerDay * currentDay, 0.0),
        Offset(stepPerDay * totalDays, 0.0), paint);
    canvas.drawCircle(Offset((stepPerDay * totalDays) + endPointsRadius, 0.0),
        endPointsRadius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
