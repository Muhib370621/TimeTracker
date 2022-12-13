import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/screens/views/project_card.dart';
import 'package:flutter/material.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.listBackground,
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: ProjectCard(),
          )
      ),
    );
  }
}
