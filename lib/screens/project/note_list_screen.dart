import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/shared/enums/view_states.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/view_models/note_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        elevation: 10.0,
        child: const SizedBox(
          width: 70,
          height: 70,
          child: Card(
            color: AppColors.buttonBlue,
            shape: CircleBorder(),
            child: Icon(Icons.add,size: 40,color: Colors.white,),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(RouteNames.addNote);
        },
      ),
      body: ViewModelBuilder.reactive(
        onModelReady: (NoteViewModel model) => model.fetchNotes(),
        viewModelBuilder: () => NoteViewModel(),
        builder: (BuildContext context, NoteViewModel model, Widget? child) {
          return _buildBody(model);
        },
      ),
    );
  }

  _buildBody(NoteViewModel model) {
    return Selector<NoteViewModel, ViewState>(
        selector: (context, model) => model.state,
        builder: (BuildContext context, value, Widget? child) {
          switch (value) {
            case ViewState.init:
              return _emptyNote(model);
            case ViewState.loading:
              return _emptyNote(model);
            case ViewState.completed:
              return _buildNotes(model);
            case ViewState.error:
              return _emptyNote(model);
            case ViewState.empty:
              return _emptyNote(model);
          }
        });
  }

  _buildNotes(NoteViewModel model) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: model.notes.length,
        itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: GestureDetector(
                child: Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, t mollit anim id est laborum.",
                            style: AppTextStyles.semiBold
                                .copyWith(color: Colors.black, fontSize: 12)),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.addImage,
                              width: 40,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              AppAssets.addImage,
                              width: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.noteList);
                },
              ),
            ));
  }

  Padding _emptyNote(NoteViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppAssets.addNote),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Notes",
            style: AppTextStyles.bold
                .copyWith(color: AppColors.buttonBlue, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Use Notes To Tag Projects With Comments, Photos of Work And Receipts",
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBold
                .copyWith(color: Colors.black, fontSize: 12),
          ),
          const SizedBox(
            height: 40,
          ),
          AppCommonButton(
            title: 'Add Notes',
            width: 150,
            height: 35,
            radius: 10,
            onPressed: () {
              viewModel.addNote();
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
