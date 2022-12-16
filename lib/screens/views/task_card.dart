import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/models/project.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({Key? key, required this.task}) : super(key: key);
  final Tasks task;
  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.task.startDateTime} - ${widget.task.endDateTime}",
            style: AppTextStyles.medium.copyWith(color: Colors.black),
          ),
          Text(
            widget.task.taskDescription ?? "",
            style: AppTextStyles.medium.copyWith(color: Colors.black),
          ),
          Text(
            "Address",
            style: AppTextStyles.medium.copyWith(color: Colors.black),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            clipBehavior: Clip.hardEdge,
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(5),
              child: Text('HIGH',style: AppTextStyles.bold.copyWith(color: Colors.white),),
            ),
          ),
          const SizedBox(height: 5,),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            clipBehavior: Clip.hardEdge,
            child: Container(
              color: Colors.yellow,
              padding: const EdgeInsets.all(5),
              child: Text('REPAIR',style: AppTextStyles.bold.copyWith(color: Colors.white),),
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor:Colors.blueGrey,
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: const Text("FM",style: AppTextStyles.bold,),
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.checklist),
                      const SizedBox(width: 5,),
                      Text(
                        "22",
                        style: AppTextStyles.medium.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10,),
                  Row(
                    children: [
                      const Icon(Icons.message),
                      const SizedBox(width: 5,),
                      Text(
                        "1",
                        style: AppTextStyles.medium.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
