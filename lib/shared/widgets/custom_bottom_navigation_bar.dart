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
      backgroundColor: AppColors.bottomBar,
      onTap: onTap,
      iconSize: 24,
      selectedItemColor: AppColors.background,
      unselectedItemColor: AppColors.timerColor,
      selectedLabelStyle: AppTextStyles.semiBold.copyWith(fontSize: 12),
      unselectedLabelStyle: AppTextStyles.semiBold.copyWith(fontSize: 12),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          label: "Clock",
          icon: Image.asset("assets/images/clock.png", height: 20),
          activeIcon: Icon(
            Icons.watch_later,
            size: 24,
            color: AppColors.background,
          ),
        ),
        BottomNavigationBarItem(
          label: "Time Cards",
          icon: Image.asset("assets/images/timecard.png", height: 20),
          activeIcon: const Icon(
            Icons.list_alt_outlined,
            size: 24,
            color: AppColors.background,
          ),
        ),
        BottomNavigationBarItem(
          label: "Tasks",
          icon: Image.asset("assets/images/task.png", height: 20),

          activeIcon: Icon(
            Icons.task_sharp,
            size: 24,
            color: AppColors.background,
          ),
        ),
        BottomNavigationBarItem(
          label: "Chat",
          icon: Image.asset("assets/images/chat.png", height: 20),
          activeIcon: const Icon(
            Icons.on_device_training,
            size: 24,
            color: AppColors.background,
          ),
        ),
      ],
    );
  }
}
