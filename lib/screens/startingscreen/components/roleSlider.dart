import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleSliderAfter extends StatelessWidget {
  const RoleSliderAfter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final StartingScreenController controller =
        Get.put(StartingScreenController());
    return Positioned(
      top: 0.142 * size.height,
      left: 0.094 * size.width,
      child: SizedBox(
        width: size.width,
        height: 0.22 * size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 4, top: 3),
              decoration: const BoxDecoration(
                color: Color(0xffE4E4E4),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 0.01 * size.width,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 0.01 * size.height,
                      ),
                      Image.asset(
                        "assets/images/FZSnPc.png",
                        scale: 3,
                      ),
                      SizedBox(
                        height: 0.01 * size.height,
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          AppLocalizedStrings.selectRole.tr(),
                          style: TextStyle(
                            color: const Color(0xff000000),
                            fontSize: 0.0215 * size.height,
                            fontWeight: FontWeight.w600,
                          ),
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
                controller.isLoading.value = !controller.isLoading.value;
              },
              child: SizedBox(
                height: 0.03 * size.height,
                child: controller.isLoading.value == false
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
    );
  }
}
