import 'package:blu_time/constants/app_colors.dart';
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
      ),
      body: ViewModelBuilder<OnboardingViewModel>.reactive(
          viewModelBuilder: () => OnboardingViewModel(),
          builder: (context, viewModel, child) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              //decoration: const BoxDecoration(gradient: AppGradients.login),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 25.0),
                          // child: SvgPicture.asset(
                          //   "assets/svgs/logo.svg",
                          //   height: 79,
                          // ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(right: 40.0),
                      //     child: SvgPicture.asset("assets/svgs/bubble_login.svg"),
                      //   ),
                      // ),
                      const Spacer(flex: 1,),
                      const Text(
                        "Account\nVerification",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                       Text(
                        "Please enter the verification pin sent to ${widget.email}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      const Spacer(flex: 2,),
                      // OtpTextField(
                      //   textStyle: const TextStyle(
                      //         fontSize: 30,
                      //         fontWeight: FontWeight.w600,
                      //         color: Colors.white),
                      //   numberOfFields: 4,
                      //   cursorColor: Colors.white,
                      //   fieldWidth: 60,
                      //   showFieldAsBox: false,
                      //   onCodeChanged: (String verificationCode) {
                      //     debugPrint("onCodeChanged $verificationCode");
                      //     viewModel.setVerificationCode(verificationCode);
                      //
                      //   },
                      //   onSubmit: (String verificationCode) {
                      //     debugPrint("onSubmit $verificationCode");
                      //     viewModel.setVerificationCode(verificationCode);
                      //   },
                      // ),
                Align(
                  alignment: Alignment.center,
                  child: OTPTextField(
                    fieldStyle: FieldStyle.box,
                      //controller: otpController,
                      length: 4,
                      width: 300,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 60,
                      otpFieldStyle: OtpFieldStyle(borderColor: const Color(0xFFE7E7E7),enabledBorderColor: const Color(0xFFE7E7E7),focusBorderColor: Colors.blue),
                      outlineBorderRadius: 0,
                      style:  const TextStyle(
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
                      const Spacer(),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                          AppCommonButton(
                            title: "Verify",
                            fontSize: 17,
                            onPressed: () async {
                              // try {
                              // //  await viewModel.verifyCode(widget.email);
                              //   Utilities.showSnack(context,"Your email was verified successfully.");
                              //     Navigator.of(context).popUntil((route) => route.isFirst);
                              // } on ErrorResponse catch (e) {
                              //   Utilities.showSnack(context, e.message);
                              // }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0),
                                child: RichText(
                                  text: const TextSpan(
                                      text: "Didn't receive code? ",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Resend code',
                                          style: TextStyle(
                                              color: AppColors.buttonCyan,
                                              fontSize: 16),
                                        )
                                      ]),
                                ),
                              ),
                              onTap: () async {
                                // try {
                                //   EmptyResponse? userResponse = await viewModel.resendVerificationCode(widget.email);
                                //   Utilities.showSnack(context, "Verification code sent to ${widget.email}");
                                // } on ErrorResponse catch (e) {
                                //   Utilities.showSnack(context, e.message);
                                // }
                              })
                        ],
                      ),
                      const Spacer()
                    ]),
              ),
            );
          }),
    );
  }
}
