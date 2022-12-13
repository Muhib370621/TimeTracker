import 'package:blu_time/screens/views/project_card.dart';
import 'package:blu_time/screens/views/task_card.dart';
import 'package:blu_time/screens/views/time_card.dart';
import 'package:flutter/material.dart';

class PlayGround extends StatefulWidget {
  const PlayGround({Key? key}) : super(key: key);

  @override
  State<PlayGround> createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            TimeCard(),
            ProjectCard(),
            TaskCard(),
            Spacer(),
            Spacer(),
          ],

        ),
      ),
    );
  }
}
