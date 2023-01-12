import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/models/action_checklist.dart';
import 'package:blu_time/shared/extensions.dart';
import 'package:flutter/material.dart';

class ChecklistCard extends StatelessWidget {
  final ActionChecklist actionChecklist;
  const ChecklistCard({Key? key, required this.actionChecklist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.cellBackground,
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
            Text("Task Complete Date here",
                style: AppTextStyles.normal
                    .copyWith(color: Colors.black, fontSize: 10.width)),
          ],
        ),
      ),
    );
  }
}
