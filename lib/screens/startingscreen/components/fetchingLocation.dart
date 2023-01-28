import 'package:blu_time/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FetchingLocation extends StatelessWidget {
  const FetchingLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(children: [
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
    ]);

  }
}
