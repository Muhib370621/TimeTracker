import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({Key? key}) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.cellBackground,
      child: ListTile(
       // leading: Image.asset(AppAssets.projectIcon),
        title: Row(
          children: [
            Image.asset(AppAssets.projectIcon),
            SizedBox(width: 12,),
            Text("Sample Project 1",style: AppTextStyles.bold.copyWith(color: Colors.black,fontSize: 13)),
          ],
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: AppColors.buttonBlue,
            borderRadius: BorderRadius.circular(4.0)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
          ),
        ),
      ),
    );
  }
}
