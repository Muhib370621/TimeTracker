
import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/roles_response.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/apis/api_routes.dart';
import 'package:blu_time/utilities/apis/api_service.dart';
import 'package:blu_time/utilities/apis/decodable.dart';
import 'package:blu_time/view_models/base_view_model.dart';
class OnboardingViewModel extends BaseModel {
  final _issueTokenClient = ApiServices(baseUrl: AppUrls.issueToken).client;
  final _rolesClient = ApiServices(baseUrl: AppUrls.roles).client;
  final _queryClient = ApiServices(baseUrl: AppUrls.path).client;


  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set setObscureText(bool val) {
    _obscureText = val;
    notifyListeners();
  }


  getRoles() async {
    try {
      final result = await _rolesClient.requestList<RoleResponse>(
          route: APIRoute(APIType.roles),
          data: null,
          create: () => <RoleResponse>[]);
      List roles = result.map((e) => RoleResponse.fromJson(e)).toList();
      if (roles.isNotEmpty) {
        locator<StoreServices>().setAccountID(
            roles[0].account?.internalId ?? "");
      }
      return result;
    } on ErrorResponse {
      rethrow;
    }
  }

  getToken() async {
      final result = await _issueTokenClient.request<EmptyResponse>(
          route: APIRoute(APIType.issueToken),
          data: null,
          create: () => EmptyResponse());
      return result.response;
  }

  testApi()async{

   Map<String,String> body = {'q':'SELECT entityid,id,custentity_bb_homeowner_customer as homeownerid,BUILTIN.DF(custentity_bb_homeowner_customer) as homeowner FROM job where id=1043851'};

    try {
      final result = await _queryClient.request<EmptyResponse>(
          route: APIRoute(APIType.suiteql, routeParams: "?limit=10"),
          data: body,
          create: () => EmptyResponse());
      return result.response;
    } on ErrorResponse {
     // rethrow;
    }














  }

}



class EmptyResponse extends Decodable<EmptyResponse>{
  @override
  EmptyResponse decode(json) {
    return EmptyResponse();
  }
}