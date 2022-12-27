import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:flutter/material.dart';

class ChecklistCard extends StatelessWidget {
  const ChecklistCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.cellBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListTile(
          leading: const Icon(
            Icons.check_circle,
            size: 30,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pick up new through bolt",
                  style: AppTextStyles.bold
                      .copyWith(color: Colors.black, fontSize: 16)),
              const SizedBox(
                height: 3,
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Icon(Icons.calendar_month),
              Text("Task Complete Date here",
                  style: AppTextStyles.normal
                      .copyWith(color: Colors.black, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
