import 'package:blu_time/constants/app_storage.dart';
import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/main.dart';
import 'package:blu_time/models/project_action.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/stores/mock_factory.dart';
import 'package:blu_time/stores/store_services.dart';
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

  fetchActions({bool refresh = false,required String projectID}) async {
    if (isMockEnabled){
      actions = MockFactory().mockProjectActions(projectID);
      setState(actions.isNotEmpty ? ViewState.completed : ViewState.empty);
      return;
    }
    else if (actions.length == totalCount && totalCount !=0) {
      return;
    }
    setIsLoading = true;
    List<dynamic> jsonList = await locator<StoreServices>().getLocal(AppStorage.actions, projectID) ?? [];
    actions = jsonList.map((e) => ProjectAction().decode((Map<String, dynamic>.from(e)))).toList();
    if (refresh){
      isLoading = false;
      actions.clear();
    }
    if (isLoading){
      return;
    }
    setState(actions.isNotEmpty ? ViewState.completed : ViewState.loading);
    Map<String, String> body = {
      'q':
          "SELECT TO_CHAR(custrecord_bt_assign_time, 'DS TS') as assigned_time, entity.entityid as assigned_by, name as title, customrecord_bt_proj_conn_action.custrecord_bt_complete as completed, customrecord_bt_proj_conn_action.id as id FROM customrecord_bt_proj_conn_action INNER JOIN entity ON entity.id = customrecord_bt_proj_conn_action.custrecord_bt_assigned_by WHERE custrecord_bt_proj_connection_act =$projectID"
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
      await locator<StoreServices>().setLocal(AppStorage.actions,projectID, actions.map((e) => e.toJson()).toList());
      setIsLoading = false;
      setState(actions.isEmpty ? ViewState.empty : ViewState.completed);
      notifyListeners();
    } on ErrorResponse {
      rethrow;
    }
  }

}
