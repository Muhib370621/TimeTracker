import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BluTimeAppHeader(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextField(
                minLines: 7,
                maxLines: 7,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                  hintText: "${AppLocalizedStrings.writeNote.tr()}...",
                  hintStyle: AppTextStyles.normal.copyWith(color: Colors.grey)
                ),
              ),
            ),
            const SizedBox(height: 25,),
            DottedBorder(
              color: AppColors.buttonBlue,
              strokeWidth: 3,
              dashPattern: const [15,8],
              borderType: BorderType.RRect,
              radius:const Radius.circular(20),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.buttonBlue.withAlpha(20),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.addImage,width: 92,),
                      Text(AppLocalizedStrings.addImages.tr(),style: AppTextStyles.bold.copyWith(color: AppColors.buttonBlue,fontSize: 18),)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25,),
             AppCommonButton(title:AppLocalizedStrings.addNote.tr(),radius: 10,height: 40),

          ],
        ),
      ),
    );
  }
}
