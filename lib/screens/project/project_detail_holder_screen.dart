import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/controllers/bottomNavigationController.dart';
import 'package:blu_time/screens/project/note_list_screen.dart';
import 'package:blu_time/screens/project/project_detail_screen.dart';
import 'package:blu_time/screens/project/site_map_screen.dart';
import 'package:blu_time/shared/extensions.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/view_models/project_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class ProjectDetailHolderScreen extends StatefulWidget {
  final ProjectViewModel viewModel;
  const ProjectDetailHolderScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<ProjectDetailHolderScreen> createState() =>
      _ProjectDetailHolderScreenState();
}

class _ProjectDetailHolderScreenState extends State<ProjectDetailHolderScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    widget.viewModel.setTabIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const BluTimeAppHeader(),
      body: ViewModelBuilder<ProjectViewModel>.reactive(
          viewModelBuilder: () => widget.viewModel,
          disposeViewModel: false,
          builder: (context, viewModel, child) {
            return Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  child: buildBody(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DefaultTabController(
                    length: 3,
                    child: TabBar(
                      controller: _tabController,
                      indicator: const BoxDecoration(),
                      onTap: (index) {
                        _tabController?.animateTo(index);
                      },
                      tabs: [
                        buildTab(viewModel, 0, AppLocalizedStrings.detail.tr()),
                        buildTab(viewModel, 1, AppLocalizedStrings.site.tr()),
                        buildTab(viewModel, 2, AppLocalizedStrings.notes.tr()),
                      ],
                    ),
                  ),
                ),
                // TabBar(tabs: [Text("dfdf")])
              ],
            );
          }),
    );
  }

  AppCommonButton buildTab(
      ProjectViewModel viewModel, int index, String title) {
    return AppCommonButton(
      title: title,
    //  width: 100,
      height: 35,
      radius: 5,
      elevation: 5.0,
      fontSize: 12.width,
      color:
          (viewModel.tabIndex == index) ? AppColors.buttonBlue : Colors.white,
      textColor:
          (viewModel.tabIndex == index) ? Colors.white : AppColors.buttonBlue,
      borderColor: Colors.transparent,
      onPressed: () {
        viewModel.setTabIndex = index;
        _tabController?.animateTo(index);
      },
    );
  }

  Widget buildBody() {
    final BottomNavController bottomController = Get.put(BottomNavController());

    return TabBarView(controller: _tabController, physics: const NeverScrollableScrollPhysics(),children: [
      Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: ProjectDetailScreen(project: widget.viewModel.selectedProject!),
      ),
      SiteMapScreen(project: widget.viewModel.selectedProject!,),
       Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: NoteListScreen(project: widget.viewModel.selectedProject!,),
      )
    ]);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
