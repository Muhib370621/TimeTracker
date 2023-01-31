import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/models/project_action.dart';
import 'package:blu_time/screens/views/action_card.dart';
import 'package:blu_time/shared/extensions.dart';
import 'package:blu_time/shared/widgets/paged_list.dart';
import 'package:blu_time/view_models/project_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ProjectDetailScreen extends StatefulWidget {
  final Project project;
  const ProjectDetailScreen({Key? key, required this.project}) : super(key: key);

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder.nonReactive(
        onModelReady: (ProjectDetailViewModel model) => model.fetchActions(projectID: widget.project.id ?? ""),
        viewModelBuilder: () => ProjectDetailViewModel(),
        builder: (BuildContext context, ProjectDetailViewModel model,
            Widget? child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizedStrings.details.tr(),
                    style: AppTextStyles.semiBold
                        .copyWith(color: AppColors.buttonBlue, fontSize: 12.width),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizedStrings.startTime.tr(),
                                style: AppTextStyles.semiBold.copyWith(
                                    color: AppColors.buttonBlue, fontSize: 13.width),
                              ),
                              const SizedBox(width: 5,),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(widget.project.startTime ?? "",
                                      style: AppTextStyles.medium.copyWith(
                                          color: Colors.grey, fontSize: 13.width)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("09:00 AM",
                                      style: AppTextStyles.semiBold.copyWith(
                                          color: AppColors.buttonBlue,
                                          fontSize: 10.width)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizedStrings.finishTime.tr(),
                                style: AppTextStyles.semiBold.copyWith(
                                    color: AppColors.buttonBlue, fontSize: 13.width),
                              ),
                              const SizedBox(width: 5,),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(widget.project.endTime ?? "",
                                      style: AppTextStyles.medium.copyWith(
                                          color: Colors.grey, fontSize: 13.width)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("09:00 AM",
                                      style: AppTextStyles.semiBold.copyWith(
                                          color: AppColors.buttonBlue,
                                          fontSize: 10.width)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizedStrings.location.tr(),
                                style: AppTextStyles.semiBold.copyWith(
                                    color: AppColors.buttonBlue, fontSize: 13.width),
                              ),
                              const SizedBox(width: 5,),
                              Row(
                                children: [
                                  Text(widget.project.address1 ?? "Project Location Here",
                                      style: AppTextStyles.medium.copyWith(
                                          color: Colors.grey, fontSize: 13.width)),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizedStrings.action.tr(),
                    style: AppTextStyles.bold
                        .copyWith(color: AppColors.buttonBlue, fontSize: 12.width),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        //  model.fetchActions();
                        //  debugPrint("ScrollNotification");
                        return true;
                      }
                      return false;
                    },
                    child: Selector<ProjectDetailViewModel,
                            List<ProjectAction>>(
                        selector: (context, model) => model.actions,
                        builder: (BuildContext context, value, Widget? child) {
                          return Expanded(
                              child: PagedList(
                            itemBuilder: (context, index) {
                              if (index == model.actions.length) {
                                return Selector<ProjectDetailViewModel, bool>(
                                    selector: (context, model) =>
                                        model.isLoading,
                                    builder: (context, value, child) =>
                                        model.isLoading
                                            ? SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 100,
                                                child: const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              )
                                            : SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 100,
                                              ));
                              }
                              return ActionCard(
                                projectAction: value[index],
                              );
                            },
                            itemCount: value.length + 1,
                            onRefresh: () {
                              model.fetchActions(refresh: true,projectID: widget.project.id ?? "");
                            },
                            onScrollToBottom: () {
                              debugPrint("ScrollNotification");
                              model.fetchActions(projectID: widget.project.id ?? "");
                            },
                          ));
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
