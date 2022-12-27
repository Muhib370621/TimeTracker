import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/screens/views/checklist_card.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:flutter/material.dart';

class CheckListScreen extends StatelessWidget {
  const CheckListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BluTimeAppHeader(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Action",
              style: AppTextStyles.bold
                  .copyWith(color: AppColors.buttonBlue, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) => GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const ChecklistCard(),
                        ),
                        onTap: () {},
                      )),
            )
          ],
        ),
      ),
    );
  }
}
