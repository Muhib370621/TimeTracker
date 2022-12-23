import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatefulWidget {
  const ActionCard({Key? key}) : super(key: key);

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.cellBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pick up new through bolt",
                        style: AppTextStyles.bold
                            .copyWith(color: Colors.black, fontSize: 15)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset(AppAssets.profilePlaceholder),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text("Assign by sample w.",
                                      style: AppTextStyles.medium.copyWith(
                                          color: Colors.black, fontSize: 11))),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: Text("12/06/23, 09:43",
                                      style: AppTextStyles.medium.copyWith(
                                          color: Colors.black, fontSize: 11))),
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
                children: const [
                  Icon(Icons.check_circle,size: 30,),
                  SizedBox(
                    width: 5,
                  ),
                  AppCommonButton(title: "Checklist",height: 30,radius: 10,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
