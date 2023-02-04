import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:blu_time/models/action_checklist.dart';
import 'package:blu_time/shared/Prompts.dart';
import 'package:blu_time/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:get/get.dart';

import '../../constants/app_storage.dart';
import '../../controllers/bottomNavigationController.dart';
import '../../helpers/locator.dart';
import '../../shared/widgets/custom_bottom_navigation_bar.dart';
import '../../stores/store_services.dart';

class ChecklistCard extends StatelessWidget {
  final ActionChecklist actionChecklist;

  const ChecklistCard({Key? key, required this.actionChecklist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StartingScreenController startController =
        Get.put(StartingScreenController());
    final BottomNavController controller = Get.put(
      BottomNavController(),
    );
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      color: AppColors.cellBackground,
      child: GestureDetector(
        onTap: () async {
          print("completed value ${actionChecklist.completed}");

          if (startController.clockRunning.value == true &&
              controller.checkListItem.value == "") {
            Prompts.confirmationDialog(
                context, "You won't be able to change the activity after selection", () async {
              Navigator.of(context, rootNavigator: true).pop();
              Get.to(
                () => CustomBottomNavigationBar(),
              );
              controller.checkListCounter.value++;
              controller.currentIndex.value = 0;
              controller.checkListItem.value =
                  actionChecklist.title.toString();
              await locator<StoreServices>().setLocal(
                  AppStorage.checkListItemName,
                  "userid",
                  controller.checkListItem.value);
              FlutterBeep.beep();
            });
          }
        },
        child: ListTile(
          dense: true,
          leading: Icon(
            Icons.check_circle,
            color: (actionChecklist.completed ?? false) ? AppColors.buttonBlue : Colors.grey,
            size: 17.height,
          ),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(actionChecklist.title ?? "",
                    style: AppTextStyles.semiBold
                        .copyWith(color: Colors.black, fontSize: 12.width)),
                const SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
          subtitle: Transform.translate(
            offset: const Offset(-16, 0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: AppColors.buttonBlue,
                  size: 15.width,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(actionChecklist.completedDate ?? "N/A",
                    style: AppTextStyles.normal
                        .copyWith(color: Colors.black, fontSize: 10.width)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
