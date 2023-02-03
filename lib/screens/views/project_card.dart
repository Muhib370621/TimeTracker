import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:blu_time/models/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StartingScreenController controller =
    Get.put(StartingScreenController());
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      color: controller.isNear.value==true?AppColors.buttonBlue:AppColors.cellBackground,
      child: ListTile(
        title: Row(
          children: [
            SvgPicture.asset(AppAssets.projectIcon,color: controller.isNear.value==true?AppColors.cellBackground:AppColors.buttonBlue,),
            const SizedBox(width: 12,),
            Flexible(child: Text(project.title?? "",style: AppTextStyles.semiBold.copyWith(color: controller.isNear.value==true?AppColors.cellBackground:Colors.black,fontSize: 12))),
          ],
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: controller.isNear.value==true?AppColors.cellBackground:AppColors.buttonBlue,
            borderRadius: BorderRadius.circular(2.0)
          ),
          child:  Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Icon(Icons.arrow_forward_ios,color: controller.isNear.value==true?AppColors.buttonBlue:Colors.white,),
          ),
        ),
      ),
    );
  }
}
