import 'package:blu_time/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppCommonTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final Color color;
  final Color textColor;
  final double elevation;
  final bool? isLoading;
  final double borderWidth;
  final Color borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  final String? hintText;
  final Color? hintColor;
  final bool obscureText;
  final TextInputType? textInputType;
  const AppCommonTextField({
    Key? key,
    this.height = 66,
    this.width,
    this.fontSize,
    this.radius = 8,
    this.color = AppColors.buttonCyan,
    this.elevation = 2.0,
    this.isLoading,
    this.borderColor = Colors.white,
    this.borderWidth = 1.0,
    this.textColor = Colors.white,
    this.prefixIcon, this.suffixIcon,
    this.backgroundColor = Colors.transparent,
    this.controller, this.validator, this.hintText, this.hintColor,
    this.obscureText = false,this.textInputType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
       validator: validator,
       controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          prefixIcon: (prefixIcon != null) ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: prefixIcon,
          ) : null,
          suffixIcon: (suffixIcon != null) ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: suffixIcon,
          ) : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: borderWidth, color: borderColor),
            borderRadius: BorderRadius.circular(radius),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: borderWidth, color: borderColor),
            borderRadius: BorderRadius.circular(radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: borderWidth, color: borderColor),
            borderRadius: BorderRadius.circular(radius),
          ),
          filled: true,
          hintStyle: TextStyle(
              color: hintColor ?? AppColors.hintTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 14),
          hintText: hintText,
          fillColor: backgroundColor),
    );
  }



}