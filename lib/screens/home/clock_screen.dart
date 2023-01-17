import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/screens/home/home_screen.dart';
import 'package:blu_time/screens/project/site_map_screen.dart';
import 'package:blu_time/view_models/clock_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClockViewModel>.nonReactive(
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
                      TimeScreen(
                        project: project,
                        onTap: () {
                          viewModel.selectRandomProject();
                        },
                      ),
                    //  const SiteMapScreen(),
                      const Center(child: Text("Tab 1")),
                    ],
                  ),
                ),
              )
          );
        });
  }
}
