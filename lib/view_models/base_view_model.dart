import 'package:blu_time/shared/enums/view_states.dart';
import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.init;
  ViewState get state => _state;

  setState(ViewState state){
    _state = state;
    notifyListeners();
  }

  updateState(){
    notifyListeners();
  }
}