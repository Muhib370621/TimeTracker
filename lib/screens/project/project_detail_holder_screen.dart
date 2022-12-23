import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:flutter/material.dart';

class ProjectDetailHolderScreen extends StatefulWidget {
  const ProjectDetailHolderScreen({Key? key}) : super(key: key);

  @override
  State<ProjectDetailHolderScreen> createState() => _ProjectDetailHolderScreenState();
}

class _ProjectDetailHolderScreenState extends State<ProjectDetailHolderScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: BluTimeAppHeader(),
      body: Container(),
    );
  }
}
