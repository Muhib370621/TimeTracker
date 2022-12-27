import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/models/project_action.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:blu_time/view_models/base_view_model.dart';

class ProjectViewModel extends BaseModel {
  final _queryClient = ApiServices(baseUrl: AppUrls.path).client;
  List<Project> projects = [];
  Project? selectedProject;
  int tabIndex = 0;
  set setTabIndex(int tabIndex) {
    this.tabIndex = tabIndex;
    notifyListeners();
  }

  set setSelectedProject(Project selectedProject) {
    this.selectedProject = selectedProject;
    notifyListeners();
  }

  fetchProjects() async {
    setState(ViewState.loading);
    Map<String,String> body = {'q':"SELECT * FROM job WHERE custentity_bb_install_address_1_text='123 S. Main St' AND custentity_bb_install_address_2_text='Lot 2' AND custentity_bb_install_city_text='Portland' AND custentity_bb_install_zip_code_text='97216'"};
    try {
      final result = await _queryClient.request<QueryResponse<Project>>(
          route: APIRoute(APIType.suiteql, routeParams: "?limit=10"),
          data: body,
          create: () => QueryResponse(create: () => Project()));
      if (projects.isEmpty) {
        setState(ViewState.completed);
      }
      else {
        setState(ViewState.completed);
      }
      projects = result.response?.items ?? [];
      if (projects.isEmpty) {
        setState(ViewState.empty);
      }
      else {
        setState(ViewState.completed);
      }
      notifyListeners();
    } on ErrorResponse {
       rethrow;
    }
  }

}