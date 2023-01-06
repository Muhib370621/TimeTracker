import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  CustomBottomNavigationBar();
      // ViewModelBuilder<HomeViewModel>.reactive(
      //   viewModelBuilder: () => HomeViewModel(),
      //   builder: (context, viewModel, child) {
      //     return Scaffold(
      //       backgroundColor: Colors.white,
      //       bottomNavigationBar: PreferredSize(
      //         preferredSize: const Size.fromHeight(10),
      //         child: CustomBottomNavigationBar(
      //           index: viewModel.selectedIndex,
      //           onTap: viewModel.onTapItem,
      //         ),
      //       ),
      //       body: bodyTab(viewModel),
      //     );
      //   });
  }
}

class TimeScreen extends StatelessWidget {
  const TimeScreen({
    Key? key,
    required this.project,
    this.onTap,
  }) : super(key: key);

  final Project? project;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Text(
                "Projects",
                style: AppTextStyles.bold.copyWith(color: Colors.black),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(project?.altname ?? ""),
            ],
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
        ListTile(
          title: Row(
            children: [
              Text(
                "Start",
                style: AppTextStyles.bold.copyWith(color: Colors.black),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(project?.startdate ?? ""),
            ],
          ),
        )
      ],
    );
  }
}
