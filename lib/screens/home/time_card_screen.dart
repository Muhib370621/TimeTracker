import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/screens/views/time_card.dart';
import 'package:flutter/material.dart';

class TimecardScreen extends StatefulWidget {
  const TimecardScreen({Key? key}) : super(key: key);

  @override
  State<TimecardScreen> createState() => _TimecardScreenState();
}

class _TimecardScreenState extends State<TimecardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.listBackground,
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 10,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: TimeCard(),
          )
      ),
    );
  }
}
