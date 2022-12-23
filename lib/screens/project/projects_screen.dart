import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/screens/views/project_card.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
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
      appBar: const BluTimeAppHeader(leadingImage: AppAssets.profilePlaceholder,backEnabled: false,),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: GestureDetector(child: const ProjectCard(),onTap: (){
              Navigator.of(context).pushNamed(RouteNames.projectDetailHolder);
            },),
          )
      ),
    );
  }
}
