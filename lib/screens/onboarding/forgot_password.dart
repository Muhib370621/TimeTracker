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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
        viewModelBuilder: () => OnboardingViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: SvgPicture.asset(AppAssets.back), // Put icon of your preference.
                    onPressed: () {
                     Navigator.of(context).pop();
                    },
                  );
                },
              ),
              title:  Text.rich( TextSpan(
                    text: "Forgot ",
                    style: AppTextStyles.bold
                        .copyWith(fontSize: 20, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Password',
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
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        "Enter the email address with your account and we'll send an email with confirmation to reset your password",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.normal
                            .copyWith(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppCommonTextField(
                          prefixIcon: SvgPicture.asset(AppAssets.username),
                          backgroundColor: AppColors.textFieldBackground,
                          hintText: "Enter Your Username / Email",
                          textInputType: TextInputType.emailAddress,
                          // controller: viewModel.emailController,
                          // validator: viewModel.validateEmail,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppCommonButton(
                      title: "CONTINUE",
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
