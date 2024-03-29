import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:flutter/material.dart';

class BluTimeAppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String leadingImage;
  final bool backEnabled;
  final Widget? title;
  final bool centerTitle;
  final double elevation;
  final Color backgroundColor;
  final Color themeColor;
  const BluTimeAppHeader({
    Key? key,
    this.leadingImage = AppAssets.back,
    this.backEnabled = true,
    this.title,
    this.centerTitle = true,
    this.elevation = 4.0, this.backgroundColor = Colors.white, this.themeColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: backgroundColor,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Image.asset(leadingImage), // Put icon of your preference.
            onPressed: () {
              if (backEnabled) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pushNamed(RouteNames.profile);
              }
            },
          );
        },
      ),
      title: (title == null)
          ? Text.rich(
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
            )
          : title,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(40);

      // AppBar().preferredSize;
  }
}
