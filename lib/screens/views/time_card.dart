import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_strings.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TimeCard extends StatefulWidget {
  const TimeCard({Key? key}) : super(key: key);

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      color: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tue 06 Dec",
                  style: AppTextStyles.bold.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.red),
                    ),
                    child: Text(AppStrings.timeCard_clockedIn,style: AppTextStyles.bold.copyWith(color: Colors.white),),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.timeCard_projectName,
                  style: AppTextStyles.medium,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "Project Sample 1",
                  style: AppTextStyles.bold
                      .copyWith(color: AppColors.orange, fontSize: 20),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Actions",
                    style: AppTextStyles.bold.copyWith(),
                  ),
                  Text.rich(TextSpan(
                      text: "3",
                      style: AppTextStyles.bold
                          .copyWith(fontSize: 20, color: AppColors.orange),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Total',
                          style: AppTextStyles.medium.copyWith(fontSize: 12),
                        )
                      ])),
                  Text.rich(TextSpan(
                      text: "3",
                      style: AppTextStyles.bold
                          .copyWith(fontSize: 20, color: AppColors.orange),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Complete',
                          style: AppTextStyles.medium.copyWith(fontSize: 12),
                        )
                      ])),
                  Text.rich(TextSpan(
                      text: "3",
                      style: AppTextStyles.bold
                          .copyWith(fontSize: 20, color: AppColors.orange),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Remaining',
                          style: AppTextStyles.medium.copyWith(fontSize: 12),
                        )
                      ]))
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "Per Day Total Time",
                  style: AppTextStyles.normal
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "6h 47m",
                  style: AppTextStyles.bold
                      .copyWith(color: AppColors.buttonBlue, fontSize: 20),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
