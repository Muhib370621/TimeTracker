import 'package:blu_time/view_models/base_view_model.dart';

class HomeViewModel extends BaseModel {

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  onTapItem(int index){
    _selectedIndex = index;
    notifyListeners();
  }

}