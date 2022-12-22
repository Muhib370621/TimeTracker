import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_strings.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TimeCardDetailCard extends StatefulWidget {
  const TimeCardDetailCard({Key? key}) : super(key: key);

  @override
  State<TimeCardDetailCard> createState() => _TimeCardDetailCardState();
}

class _TimeCardDetailCardState extends State<TimeCardDetailCard> {
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
            Text(
              "Action",
              style: AppTextStyles.normal
                  .copyWith(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Pick Up New Through Bolt",
                    style: AppTextStyles.bold
                        .copyWith(color: AppColors.buttonBlue, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Completed",
                  style: AppTextStyles.bold
                      .copyWith(color: AppColors.orange, fontSize: 12),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Work Time",
              style: AppTextStyles.normal
                  .copyWith(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Start Time",
                    style: AppTextStyles.bold
                        .copyWith(color: AppColors.buttonBlue, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "12:00 PM",
                  style: AppTextStyles.medium
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "12:00 PM",
                  style: AppTextStyles.bold
                      .copyWith(color: AppColors.orange, fontSize: 12),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Finish Time",
                    style: AppTextStyles.bold
                        .copyWith(color: AppColors.buttonBlue, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "12:00 PM",
                  style: AppTextStyles.medium
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "12:00 PM",
                  style: AppTextStyles.bold
                      .copyWith(color: AppColors.orange, fontSize: 12),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Break Time",
                      style: AppTextStyles.normal
                          .copyWith(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Start Time",
                      style: AppTextStyles.bold
                          .copyWith(color: AppColors.buttonBlue, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "End Time",
                      style: AppTextStyles.bold
                          .copyWith(color: AppColors.buttonBlue, fontSize: 16),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Break 1",
                      style: AppTextStyles.normal
                          .copyWith(color: AppColors.orange, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const ShapeDecoration(
                                color: AppColors.buttonBlue,
                                shape: CircleBorder(),
                              ),
                              child: Icon(Icons.arrow_back_ios_new_outlined,size: 20,),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: [
                                Text(
                                  "12:00 PM",
                                  style: AppTextStyles.medium.copyWith(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Text(
                                  "12:00 PM",
                                  style: AppTextStyles.medium.copyWith(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const ShapeDecoration(
                                color: AppColors.orange,
                                shape: CircleBorder(),
                              ),
                              child: Icon(Icons.arrow_forward_ios,size: 20,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Location",
              style: AppTextStyles.normal
                  .copyWith(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Location",
                    style: AppTextStyles.bold
                        .copyWith(color: AppColors.buttonBlue, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Project Location Here",
                  style: AppTextStyles.medium
                      .copyWith(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
