import 'package:blu_time/constants/app_styles.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({Key? key}) : super(key: key);

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
            "Mon 21 Nov 2022",
            style: AppTextStyles.medium.copyWith(color: Colors.black),
          ),
          Text(
            "Mon 21 Nov 2022",
            style: AppTextStyles.medium.copyWith(color: Colors.black),
          ),
          Text(
            "Mon 21 Nov 2022",
            style: AppTextStyles.medium.copyWith(color: Colors.black),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            clipBehavior: Clip.hardEdge,
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(10),
              child: Text('HIGH',style: AppTextStyles.bold.copyWith(color: Colors.white),),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            clipBehavior: Clip.hardEdge,
            child: Container(
              color: Colors.yellow,
              padding: const EdgeInsets.all(10),
              child: Text('REPAIR',style: AppTextStyles.bold.copyWith(color: Colors.white),),
            ),
          ),
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
                      Text(
                        "22",
                        style: AppTextStyles.medium.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Row(
                    children: [
                      Icon(Icons.message),
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
