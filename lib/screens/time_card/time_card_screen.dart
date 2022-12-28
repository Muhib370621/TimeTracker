import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_strings.dart';
import 'package:blu_time/models/time_entry.dart';
import 'package:blu_time/screens/views/time_card.dart';
import 'package:blu_time/shared/enums/time_card_status.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/app_common_textfield.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/shared/widgets/empty_view.dart';
import 'package:blu_time/shared/widgets/paged_list.dart';
import 'package:blu_time/view_models/time_entry_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class TimeCardScreen extends StatefulWidget {
  const TimeCardScreen({Key? key}) : super(key: key);

  @override
  State<TimeCardScreen> createState() => _TimeCardScreenState();
}

class _TimeCardScreenState extends State<TimeCardScreen> {
  TimeCardStatus timeCardStatus = TimeCardStatus.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BluTimeAppHeader(
        leadingImage: AppAssets.profilePlaceholder,
        backEnabled: false,
      ),
      body: ViewModelBuilder.nonReactive(
          onModelReady: (TimeEntryViewModel model) => model.fetchEntries(),
          viewModelBuilder: () => TimeEntryViewModel(),
          builder:
              (BuildContext context, TimeEntryViewModel model, Widget? child) {
            return _buildBody(model);
          }),
    );
  }

  _buildBody(TimeEntryViewModel model) {
    return Selector<TimeEntryViewModel, ViewState>(
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

  _buildDataView(TimeEntryViewModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.timerColor.withAlpha(50),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: SizedBox(
              height: 45,
              child: AppCommonTextField(
                suffixIcon: const Icon(
                  Icons.search,
                  color: AppColors.buttonBlue,
                ),
                backgroundColor: Colors.white,
                hintText: AppStrings.searchProject,
                hintColor: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  child: Container(
                    //height: 35,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.calendar_month,
                          color: AppColors.buttonBlue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(child: Text("Tue 06 Dec - Fri 09 Dec")),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.buttonBlue,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonHideUnderline(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: 35,
                          child: DropdownButton(
                            isExpanded: true,
                            alignment: Alignment.centerLeft,
                            value: timeCardStatus,
                            style: const TextStyle(color: Colors.black),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.buttonBlue,
                              size: 30,
                            ),
                            items: TimeCardStatus.values
                                .map((TimeCardStatus item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item.title,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (TimeCardStatus? value) async {
                              timeCardStatus = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: PagedList(
                  itemCount: model.entries.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      child: GestureDetector(
                        child: TimeCard(
                          timeEntry: model.entries[index],
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RouteNames.timeCardDetail);
                        },
                      ),
                    );
                  })
              ),
        ],
      ),
    );
  }
}
