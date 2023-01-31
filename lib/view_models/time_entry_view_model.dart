import 'package:blu_time/constants/app_storage.dart';
import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/main.dart';
import 'package:blu_time/models/time_entry.dart';
import 'package:blu_time/shared/enums/time_card_status.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/stores/mock_factory.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:blu_time/view_models/base_view_model.dart';
import 'package:intl/intl.dart';

class TimeEntryViewModel extends BaseModel{
  final _queryClient = ApiServices(baseUrl: AppUrls.path).client;
  List<TimeEntry> entries = [];
  List<TimeEntry> allEntries = [];
  int totalCount = 0;
  DateTime? startDate;
  DateTime? endDate;
  TimeCardStatus timeCardStatus = TimeCardStatus.all;
  bool isLoading = false;
  String textSearch = "";
  set setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  String filterTime = "Choose date";
  set setFilterTime(String filterTime) {
    this.filterTime = filterTime;
    searchWithDateRange();
    notifyListeners();
  }

  set setTimeCardStatus(TimeCardStatus status) {
    timeCardStatus = status;
    searchWithStatus();
    notifyListeners();
  }

  fetchEntries({bool refresh = false}) async {
    if (isMockEnabled){
      String userId = locator<StoreServices>().getUsername();
      allEntries = MockFactory().mockTimeEntry(userId: (userId == "t1@bb.com") ? null : userId);
      entries = allEntries;
      setState(entries.isNotEmpty ? ViewState.completed : ViewState.empty);
      return;
    }
    if (isLoading){
      return;
    }
    if (refresh) {
      allEntries.clear();
    } else if (allEntries.length == totalCount && totalCount !=0) {
      return;
    }

    List<dynamic> jsonList = await locator<StoreServices>().getLocal(AppStorage.timeEntries, "userid") ?? [];
    allEntries = jsonList.map((e) => TimeEntry().decode((Map<String, dynamic>.from(e)))).toList();
    entries = allEntries;
    setState(entries.isNotEmpty ? ViewState.completed : ViewState.loading);
    setIsLoading = true;
    Map<String, String> body = {
      'q':
      "SELECT * FROM timebill WHERE employee='1043852'"
    };
    try {
      final result = await _queryClient.request<QueryResponse<TimeEntry>>(
          route: APIRoute(APIType.suiteql,
              routeParams: "?limit=10&offset=${entries.length}"),
          data: body,
          create: () => QueryResponse(create: () => TimeEntry()));
      if (refresh) {
        allEntries = result.response?.items ?? [];
      }
      else {
        allEntries = List.from(allEntries)
          ..addAll(result.response?.items ?? []);
      }
      entries = allEntries;
      totalCount = result.response?.totalResults ?? 0;
      setIsLoading = false;
      await locator<StoreServices>().setLocal(AppStorage.timeEntries, "userid", allEntries.map((e) => e.toJson()).toList());
      setState(allEntries.isEmpty ? ViewState.empty : ViewState.completed);
      notifyListeners();
    } on ErrorResponse {
      rethrow;
    }
  }

  Future<void>searchTimeEntry(String text) async{
    textSearch =  text;
    setFilters();
    return;
    if (text.isEmpty){
      entries = allEntries;
    }
    else {
      entries = allEntries.where((element) => element.displayfield?.toLowerCase().contains(text.toLowerCase()) ?? false).toList();
    }
    setState(ViewState.completed);
  }

  searchWithStatus(){
    setFilters();
    return;
    entries = allEntries.where((element) => (timeCardStatus == TimeCardStatus.all) ? true : (element.type == timeCardStatus.title)).toList();
    setState(ViewState.completed);
  }

  searchWithDateRange() {
    setFilters();
    return;
    if ((startDate == null) && (endDate == null) ){
      entries = allEntries;
      setState(ViewState.completed);
      return;
    }
    var dateFormat = DateFormat.yMd();
    var output = <TimeEntry>[];
    for (var i = 0; i < allEntries.length; i += 1) {
      var date = dateFormat.parse(allEntries[i].trandate ?? "", true);
      if (date.compareTo(startDate!) >= 0 && date.compareTo(endDate!) <= 0) {
        output.add(allEntries[i]);
      }
    }
    entries = output;
    setState(ViewState.completed);
  }

  setFilters(){
    if ((startDate == null) && (endDate == null) ){
      entries = allEntries;
    }
    else {
      var dateFormat = DateFormat.yMd();
      var output = <TimeEntry>[];
      for (var i = 0; i < allEntries.length; i += 1) {
        var date = dateFormat.parse(allEntries[i].trandate ?? "", true);
        if (date.compareTo(startDate!) >= 0 && date.compareTo(endDate!) <= 0) {
          output.add(allEntries[i]);
        }
      }
      entries = output;
    }
    entries = entries.where((element) => (
        (element.displayfield?.toLowerCase().contains(textSearch.toLowerCase()) ?? false) &&
        ((timeCardStatus == TimeCardStatus.all) ? true : (element.type == timeCardStatus.title))
    )).toList();
    setState(ViewState.completed);
  }

}