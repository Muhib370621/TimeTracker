import 'dart:math';

import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/view_models/clock_view_model.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: ViewModelBuilder<ClockViewModel>.nonReactive(
          viewModelBuilder: () => ClockViewModel(),
          onModelReady: (ClockViewModel model) => model.getLocalProjects(),
          builder: (context, viewModel, child) {
            return Selector<ClockViewModel, Project?>(
                selector: (context, model) => model.currentProject,
                builder: (context, project, child) => DefaultTabController(
                      length: 3,
                      child: NestedScrollView(
                        headerSliverBuilder: (context, value) {
                          return [
                            SliverAppBar(
                              backgroundColor: Colors.white,
                              floating: true,
                              pinned: true,
                              bottom: TabBar(
                                labelColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                indicatorColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                tabs: const [
                                  Tab(
                                    text: "Time",
                                  ),
                                  Tab(text: "Sites"),
                                  Tab(text: "Notes"),
                                ],
                              ),
                              expandedHeight: 200,
                              flexibleSpace: FlexibleSpaceBar(
                                collapseMode: CollapseMode.pin,
                                background: Padding(
                                  padding: const EdgeInsets.only(bottom: 50.0),
                                  child: Container(
                                    height: 100,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: SafeArea(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.blueGrey,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: const Text(
                                                      "FM",
                                                      style: AppTextStyles.bold,
                                                    ),
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Container(
                                                    color: Colors.greenAccent,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(
                                                      'CLOCKED IN',
                                                      style: AppTextStyles.bold
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.more_vert,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                            Text(
                                              viewModel.calculateElapsedTime(),
                                              style: AppTextStyles.bold
                                                  .copyWith(fontSize: 50),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Spacer(),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Container(
                                                    color: Colors.greenAccent,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(
                                                      'START BREAK',
                                                      style: AppTextStyles.bold
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Container(
                                                    color: Colors.greenAccent,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(
                                                      'FINISH WORK',
                                                      style: AppTextStyles.bold
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ), // This is where you build the profile part
                              ),
                            ),
                          ];
                        },
                        body: TabBarView(
                          children: [
                            TimeScreen(project: project,onTap: (){
                              viewModel.selectRandomProject();
                            },),
                            Center(child: Text("Tab 1")),
                            Center(child: Text("Tab 1")),
                          ],
                        ),
                      ),
                    ));
          }),
    );
  }
}

class TimeScreen extends StatelessWidget {
   const TimeScreen({
    Key? key, required this.project, this.onTap,
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
              Text("Projects",style: AppTextStyles.bold.copyWith(color: Colors.black),),
              SizedBox(width: 10,),
              Text(project?.name ?? ""),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
        ListTile(
          title: Row(
            children: [
              Text("Start",style: AppTextStyles.bold.copyWith(color: Colors.black),),
              SizedBox(width: 10,),
              Text(project?.startDateTime ?? ""),
            ],
          ),
        )
      ],
    );
  }
}
