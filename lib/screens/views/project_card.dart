import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/models/project.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.cellBackground,
      child: ListTile(
        title: Row(
          children: [
            Image.asset(AppAssets.projectIcon),
            const SizedBox(width: 12,),
            Flexible(child: Text(project.altname?? "",style: AppTextStyles.bold.copyWith(color: Colors.black,fontSize: 13))),
          ],
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: AppColors.buttonBlue,
            borderRadius: BorderRadius.circular(4.0)
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
          ),
        ),
      ),
    );
  }
}
