import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/utilities/utilities.dart';
import 'package:blu_time/view_models/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:stacked/stacked.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text("Verify your number"),
      ),
      body: ViewModelBuilder<OnboardingViewModel>.reactive(
          viewModelBuilder: () => OnboardingViewModel(),
          builder: (context, viewModel, child) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              //decoration: const BoxDecoration(gradient: AppGradients.login),
              child: SafeArea(
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 25.0),
                            // child: SvgPicture.asset(
                            //   "assets/svgs/logo.svg",
                            //   height: 79,
                            // ),
                          ),
                        ),
                        Image.asset(
                          AppAssets.confirmPage,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.6,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Make sure That's You Join",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bold.copyWith(
                                fontSize: 25, color: AppColors.buttonBlue),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Please check your inbox and make sure that it's you or not, and reset your password",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.medium
                              .copyWith(fontSize: 15, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: OTPTextField(
                              fieldStyle: FieldStyle.box,
                              //controller: otpController,
                              length: 4,
                              width: 300,
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldWidth: 60,
                              otpFieldStyle: OtpFieldStyle(
                                  borderColor: const Color(0xFFE7E7E7),
                                  enabledBorderColor: const Color(0xFFE7E7E7),
                                  focusBorderColor: Colors.blue),
                              outlineBorderRadius: 0,
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                              onChanged: (pin) {
                                // viewModel.setVerificationCode(pin);
                              },
                              onCompleted: (pin) {
                                // viewModel.setVerificationCode(pin);
                              }),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AppCommonButton(
                          title: "VERIFY",
                          fontSize: 17,
                          onPressed: () async {
                            Navigator.pushNamedAndRemoveUntil(
                                context, RouteNames.home, (_) => false);
                          },
                        ),
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child:  Text.rich( TextSpan(
                                  text:
                                  "Did you receive this email? Check your inbox or ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Resend Email',
                                      style: TextStyle(
                                          color: AppColors.buttonBlue,
                                          fontSize: 16),
                                    )
                                  ]),
                            )),
                      ]),
                ),
              ),
            );
          }),
    );
  }
}
