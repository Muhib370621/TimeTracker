import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/screens/views/time_card.dart';
import 'package:blu_time/shared/enums/time_card_status.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/shared/extensions.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/shared/widgets/app_common_textfield.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/shared/widgets/empty_view.dart';
import 'package:blu_time/shared/widgets/paged_list.dart';
import 'package:blu_time/view_models/time_entry_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class TimeCardScreen extends StatefulWidget {
  const TimeCardScreen({Key? key}) : super(key: key);

  @override
  State<TimeCardScreen> createState() => _TimeCardScreenState();
}

class _TimeCardScreenState extends State<TimeCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BluTimeAppHeader(
        leadingImage: AppAssets.profilePlaceholder,
        backEnabled: false,
      ),
      body: ViewModelBuilder.reactive(
          onModelReady: (TimeEntryViewModel model) => model.fetchEntries(),
          viewModelBuilder: () => TimeEntryViewModel(),
          builder: (BuildContext context, TimeEntryViewModel model, Widget? child) {
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
                hintText: AppLocalizedStrings.searchProject.tr(),
                hintColor: Colors.grey,
                onChanged: model.searchTimeEntry,
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
                child: GestureDetector(
                  onTap: () async {
                    final picked = await showDateRangePicker(
                        context: context,
                        initialDateRange: ((model.startDate == null) && (model.endDate == null)) ? null : DateTimeRange(start: model.startDate!, end: model.endDate!),
                        lastDate: DateTime.now(),
                        firstDate: DateTime(2019),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: AppColors.background,
                              colorScheme: const ColorScheme.light(primary: AppColors.background),
                            ),
                            child: Stack(
                              children: [
                                child!,
                                Positioned(
                                    bottom: 0,
                                    left: 20,
                                    right: 20,
                                    child: SafeArea(
                                        child: AppCommonButton(
                                      title: "Clear",
                                      onPressed: () {
                                        final DateFormat formatter = DateFormat('EEE d MMM');
                                        model.startDate = null;
                                        model.endDate = null;
                                        final String formatted = "${formatter.format(DateTime(2019))} - ${formatter.format(DateTime.now())}";
                                        model.setFilterTime = formatted;
                                        Navigator.of(context).pop();
                                      },
                                    ))),
                              ],
                            ),
                          );
                        });
                    if (picked != null) {
                      final DateFormat formatter = DateFormat('EEE d MMM');
                      model.startDate = picked.start;
                      model.endDate = picked.end;
                      final String formatted = "${formatter.format(picked.start)} - ${formatter.format(picked.end)}";
                      model.setFilterTime = formatted;
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: Container(
                      //height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: AppColors.buttonBlue,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Text(
                            model.filterTime,
                            style: AppTextStyles.medium.copyWith(color: Colors.black, fontSize: 10.width),
                          )),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.buttonBlue,
                          ),
                        ],
                      ),
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
                            value: model.timeCardStatus,
                            style: const TextStyle(color: Colors.black),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.buttonBlue,
                              size: 30,
                            ),
                            items: TimeCardStatus.values.map((TimeCardStatus item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item.title,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (TimeCardStatus? value) async {
                              model.setTimeCardStatus = value ?? TimeCardStatus.all;
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
                          Navigator.of(context).pushNamed(RouteNames.timeCardDetail, arguments: model.entries[index]);
                        },
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
