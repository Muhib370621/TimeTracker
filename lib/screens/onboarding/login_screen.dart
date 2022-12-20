import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/models/error_response.dart';
import 'package:blu_time/screens/views/project_card.dart';
import 'package:blu_time/screens/views/task_card.dart';
import 'package:blu_time/screens/views/time_card.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/shared/widgets/app_common_textfield.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/utilities.dart';
import 'package:blu_time/view_models/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
        viewModelBuilder: () => OnboardingViewModel(),
        onModelReady: (OnboardingViewModel model) => model.getRoles(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    AppAssets.appLogo,
                    fit: BoxFit.cover,
                    width: 180,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const AppCommonTextField(
                    hintText: "Enter mobile number or email",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppCommonButton(
                    title: "LOG IN",
                    onPressed: () async {
                      try {
                        await viewModel.getToken();
                      } on ErrorResponse catch (e) {
                        Utilities.showSnack(context, e.toString());
                         debugPrint(e.toString());
                      }
                      Navigator.of(context).pushNamed(
                          RouteNames.verification);
                    },
                  ),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            ),
          );
        });
  }
}
