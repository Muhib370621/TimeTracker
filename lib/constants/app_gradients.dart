import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppGradients {
  AppGradients._();

 // static const login = RadialGradient(colors: [AppColors.gradientTop, AppColors.gradientBottom], center: Alignment.center);
  static const LinearGradient login =  LinearGradient(colors: [ AppColors.gradientBottom,AppColors.gradientTop],begin: Alignment.bottomLeft,end: Alignment.topRight );
  static  LinearGradient loginTop =  LinearGradient(colors: [ AppColors.gradientUpperBottom,AppColors.gradientUpperTop ],begin: Alignment.topLeft,end: Alignment.bottomRight );
  //static const login = LinearGradient(colors: [ AppColors.gradientBottom,AppColors.gradientBottom,AppColors.gradientTop,],begin: Alignment.bottomLeft,end: Alignment.topRight );
}