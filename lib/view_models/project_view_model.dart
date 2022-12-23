import 'package:blu_time/view_models/base_view_model.dart';

class ProjectViewModel extends BaseModel {

  int tabIndex = 0;
  set setTabIndex(int tabIndex) {
    this.tabIndex = tabIndex;
    notifyListeners();
  }

}