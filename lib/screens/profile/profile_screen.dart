import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_strings.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/shared/widgets/app_common_textfield.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double profileIconSize = MediaQuery.of(context).size.width * 0.13;
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
            SizedBox(
              height: profileIconSize,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.only(top: profileIconSize),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        boxShadow: [BoxShadow(blurRadius: 10)]),
                    //padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: EdgeInsets.only(top: profileIconSize),
                      child: SingleChildScrollView(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Your Name Here",
                                  style: AppTextStyles.bold.copyWith(
                                      fontSize: 25, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            AppStrings.firstName.tr(),
                                            style: AppTextStyles.bold.copyWith(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                           SizedBox(
                                            height: 45,
                                            child: AppCommonTextField(
                                              backgroundColor:
                                                  AppColors.textFieldBackground,
                                              hintText: AppStrings.enterEmailAddress.tr(),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppStrings.lastName.tr(),
                                            style: AppTextStyles.bold.copyWith(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                           SizedBox(
                                            height: 45,
                                            child: AppCommonTextField(
                                              backgroundColor:
                                                  AppColors.textFieldBackground,
                                              hintText: AppStrings.enterEmailAddress.tr(),
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
                                      AppStrings.emailAddress.tr(),
                                      style: AppTextStyles.bold.copyWith(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                     SizedBox(
                                      height: 45,
                                      child: AppCommonTextField(
                                        backgroundColor:
                                            AppColors.textFieldBackground,
                                        hintText:
                                        AppStrings.enterEmailAddress.tr(),
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
                                      AppStrings.mobileNumber.tr(),
                                      style: AppTextStyles.bold.copyWith(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                     SizedBox(
                                      height: 45,
                                      child: AppCommonTextField(
                                        backgroundColor:
                                            AppColors.textFieldBackground,
                                        hintText:
                                        AppStrings.enterMobileNumber.tr(),
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
                                        title: AppStrings.saveChanges.tr(),
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
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(AppAssets.aboutUs),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      AppStrings.aboutUs.tr(),
                                      style: AppTextStyles.semiBold.copyWith(
                                          fontSize: 18, color: Colors.black),
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
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(AppAssets.getHelp),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      AppStrings.getHelp.tr(),
                                      style: AppTextStyles.semiBold.copyWith(
                                          fontSize: 18, color: Colors.black),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                AppCommonButton(title: AppStrings.logOut.tr()),
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
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black.withAlpha(60),
                                spreadRadius: 5)
                          ],
                        ),
                        child: CircleAvatar(
                          radius: profileIconSize,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: profileIconSize - 3,
                            child: Icon(Icons.person_rounded,
                                color: Colors.white,
                                size: profileIconSize * 1.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
