import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/screens/views/checklist_card.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:blu_time/shared/widgets/empty_view.dart';
import 'package:blu_time/shared/widgets/paged_list.dart';
import 'package:blu_time/view_models/checklist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class CheckListScreen extends StatelessWidget {
  const CheckListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BluTimeAppHeader(),
      body: ViewModelBuilder.nonReactive(
          onModelReady: (ChecklistViewModel model) => model.fetchCheckList(),
          viewModelBuilder: () => ChecklistViewModel(),
          builder: (BuildContext context, ChecklistViewModel model, Widget? child) {
            return _buildBody(model);
          }),
    );
  }

  _buildBody(ChecklistViewModel model) {
    return Selector<ChecklistViewModel, ViewState>(
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

  Widget _buildDataView(ChecklistViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Action",
            style: AppTextStyles.bold
                .copyWith(color: AppColors.buttonBlue, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: PagedList(
                  itemCount: model.checklist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => CustomBottomNavigationBar());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ChecklistCard(
                          actionChecklist: model.checklist[index],
                        ),
                      ),
                    );
                  })
              )
        ],
      ),
    );
  }
}
