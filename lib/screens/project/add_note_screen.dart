import 'dart:io';

import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/add_note.dart';
import 'package:blu_time/shared/Prompts.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/view_models/note_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddNoteScreen extends StatefulWidget {
  final NoteViewModel viewModel;
  const AddNoteScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset:false,
          appBar: const BluTimeAppHeader(),
          body: ViewModelBuilder.reactive(
              viewModelBuilder: () => widget.viewModel,
              disposeViewModel: false,
              builder:
                  (BuildContext context, NoteViewModel model, Widget? child) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          minLines: 7,
                          maxLines: 7,
                          controller: controller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(10),
                              hintText:
                                  "${AppLocalizedStrings.writeNote.tr()}...",
                              hintStyle: AppTextStyles.normal
                                  .copyWith(color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      model.noteImages.isEmpty
                          ? GestureDetector(
                              onTap: () {
                                model.selectImages();
                              },
                              child: DottedBorder(
                                color: AppColors.buttonBlue,
                                strokeWidth: 3,
                                dashPattern: const [15, 8],
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(20),
                                child: AspectRatio(
                                    aspectRatio: 1.5,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.buttonBlue.withAlpha(20),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppAssets.addImage,
                                            width: 92,
                                          ),
                                          Text(
                                            AppLocalizedStrings.addImages.tr(),
                                            style: AppTextStyles.bold.copyWith(
                                                color: AppColors.buttonBlue,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            )
                          : Expanded(
                            child: GridView.builder(
                              itemCount: model.noteImages.length + 1,
                              itemBuilder: (context, index) {
                                if (index == model.noteImages.length) {
                                  return GestureDetector(
                                    onTap: () {
                                      model.selectImages();
                                    },
                                    child: Image.asset(
                                      AppAssets.addImage,
                                      fit: BoxFit.fitWidth,
                                      width: 60,
                                      height: 60,
                                    ),
                                  );
                                }
                                return Stack(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      padding: const EdgeInsets.all(5),
                                      child: Image.file(
                                        File(model.noteImages[index].path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: ClipOval(
                                        child: Container(
                                          color:Colors.white,
                                          child: IconButton(
                                            color: Colors.black,
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            onPressed: () {
                                              model.removeImage(index);
                                            },
                                            icon: const Icon(
                                              Icons.cancel_rounded,

                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                            ),
                          ),
                      const SizedBox(
                        height: 25,
                      ),
                      AppCommonButton(
                        title: AppLocalizedStrings.addNote.tr(),
                        radius: 10,
                        height: 40,
                        onPressed: () async {
                          List<String> paths =
                              model.noteImages.map((e) => e.path).toList();
                          try {
                            List<dynamic> notes = await locator<StoreServices>()
                                .getLocal("notes", "userid");
                            List<AddNote> note1 = notes
                                .map((e) => AddNote.fromJson(
                                    Map<String, dynamic>.from(e)))
                                .toList();
                            AddNote note =
                                AddNote(controller.text ?? "", paths, false);
                            note1.add(note);
                            await locator<StoreServices>().setLocal(
                                "notes",
                                "userid",
                                (note1.map((e) => e.toJson()).toList()));
                            Prompts.showSnackBar(msg: "Note saved locally");
                            Navigator.of(context).pop();
                          } catch (e) {
                            AddNote note =
                                AddNote(controller.text ?? "", paths, false);
                            await locator<StoreServices>()
                                .setLocal("notes", "userid", [note.toJson()]);
                            Prompts.showSnackBar(msg: "Note saved locally");
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                );
              })),
    );
  }
}
