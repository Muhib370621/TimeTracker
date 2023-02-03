import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/models/time_entry.dart';
import 'package:blu_time/shared/extensions.dart';
import 'package:flutter/material.dart';

class TimeCard extends StatelessWidget {
  final TimeEntry timeEntry;
  const TimeCard({Key? key, required this.timeEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      color: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
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
                  timeEntry.trandate ?? "N/A",
                  style: AppTextStyles.semiBold.copyWith(fontSize: 15.width),
                ),
                SizedBox(
                  height: 30,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.red),
                    ),
                    child: Text(timeEntry.type ?? "",style: AppTextStyles.semiBold.copyWith(color: Colors.white,fontSize: 10.width),),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 AppLocalizedStrings.timeCardProjectName.tr(),
                  style: AppTextStyles.medium.copyWith(fontSize: 10.width),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  timeEntry.displayfield ?? "",
                  style: AppTextStyles.bold
                      .copyWith(color: AppColors.orange, fontSize: 15.width),
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
                    AppLocalizedStrings.action.tr(),
                    style: AppTextStyles.semiBold.copyWith(fontSize: 10.width),
                  ),
                  Text.rich(TextSpan(
                      text: '${timeEntry.actionsCount ?? 0}',
                      style: AppTextStyles.bold
                          .copyWith(fontSize: 18.width, color: AppColors.orange),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${AppLocalizedStrings.total.tr()}',
                          style: AppTextStyles.medium.copyWith(fontSize: 9.width),
                        )
                      ])),
                  Text.rich(TextSpan(
                      text:'${timeEntry.completeCount ?? 0}',
                      style:AppTextStyles.bold
                          .copyWith(fontSize: 18.width, color: AppColors.orange),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${AppLocalizedStrings.complete.tr()}',
                          style: AppTextStyles.medium.copyWith(fontSize: 9.width),
                        )
                      ])),
                  Text.rich(TextSpan(
                      text: '${timeEntry.remainingCount ?? 0}',
                      style:AppTextStyles.bold
                          .copyWith(fontSize: 18.width, color: AppColors.orange),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${AppLocalizedStrings.remaining.tr()}',
                          style: AppTextStyles.medium.copyWith(fontSize: 9.width),
                        )
                      ]))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    AppLocalizedStrings.perDayTime.tr(),
                    style: AppTextStyles.normal
                        .copyWith(color: Colors.white, fontSize: 11.width),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  (double.parse(timeEntry.hours ?? "0.0")).convertDecimalHours(),
                  style: AppTextStyles.bold
                      .copyWith(color: AppColors.buttonBlue, fontSize: 16.width),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
