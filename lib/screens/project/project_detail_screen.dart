import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:flutter/material.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: BluTimeAppHeader(),
      body: Container(),
    );
  }
}
