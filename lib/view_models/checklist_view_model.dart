import 'package:blu_time/constants/app_storage.dart';
import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/main.dart';
import 'package:blu_time/models/action_checklist.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/stores/mock_factory.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:blu_time/view_models/base_view_model.dart';

class ChecklistViewModel extends BaseModel {
  final _queryClient = ApiServices(baseUrl: AppUrls.path).client;
  List<ActionChecklist> checklist = [];

  fetchCheckList(String action) async {
    if (isMockEnabled){
      checklist = MockFactory().mockActionChecklist(action);
      setState(checklist.isNotEmpty ? ViewState.completed : ViewState.empty);
      return;
    }
    // final StartingScreenController controller =
    // Get.put(StartingScreenController());
    List<dynamic> jsonList = await locator<StoreServices>().getLocal(AppStorage.checklist, action) ?? [];
    // controller.actions = jsonList;
    checklist = jsonList.map((e) => ActionChecklist().decode((Map<String, dynamic>.from(e)))).toList();
    setState(checklist.isNotEmpty ? ViewState.completed : ViewState.loading);
    Map<String, String> body = {
      'q':
          "SELECT customrecord_bb_project_action_checklist.custrecord_bb_pachklist_title as title, custrecord_bt_complete_checklist as completed, TO_CHAR(custrecord_bt_completed_dt, 'DS TS') as completed_date FROM customrecord_bt_proj_conn_checklist INNER JOIN customrecord_bb_project_action_checklist ON customrecord_bt_proj_conn_checklist.custrecord_bt_pa_checklist = customrecord_bb_project_action_checklist.id WHERE custrecord_bt_proj_act_conn =$action"
    };
    try {
      final result = await _queryClient.request<QueryResponse<ActionChecklist>>(
          route: APIRoute(APIType.suiteql, routeParams: "?limit=10"),
          data: body,
          create: () => QueryResponse(create: () => ActionChecklist()));
      checklist = result.response?.items ?? [];
      if (checklist.isNotEmpty) {
        await locator<StoreServices>().setLocal(AppStorage.checklist,action, checklist.map((e) => e.toJson()).toList());
      }
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
