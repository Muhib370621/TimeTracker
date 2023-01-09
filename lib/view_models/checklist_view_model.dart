import 'package:blu_time/constants/app_storage.dart';
import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/action_checklist.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:blu_time/view_models/base_view_model.dart';

class ChecklistViewModel extends BaseModel {
  final _queryClient = ApiServices(baseUrl: AppUrls.path).client;
  List<ActionChecklist> checklist = [];

  fetchCheckList(String action) async {

    checklist =  await locator<StoreServices>().getLocal(AppStorage.checklist, ActionChecklist());
    setState(checklist.isNotEmpty ? ViewState.completed : ViewState.loading);

    Map<String, String> body = {
      'q':
          "SELECT * FROM customrecord_bb_project_action_checklist WHERE custrecord_bb_pachklist_project_action=$action"
    };
    try {
      final result = await _queryClient.request<QueryResponse<ActionChecklist>>(
          route: APIRoute(APIType.suiteql, routeParams: "?limit=10"),
          data: body,
          create: () => QueryResponse(create: () => ActionChecklist()));
      checklist = result.response?.items ?? [];
      await locator<StoreServices>().setLocal(AppStorage.checklist, checklist);
      if (checklist.isEmpty) {
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
