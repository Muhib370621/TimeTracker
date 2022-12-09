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
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sample Project 1",
                style: AppTextStyles.medium.copyWith(color: Colors.black),
              ),
              Text(
                "8h 0m",
                style: AppTextStyles.medium.copyWith(color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "SAMPLE CUSTOMER 1",
                style: AppTextStyles.medium.copyWith(color: Colors.black),
              ),
              Text(
                "\$140.00",
                style: AppTextStyles.medium.copyWith(color: Colors.black),
              ),
            ],
          ),
          Text(
            "Mon 21 Nov 2022",
            style: AppTextStyles.medium.copyWith(color: Colors.black),
          ),
          Text(
            "Mon 21 Nov 2022",
            style: AppTextStyles.medium.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}


