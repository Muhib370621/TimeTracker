import 'dart:math';

import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/view_models/clock_view_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double get randHeight => Random().nextInt(100).toDouble();


  List<Widget>? _randomChildren = [];

  // Children with random heights - You can build your widgets of unknown heights here
  // I'm just passing the context in case if any widgets built here needs  access to context based data like Theme or MediaQuery
  List<Widget> _randomHeightWidgets(BuildContext context) {
    _randomChildren ??= List.generate(3, (index) {
      final height = randHeight.clamp(
        50.0,
        MediaQuery.of(context)
            .size
            .width, // simply using MediaQuery to demonstrate usage of context
      );
      return Container(
        color: Colors.primaries[index],
        height: height,
        child: Text('Random Height Child ${index + 1}'),
      );
    });

    return _randomChildren ?? [];
  }

  @override
  void initState() {
    // TODO: implement initState
     loadProjects();
    super.initState();
  }

  loadProjects() async {

    //ProjectResponse projects = await ClockViewModel().getProjects<ProjectResponse>();
  //debugPrint(projects.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                floating: true,
                pinned: true,
                bottom: TabBar(
                  labelColor: Theme.of(context).scaffoldBackgroundColor,
                  indicatorColor: Theme.of(context).scaffoldBackgroundColor,
                  tabs: const [
                    Tab(text: "Posts",
                    ),
                    Tab(text: "Likes"),
                    Tab(text: "Likes"),
                  ],
                ),
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Container(
                      height: 100,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child:  SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:Colors.blueGrey,
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Text("FM",style: AppTextStyles.bold,),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    clipBehavior: Clip.hardEdge,
                                    child: Container(
                                      color: Colors.greenAccent,
                                      padding: const EdgeInsets.all(5),
                                      child: Text('CLOCKED IN',style: AppTextStyles.bold.copyWith(color: Colors.white),),
                                    ),
                                  ),
                                  Icon(Icons.more_vert,color: Colors.white,)
                                ],
                              ),
                              Text("0h 1m",style: AppTextStyles.bold.copyWith(fontSize: 50),),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    clipBehavior: Clip.hardEdge,
                                    child: Container(
                                      color: Colors.greenAccent,
                                      padding: const EdgeInsets.all(5),
                                      child: Text('CLOCKED IN',style: AppTextStyles.bold.copyWith(color: Colors.white),),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    clipBehavior: Clip.hardEdge,
                                    child: Container(
                                      color: Colors.greenAccent,
                                      padding: const EdgeInsets.all(5),
                                      child: Text('CLOCKED IN',style: AppTextStyles.bold.copyWith(color: Colors.white),),
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
          body: const TabBarView(
            children: [
              Center(child: Text("Tab 1")),
              Center(child: Text("Tab 1")),
              Center(child: Text("Tab 1")),
            ],
          ),
        ),
      ),
    );
  }
}
