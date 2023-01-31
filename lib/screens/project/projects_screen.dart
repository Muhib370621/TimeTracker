import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/controllers/bottomNavigationController.dart';
import 'package:blu_time/controllers/startingScreenController.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/screens/views/project_card.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/shared/widgets/empty_view.dart';
import 'package:blu_time/shared/widgets/paged_list.dart';
import 'package:blu_time/view_models/project_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../constants/app_storage.dart';
import '../../helpers/locator.dart';
import '../../stores/store_services.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BluTimeAppHeader(
          leadingImage: AppAssets.profilePlaceholder,
          backEnabled: false,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ViewModelBuilder.nonReactive(
              onModelReady: (ProjectViewModel model) => model.fetchProjects(),
              viewModelBuilder: () => ProjectViewModel(),
              builder: (BuildContext context, ProjectViewModel model,
                  Widget? child) {
                return _buildBody(model);
              }),
        ));
  }

  _buildBody(ProjectViewModel model) {
    return Selector<ProjectViewModel, ViewState>(
        selector: (context, model) => model.state,
        builder: (BuildContext context, value, Widget? child) {
          switch (value) {
            case ViewState.init:
              return const EmptyView();
            case ViewState.loading:
              return const Center(child: CircularProgressIndicator());
            case ViewState.completed:
              return _buildDataView(model);
            case ViewState.error:
              return const EmptyView();
            case ViewState.empty:
              return const EmptyView();
          }
        });
  }

  _buildDataView(ProjectViewModel model) {
    final StartingScreenController startController =
        Get.put(StartingScreenController());
    final BottomNavController controller = Get.put(BottomNavController());
    return Selector<ProjectViewModel, List<Project>>(
        selector: (context, model) => model.projects,
        builder: (BuildContext context, value, Widget? child) {
          return PagedList(
            itemCount: model.projects.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: GestureDetector(
                  onTap: () async {
                    model.setSelectedProject = model.projects[index];
                    controller.projectId.value = model.selectedProject?.id ?? "";
                    Navigator.of(context).pushNamed(
                        RouteNames.projectDetailHolder,
                        arguments: model);
                    if (startController.clockRunning.value == true &&
                        controller.projectName.value == "") {
                      controller.projectName.value =
                          model.projects[index].name.toString();
                      await locator<StoreServices>().setLocal(
                          AppStorage.projectName,
                          "userid",
                          controller.projectName.value);

                    }
                  },
                  child: ProjectCard(
                    project: model.projects[index],
                  ),
                ),
              );
            },
            onRefresh: () {
              model.fetchProjects();
            },
          );
        });
  }
}
