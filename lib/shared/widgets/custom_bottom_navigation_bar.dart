import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int index;
  final Function(int) onTap;
  const CustomBottomNavigationBar(
      {Key? key, required this.index, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onTap,
      iconSize: 24,
      selectedItemColor: AppColors.background,
      unselectedItemColor: AppColors.timerColor,
      selectedLabelStyle: AppTextStyles.semiBold.copyWith(fontSize: 12),
      unselectedLabelStyle: AppTextStyles.semiBold.copyWith(fontSize: 12),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          label: "Clock",
          icon: Icon(
            Icons.watch_later_outlined,
            size: 24,
          ),
          activeIcon: Icon(
            Icons.watch_later_outlined,
            size: 24,
            color: AppColors.background,
          ),
        ),
        BottomNavigationBarItem(
          label: "Time Cards",
          icon: Icon(
            Icons.list_alt,
            size: 24,
          ),
          activeIcon: Icon(
            Icons.list_alt,
            size: 24,
            color: AppColors.background,
          ),
        ),
        BottomNavigationBarItem(
          label: "Tasks",
          icon: Icon(
            Icons.watch_later_outlined,
            size: 24,
          ),
          activeIcon: Icon(
            Icons.watch_later_outlined,
            size: 24,
            color: AppColors.background,
          ),
        ),
        BottomNavigationBarItem(
          label: "Projects",
          icon: Icon(
            Icons.watch_later_outlined,
            size: 24,
          ),
          activeIcon: Icon(
            Icons.watch_later_outlined,
            size: 24,
            color: AppColors.background,
          ),
        ),
      ],
    );
  }
}
