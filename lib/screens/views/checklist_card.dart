import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:blu_time/models/action_checklist.dart';
import 'package:blu_time/shared/Prompts.dart';
import 'package:blu_time/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_storage.dart';
import '../../controllers/BottomNavigationController.dart';
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
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.cellBackground,
      child: GestureDetector(
        onTap: () async {
          if (startController.clockRunning.value==true && controller.checkListItem.value==""){
          Get.to(
                () => CustomBottomNavigationBar(),
          );
          // Get.reset();
          controller.currentIndex.value = 0;
          controller.checkListItem.value= actionChecklist.custrecordBbPachklistTitle.toString();
          await locator<StoreServices>()
          .setLocal(AppStorage.checkListItemName, "userid",controller.checkListItem.value);
          }
        },
        child: ListTile(
          dense: true,
          leading: Icon(
            Icons.check_circle,
            size: 17.height,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(actionChecklist.custrecordBbPachklistTitle ?? "",
                  style: AppTextStyles.semiBold
                      .copyWith(color: Colors.black, fontSize: 12.width)),
              const SizedBox(
                height: 3,
              ),
            ],
          ),
          subtitle: Row(
            children: [
               Icon(Icons.calendar_month,color: AppColors.buttonBlue,size: 15.width,),
              const SizedBox(width: 5,),
              Text(actionChecklist.lastmodified ?? "N/A",
                  style: AppTextStyles.normal
                      .copyWith(color: Colors.black, fontSize: 10.width)),
            ],
          ),
        ),
      ),
    );
  }
}
