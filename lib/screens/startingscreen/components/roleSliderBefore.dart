import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleSliderBefore extends StatelessWidget {
  const RoleSliderBefore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
    Get.put(StartingScreenController());
    final Size size = MediaQuery.of(context).size;
    return Positioned(
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
    );
  }
}
