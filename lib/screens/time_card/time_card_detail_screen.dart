import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/screens/views/time_card_detail_card.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:flutter/material.dart';

class TimeCardDetailScreen extends StatefulWidget {
  const TimeCardDetailScreen({Key? key}) : super(key: key);

  @override
  State<TimeCardDetailScreen> createState() => _TimeCardDetailScreenState();
}

class _TimeCardDetailScreenState extends State<TimeCardDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BluTimeAppHeader(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const TimeCardDetailCard(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(onPressed: (){},
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.textFieldBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )
                      ), child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Start Date & Time",style: AppTextStyles.bold.copyWith(fontSize: 16,color: AppColors.buttonBlue)),
                      ),),
                      const SizedBox(width: 10,),
                      Text("12/06/23, 12:00 PM",style: AppTextStyles.medium.copyWith(fontSize: 16,color: Colors.black),)
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(onPressed: (){},
                        style: TextButton.styleFrom(
                            backgroundColor: AppColors.textFieldBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )
                        ), child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text("Start Date & Time",style: AppTextStyles.bold.copyWith(fontSize: 16,color: AppColors.buttonBlue)),
                        ),),
                      const SizedBox(width: 10,),
                      Text("12/06/23, 12:00 PM",style: AppTextStyles.medium.copyWith(fontSize: 16,color: Colors.black),)
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(onPressed: (){},
                        style: TextButton.styleFrom(
                            backgroundColor: AppColors.textFieldBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )
                        ), child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text("Start Date & Time",style: AppTextStyles.bold.copyWith(fontSize: 16,color: AppColors.buttonBlue)),
                        ),),
                      const SizedBox(width: 10,),
                      Text("12/06/23, 12:00 PM",style: AppTextStyles.medium.copyWith(fontSize: 16,color: Colors.black),)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
