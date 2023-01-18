import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/models/project_action.dart';
import 'package:blu_time/shared/extensions.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/app_storage.dart';
import '../../controllers/BottomNavigationController.dart';
import '../../controllers/startingScreenController.dart';
import '../../helpers/locator.dart';
import '../../stores/store_services.dart';

class ActionCard extends StatefulWidget {
  final ProjectAction projectAction;

  const ActionCard({Key? key, required this.projectAction}) : super(key: key);

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  @override
  Widget build(BuildContext context) {
    final StartingScreenController startController = Get.put(
      StartingScreenController(),
    );
    final BottomNavController controller = Get.put(
      BottomNavController(),
    );
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.cellBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: ListTile(
          title: GestureDetector(
            onTap: () async{
              if (startController.clockRunning.value==true) {
                controller.activityName.value =
                widget.projectAction.custrecordBbBludocsPath!;
                await locator<StoreServices>()
              .setLocal(AppStorage.activityName, "userid",controller.activityName.value);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.projectAction.custrecordBbBludocsPath ?? "",
                  style: AppTextStyles.semiBold.copyWith(
                    color: Colors.black,
                    fontSize: 11.width,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.profilePlaceholder,
                                width: 17.width,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${AppLocalizedStrings.assignedBy.tr()}\n N/A",
                                        style: AppTextStyles.medium.copyWith(
                                            color: Colors.black,
                                            fontSize: 8.width),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.projectAction.created ?? "N/A",
                                        style: AppTextStyles.medium.copyWith(
                                            color: Colors.black,
                                            fontSize: 8.width),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 17.width,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        AppCommonButton(
                          title: AppLocalizedStrings.checklist.tr(),
                          height: 17.width,
                          fontSize: 8.width,
                          radius: 10,
                          onPressed: () async {
                            Navigator.of(context).pushNamed(
                              RouteNames.checklist,
                              arguments: widget.projectAction,
                            );
                            if(startController.clockRunning.value==true && controller.activityName.value=="") {
                              final BottomNavController controller = Get.put(
                                BottomNavController(),
                              );
                              controller.activityName.value =
                              widget.projectAction.custrecordBbBludocsPath!;
                              await locator<StoreServices>()
                            .setLocal(AppStorage.activityName, "userid",controller.activityName.value);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
