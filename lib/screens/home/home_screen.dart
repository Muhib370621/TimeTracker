import 'dart:math';

import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/screens/StartingScreen/starting_screen.dart';
import 'package:blu_time/screens/home/clock_screen.dart';
import 'package:blu_time/screens/project/projects_screen.dart';
import 'package:blu_time/screens/home/tasks_screen.dart';
import 'package:blu_time/screens/time_card/time_card_screen.dart';
import 'package:blu_time/screens/views/time_card.dart';
import 'package:blu_time/shared/routes/route_factories.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:blu_time/view_models/clock_view_model.dart';
import 'package:blu_time/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: CustomBottomNavigationBar(
              index: viewModel.selectedIndex,
              onTap: viewModel.onTapItem,
            ),
            body: bodyTab(viewModel),
          );
        });
  }

  Widget bodyTab(HomeViewModel viewModel) {
    return IndexedStack(
      index: viewModel.selectedIndex,
      children: [
        Navigator(
          key: RouteFactories.clockKey,
          onGenerateRoute: RouteFactories.generateRoute,
          initialRoute: RouteNames.clock,
          onGenerateInitialRoutes: (navigator,initialRoute) => [
            MaterialPageRoute(builder: (context) => const StartingScreen())
          ],
        ),
        Navigator(
          key: RouteFactories.timeCardKey,
          onGenerateRoute: RouteFactories.generateRoute,
          initialRoute: RouteNames.timeCard,
          onGenerateInitialRoutes: (navigator,initialRoute) => [
            MaterialPageRoute(builder: (context) => const TimeCardScreen())
          ],
        ),
        Navigator(
          key: RouteFactories.projectsKey,
          onGenerateRoute: RouteFactories.generateRoute,
          initialRoute: RouteNames.project,
          onGenerateInitialRoutes: (navigator,initialRoute) => [
            MaterialPageRoute(builder: (context) => const ProjectsScreen())
          ],
        ),
        Navigator(
          key: RouteFactories.tasksKey,
          onGenerateRoute: RouteFactories.generateRoute,
          initialRoute: RouteNames.task,
          onGenerateInitialRoutes: (navigator,initialRoute) => [
            MaterialPageRoute(builder: (context) => const TasksScreen())
          ],
        ),
      ],
    );
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
              SizedBox(
                width: 10,
              ),
              Text(project?.altname ?? ""),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
        ListTile(
          title: Row(
            children: [
              Text(
                "Start",
                style: AppTextStyles.bold.copyWith(color: Colors.black),
              ),
              SizedBox(
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
