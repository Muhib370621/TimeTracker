import 'dart:math';

import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/models/time_entry.dart';
import 'package:blu_time/shared/extensions.dart';
import 'package:flutter/material.dart';

class TimeCardDetailCard extends StatefulWidget {
  final TimeEntry timeEntry;
  const TimeCardDetailCard({Key? key, required this.timeEntry}) : super(key: key);

  @override
  State<TimeCardDetailCard> createState() => _TimeCardDetailCardState();
}

class _TimeCardDetailCardState extends State<TimeCardDetailCard> {
  int currentBreakIndex = 0;

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
              style: AppTextStyles.normal.copyWith(color: Colors.white, fontSize: 9.width),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Pick Up New Through Bolt",
                    style: AppTextStyles.bold.copyWith(color: AppColors.buttonBlue, fontSize: 13.width),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizedStrings.completed.tr(),
                  style: AppTextStyles.bold.copyWith(color: AppColors.orange, fontSize: 12),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              AppLocalizedStrings.workTime.tr(),
              style: AppTextStyles.normal.copyWith(color: Colors.white, fontSize: 9.width),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizedStrings.startTime.tr(),
                    style: AppTextStyles.bold.copyWith(color: AppColors.buttonBlue, fontSize: 13.width),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.timeEntry.startTimeParsed,
                  style: AppTextStyles.medium.copyWith(color: Colors.white, fontSize: 13.width),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.timeEntry.startDateParsed,
                  style: AppTextStyles.medium.copyWith(color: AppColors.orange, fontSize: 10.width),
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
                    AppLocalizedStrings.finishTime.tr(),
                    style: AppTextStyles.bold.copyWith(color: AppColors.buttonBlue, fontSize: 13.width),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.timeEntry.endTimeParsed,
                  style: AppTextStyles.medium.copyWith(color: Colors.white, fontSize: 13.width),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.timeEntry.endDateParsed,
                  style: AppTextStyles.medium.copyWith(color: AppColors.orange, fontSize: 10.width),
                )
              ],
            ),
            if (widget.timeEntry.breaks?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizedStrings.breakTime.tr(),
                          style: AppTextStyles.normal.copyWith(color: Colors.white, fontSize: 9.width),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          AppLocalizedStrings.startTime.tr(),
                          style: AppTextStyles.bold.copyWith(color: AppColors.buttonBlue, fontSize: 13.width),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          AppLocalizedStrings.endTime.tr(),
                          style: AppTextStyles.bold.copyWith(color: AppColors.buttonBlue, fontSize: 13.width),
                        )
                      ],
                    ),
                    buildBreakWidget(),
                  ],
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Location",
              style: AppTextStyles.normal.copyWith(color: Colors.white, fontSize: 9.width),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Location",
                    style: AppTextStyles.bold.copyWith(color: AppColors.buttonBlue, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.timeEntry.location ?? "",
                  style: AppTextStyles.medium.copyWith(color: Colors.white, fontSize: 13.width),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildBreakWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${AppLocalizedStrings.breakString.tr()} ${currentBreakIndex + 1}",
          style: AppTextStyles.normal.copyWith(color: AppColors.orange, fontSize: 9.width),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const ShapeDecoration(
                      color: AppColors.buttonBlue,
                      shape: CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 13,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      currentBreakIndex = max(currentBreakIndex - 1, 0);
                    });
                  },
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Text(
                      widget.timeEntry.breaks?[currentBreakIndex].startTime ?? "",
                      style: AppTextStyles.medium.copyWith(color: Colors.white, fontSize: 13.width),
                    ),
                    Text(
                      widget.timeEntry.breaks?[currentBreakIndex].endTime ?? "",
                      style: AppTextStyles.medium.copyWith(color: Colors.white, fontSize: 13.width),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const ShapeDecoration(
                      color: AppColors.orange,
                      shape: CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 13,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      currentBreakIndex = min(currentBreakIndex + 1, (widget.timeEntry.breaks?.length ?? 0) - 1);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
