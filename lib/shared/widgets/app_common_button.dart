import 'package:blu_time/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppCommonButton extends StatelessWidget {

  final String title;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final double? fontSize;
  final double radius;
  final Color color;
  final Color textColor;
  final double elevation;
  final bool? isLoading;
  final double borderWidth;
  final Color borderColor;
  final Image? icon;
  const AppCommonButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.height = 50,
    this.width,
    this.fontSize,
    this.radius = 15,
    this.color = AppColors.buttonBlue,
    this.elevation = 2.0,
    this.isLoading,
    this.borderColor = AppColors.buttonBlue,
    this.borderWidth = 1.0,
    this.textColor = Colors.white,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (isLoading ?? false)
        ? const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    )
        : SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          onPressed?.call();
        },
        style: ElevatedButton.styleFrom(
            elevation: elevation, backgroundColor: color,
            side: BorderSide(width: borderWidth, color: borderColor,),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            )
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
              style: TextStyle(color: textColor,fontSize: fontSize,fontWeight: FontWeight.w800),
            ),
            if (icon != null)...[
              const SizedBox(width: 10,),
              icon!
            ]
          ],
        ),
      ),
    );
  }
}