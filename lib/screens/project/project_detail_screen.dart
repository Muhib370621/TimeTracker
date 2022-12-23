import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/screens/views/action_card.dart';
import 'package:blu_time/screens/views/project_card.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:flutter/material.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Details",
              style: AppTextStyles.bold
                  .copyWith(color: AppColors.buttonBlue, fontSize: 16),
            ),
            const SizedBox(height: 10,),
            Card(
              elevation: 5.0,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Start Time",
                          style: AppTextStyles.bold
                              .copyWith(color: AppColors.buttonBlue, fontSize: 18),
                        ),

                        Row(
                          children: [
                            Text("Dec 06 2023",
                                style: AppTextStyles.medium
                                    .copyWith(color: Colors.grey, fontSize: 18)),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("09:00 AM",style: AppTextStyles.semiBold
                                .copyWith(color: AppColors.buttonBlue, fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Finish Time",
                          style: AppTextStyles.bold
                              .copyWith(color: AppColors.buttonBlue, fontSize: 18),
                        ),

                        Row(
                          children: [
                            Text("Dec 06 2023",
                                style: AppTextStyles.medium
                                    .copyWith(color: Colors.grey, fontSize: 18)),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("09:00 AM",style: AppTextStyles.semiBold
                                .copyWith(color: AppColors.buttonBlue, fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Location",
                          style: AppTextStyles.bold
                              .copyWith(color: AppColors.buttonBlue, fontSize: 18),
                        ),

                        Row(
                          children: [
                            Text("Dec 06 2023",
                                style: AppTextStyles.medium
                                    .copyWith(color: Colors.grey, fontSize: 18)),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("09:00 AM",style: AppTextStyles.semiBold
                                .copyWith(color: AppColors.buttonBlue, fontSize: 15)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40,),
            Text(
              "Action",
              style: AppTextStyles.bold
                  .copyWith(color: AppColors.buttonBlue, fontSize: 16),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) => Container(
                    child: GestureDetector(child: const ActionCard(),onTap: (){
                      Navigator.of(context).pushNamed(RouteNames.projectDetail);
                    },),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
