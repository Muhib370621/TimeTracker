import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/view_models/base_view_model.dart';

class NoteViewModel extends BaseModel {

  List<dynamic> notes = [];
 fetchNotes(){
   if (notes.isEmpty) {
      setState(ViewState.empty);
    }
   else {
     setState(ViewState.completed);
   }
    notifyListeners();
 }

 addNote(){
   notes.add("value");
   notes.add("value");
   notes.add("value");
   notes.add("value");
   fetchNotes();
 }

}