import 'package:blu_time/constants/app_storage.dart';
import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/time_entry.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:blu_time/view_models/base_view_model.dart';

class TimeEntryViewModel extends BaseModel{
  final _queryClient = ApiServices(baseUrl: AppUrls.path).client;
  List<TimeEntry> entries = [];
  int totalCount = 0;
  bool isLoading = false;
  set setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }
  fetchEntries({bool refresh = false}) async {
    if (isLoading){
      return;
    }
    if (refresh) {
      entries.clear();
    } else if (entries.length == totalCount && totalCount !=0) {
      return;
    }

    List<dynamic> jsonList = await locator<StoreServices>().getLocal(AppStorage.timeEntries, "userid") ?? [];
     entries = jsonList.map((e) => TimeEntry().decode((Map<String, dynamic>.from(e)))).toList();
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
      entries = List.from(entries)..addAll(result.response?.items ?? []);
      totalCount = result.response?.totalResults ?? 0;
      setIsLoading = false;
      await locator<StoreServices>().setLocal(AppStorage.timeEntries, "userid", entries.map((e) => e.toJson()).toList());
      setState(entries.isEmpty ? ViewState.empty : ViewState.completed);
      notifyListeners();
    } on ErrorResponse {
      rethrow;
    }
  }
}