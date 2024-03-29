import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/screens/home/home_screen.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/view_models/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final Size size = MediaQuery.of(context).size;
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
                        Expanded(
                          child: Image.asset(
                            AppAssets.confirmPage,
                            fit: BoxFit.fitWidth,
                           // height: MediaQuery.of(context).size.height * 0.6,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Make sure That's You",
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
                         SizedBox(
                          height: 0.04* size.height,
                        ),
                        AppCommonButton(
                          title: "VERIFY",
                          fontSize: 17,
                          onPressed: () async {
                           // locator<StoreServices>().setAccessToken("notnull");
                            Get.offAll(()=>const HomeScreen());
                            // Navigator.pushNamedAndRemoveUntil(
                            //     context, RouteNames.bottomNav, (_) => false);
                          },
                        ),
                        // Spacer(),
                        SizedBox(height: 0.07*size.height,),
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
                        const SizedBox(
                          height: 30,
                        ),
                      ]),
                ),
              ),
            );
          }),
    );
  }
}
