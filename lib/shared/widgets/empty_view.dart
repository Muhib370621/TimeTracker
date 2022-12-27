import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            "No Projects available",
            style: AppTextStyles.bold
                .copyWith(color: AppColors.buttonBlue, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}