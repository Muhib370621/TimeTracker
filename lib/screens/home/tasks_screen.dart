import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/screens/views/task_card.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.listBackground,
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: TaskCard(),
          )
      ),
    );
  }
}
