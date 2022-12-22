import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:flutter/material.dart';

class BluTimeAppHeader extends StatelessWidget implements PreferredSizeWidget {
   final String leadingImage;
   final bool backEnabled;
   const BluTimeAppHeader({
    Key? key, this.leadingImage = AppAssets.back, this.backEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon:  Image.asset(leadingImage), // Put icon of your preference.
            onPressed: () {
              if (backEnabled) {
                Navigator.of(context).pop();
              }
            },
          );
        },
      ),
      title: Text.rich(
        TextSpan(
            text: "blu ",
            style: AppTextStyles.bold
                .copyWith(fontSize: 20, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: 'Time',
                style: AppTextStyles.medium
                    .copyWith(fontSize: 20, color: Colors.black),
              )
            ]),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize {
    return AppBar().preferredSize;
  }
}