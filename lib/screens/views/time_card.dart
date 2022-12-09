import 'package:blu_time/constants/app_styles.dart';
import 'package:flutter/material.dart';

class TimeCard extends StatefulWidget {
  const TimeCard({Key? key}) : super(key: key);

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mon 21 Nov 2022",
                    style: AppTextStyles.medium.copyWith(color: Colors.black),
                  ),
                  Text(
                    "FUNNY MAY",
                    style: AppTextStyles.medium.copyWith(color: Colors.black),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor:Colors.blueGrey,
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: const Text("FM",style: AppTextStyles.bold,),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "START",
                    style: AppTextStyles.medium.copyWith(color: Colors.black),
                  ),
                  Text(
                    "17:18",
                    style: AppTextStyles.medium.copyWith(color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "BREAK",
                    style: AppTextStyles.medium.copyWith(color: Colors.black),
                  ),
                  Text(
                    "2m",
                    style: AppTextStyles.medium.copyWith(color: Colors.black),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  color: Colors.greenAccent,
                  padding: const EdgeInsets.all(10),
                  child: Text('CLOCKED IN',style: AppTextStyles.bold.copyWith(color: Colors.white),),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.pin_drop),
                  Text(
                    "GPS",
                    style: AppTextStyles.medium.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
