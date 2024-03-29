import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/models/project_action.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:blu_time/view_models/base_view_model.dart';

class ProjectDetailViewModel extends BaseModel {
  final _queryClient = ApiServices(baseUrl: AppUrls.path).client;
  List<ProjectAction> actions = [];
  int totalCount = 0;
  bool isLoading = false;
  set setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }
  fetchActions({bool refresh = false}) async {
    if (isLoading){
      return;
    }
    else if (actions.length == totalCount && totalCount !=0) {
      return;
    }
    setIsLoading = true;
    setState(ViewState.loading);
    Map<String, String> body = {
      'q':
          "SELECT * FROM customrecord_bb_project_action WHERE custrecord_bb_project='1043028'"
    };
    try {
      final result = await _queryClient.request<QueryResponse<ProjectAction>>(
          route: APIRoute(APIType.suiteql,
              routeParams: "?limit=10&offset=${actions.length}"),
          data: body,
          create: () => QueryResponse(create: () => ProjectAction()));
      if (refresh) {
        actions = result.response?.items ?? [];
      }
      else {
        actions = List.from(actions)
          ..addAll(result.response?.items ?? []);
      }
      totalCount = result.response?.totalResults ?? 0;
      setIsLoading = false;
      if (actions.isEmpty) {
        setState(ViewState.empty);
      } else {
        setState(ViewState.completed);
      }
      notifyListeners();
    } on ErrorResponse {
      rethrow;
    }
  }
}
