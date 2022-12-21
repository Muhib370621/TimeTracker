import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/shared/widgets/app_common_textfield.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/utilities.dart';
import 'package:blu_time/view_models/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
        viewModelBuilder: () => OnboardingViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Image.asset(AppAssets.back), // Put icon of your preference.
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
              title:  Text.rich( TextSpan(
                    text: "Create ",
                    style: AppTextStyles.bold
                        .copyWith(fontSize: 20, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'New Password',
                        style: AppTextStyles.medium
                            .copyWith(fontSize: 20, color: Colors.black),
                      )
                    ]),
              ),
              centerTitle: false,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SafeArea(
                top: true,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 50,),
                    Image.asset(
                      AppAssets.changePassword,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("New Password",style: AppTextStyles.medium.copyWith(color: Colors.black),),
                        ),
                        Selector<OnboardingViewModel, bool>(
                            selector: (context, model) => model.obscureText,
                            builder: (context, value, child) =>
                                AppCommonTextField(
                                  prefixIcon: Image.asset(AppAssets.password),
                                  backgroundColor:
                                  AppColors.textFieldBackground,
                                  hintText: "Enter New Password",
                                    obscureText: value, suffixIcon: IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    value
                                        ?Icons.visibility_off
                                        : Icons.visibility,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    viewModel.setObscureText = !viewModel.obscureText;
                                  },
                                )
                                  // validator: viewModel.validatePassword,
                                  //  controller: viewModel.passwordController,
                                )),
                        const SizedBox(
                          height: 10,
                        ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Confirm Password",style: AppTextStyles.medium.copyWith(color: Colors.black),),
                        ),
                        Selector<OnboardingViewModel, bool>(
                            selector: (context, model) => model.obscureText,
                            builder: (context, value, child) =>
                                AppCommonTextField(
                                  prefixIcon: Image.asset(AppAssets.password),
                                  backgroundColor:
                                  AppColors.textFieldBackground,
                                  hintText: "Enter Confirm Password",
                                    obscureText: value, suffixIcon: IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    value
                                        ?Icons.visibility_off
                                        : Icons.visibility,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    viewModel.setObscureText = !viewModel.obscureText;
                                  },
                                )
                                  // validator: viewModel.validatePassword,
                                  //  controller: viewModel.passwordController,
                                )),
                      ],
                    ),
                   const Spacer(),
                    AppCommonButton(
                      title: "RESET PASSWORD",
                      onPressed: () async {
                        try {
                          await viewModel.getToken();
                        } on ErrorResponse catch (e) {
                          Utilities.showSnack(context, e.toString());
                          debugPrint(e.toString());
                        }
                        Navigator.of(context)
                            .pushNamed(RouteNames.verification);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
