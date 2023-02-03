import 'dart:io';

import 'package:blu_time/app_loader.dart';
import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_localized_strings.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/user_profile.dart';
import 'package:blu_time/shared/extensions.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/shared/widgets/app_common_textfield.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/stores/mock_factory.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/media_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? user;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? mobileController;

  final MediaPicker _mediaPicker = MediaPicker();
  List<XFile> userImages = [];

  @override
  void initState() {
    super.initState();
    String userId = locator<StoreServices>().getUsername();
    user = MockFactory().mockUsers(userId: userId).first;
    firstNameController = TextEditingController(text: user?.firstName ?? "");
    lastNameController = TextEditingController(text: user?.lastName ?? "");
    emailController = TextEditingController(text: user?.email ?? "");
    mobileController = TextEditingController(text: user?.mobile ?? "");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double profileIconSize = MediaQuery.of(context).size.width * 0.14;
    return Scaffold(
        backgroundColor: AppColors.blueLightBackground,
        appBar: const BluTimeAppHeader(
          themeColor: Colors.white,
          backgroundColor: AppColors.blueLightBackground,
          elevation: 0.0,
          title: Text(
            "Profile",
            style: AppTextStyles.bold,
          ),
          centerTitle: false,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.only(top: profileIconSize),
                    decoration: const BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)), boxShadow: [BoxShadow(blurRadius: 10)]),
                    //padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: EdgeInsets.only(top: profileIconSize),
                      child: SingleChildScrollView(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${user?.firstName ?? ""} ${user?.lastName ?? ""}",
                                  style: AppTextStyles.semiBold.copyWith(fontSize: 18.width, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            AppLocalizedStrings.firstName.tr(),
                                            style: AppTextStyles.bold.copyWith(fontSize: 12.width, color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: AppCommonTextField(
                                              controller: firstNameController,
                                              backgroundColor: AppColors.textFieldBackground,
                                              hintText: AppLocalizedStrings.enterEmailAddress.tr(),
                                              hintColor: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizedStrings.lastName.tr(),
                                            style: AppTextStyles.bold.copyWith(fontSize: 12.width, color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: AppCommonTextField(
                                              controller: lastNameController,
                                              backgroundColor: AppColors.textFieldBackground,
                                              hintText: AppLocalizedStrings.enterEmailAddress.tr(),
                                              hintColor: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizedStrings.emailAddress.tr(),
                                      style: AppTextStyles.bold.copyWith(fontSize: 12.width, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 45,
                                      child: AppCommonTextField(
                                        controller: emailController,
                                        backgroundColor: AppColors.textFieldBackground,
                                        hintText: AppLocalizedStrings.enterEmailAddress.tr(),
                                        hintColor: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizedStrings.mobileNumber.tr(),
                                      style: AppTextStyles.bold.copyWith(fontSize: 12.width, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 45,
                                      child: AppCommonTextField(
                                        controller: mobileController,
                                        backgroundColor: AppColors.textFieldBackground,
                                        hintText: AppLocalizedStrings.enterMobileNumber.tr(),
                                        hintColor: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 190,
                                  child: Column(
                                    children: [
                                      AppCommonButton(
                                        title: AppLocalizedStrings.saveChanges.tr(),
                                        fontSize: 16,
                                        radius: 4,
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                        thickness: 2,
                                        height: 40,
                                        indent: 20,
                                        endIndent: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(AppAssets.aboutUs),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      AppLocalizedStrings.aboutUs.tr(),
                                      style: AppTextStyles.semiBold.copyWith(fontSize: 15.width, color: Colors.black),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(AppAssets.getHelp),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      AppLocalizedStrings.getHelp.tr(),
                                      style: AppTextStyles.semiBold.copyWith(fontSize: 15.width, color: Colors.black),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                AppCommonButton(
                                  title: AppLocalizedStrings.logOut.tr(),
                                  radius: 4,
                                  onPressed: () async {
                                    await locator<StoreServices>().clearAll();
                                    await locator<StoreServices>().setAccessToken("");
                                    Get.offAll(() => const AppLoader());
                                  },
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black.withAlpha(60), spreadRadius: 5)],
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              selectImages();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4), // Border radius
                              child: ClipOval(
                                  child: Container(
                                    width: profileIconSize * 1.5,
                                    height: profileIconSize * 1.5,
                                    color: AppColors.background,
                                child: (userImages.isNotEmpty)
                                    ? Image.file(
                                        File(userImages[0].path),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network("https://picsum.photos/100/100",width: profileIconSize,fit: BoxFit.cover,),
                              )),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  selectImages() async {
    Get.defaultDialog(
      title: '',
      middleText: '',
      titlePadding: EdgeInsets.zero,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppCommonButton(
            title: "Gallery",
            width: 90,
            height: 40,
            onPressed: () async {
              if (Get.context != null) {
                Navigator.of(Get.context!, rootNavigator: true).pop();
              }
              List<XFile> images = await _mediaPicker.selectImages(isSingle: true);
              userImages.addAll(images);
              debugPrint(userImages.toString());
              setState(() {

              });
            },
          ),
          AppCommonButton(
            title: "Camera",
            width: 90,
            height: 40,
            onPressed: () async {
              if (Get.context != null) {
                Navigator.of(Get.context!, rootNavigator: true).pop();
              }
              List<XFile> images = await _mediaPicker.openCamera();
              userImages.addAll(images);
              debugPrint(userImages.toString());
              setState(() {

              });
            },
          ),
        ],
      ),
    );
  }
}
