import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/constants/app_urls.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/models/roles_response.dart';
import 'package:blu_time/models/token_info.dart';
import 'package:blu_time/screens/home/home_screen.dart';
import 'package:blu_time/shared/extensions.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/shared/widgets/app_common_textfield.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:blu_time/utilities/apis/api_response.dart';
import 'package:blu_time/utilities/utilities.dart';
import 'package:blu_time/view_models/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController(text: "t1@bb.com");
  final TextEditingController passwordController = TextEditingController(text: "testing@1one");
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
        viewModelBuilder: () => OnboardingViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SafeArea(
                top: true,
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(
                          text: "Log In ",
                          style: AppTextStyles.bold
                              .copyWith(fontSize: 20, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'To Join Your',
                              style: AppTextStyles.medium
                                  .copyWith(fontSize: 20, color: Colors.black),
                            )
                          ]),
                    ),
                    SizedBox(height: 50.width,),
                    Align(
                      alignment: Alignment.center,
                      child:  Text.rich( TextSpan(
                            text: "bluTime",
                            style: AppTextStyles.bold
                                .copyWith(fontSize: 35, color: Colors.black),
                            ),
                      ),
                    ),
                    Expanded(
                      child: SvgPicture.asset(
                        AppAssets.login1,
                        fit: BoxFit.cover,
                       // height: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Username / Email",style: AppTextStyles.medium.copyWith(color: Colors.black),),
                        ),
                        AppCommonTextField(
                          prefixIcon: SvgPicture.asset(AppAssets.username),
                          backgroundColor: AppColors.textFieldBackground,
                          hintText: "Enter Your Username / Email",
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          // validator: viewModel.validateEmail,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Password",style: AppTextStyles.medium.copyWith(color: Colors.black),),
                        ),
                        Selector<OnboardingViewModel, bool>(
                            selector: (context, model) => model.obscureText,
                            builder: (context, value, child) =>
                                AppCommonTextField(
                                  prefixIcon: SvgPicture.asset(AppAssets.password),
                                  backgroundColor:
                                      AppColors.textFieldBackground,
                                  hintText: "Enter Your Password",
                                  obscureText: value, suffixIcon: IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                      icon: Icon(
                                        value
                                            ?Icons.visibility_off
                                            : Icons.visibility,
                                        color: Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        viewModel.setObscureText = !viewModel.obscureText;
                                      },
                                    ),
                                  // validator: viewModel.validatePassword,
                                    controller: passwordController,
                                )),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RouteNames.forgotPassword);
                              },
                              child: const Text("Forgot Password?",
                                  style: TextStyle(
                                      color: AppColors.textButton,
                                      fontSize: 16))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppCommonButton(
                      radius: 4,
                      title: "LOG IN",
                      isLoading: viewModel.isLoggingIn,
                      onPressed: () async {
                        try {
                          viewModel.setIsLoggingIn = true;
                          await locator<StoreServices>().setUsername(emailController.text);
                          await locator<StoreServices>().setPassword(passwordController.text);
                          List<RoleResponse> roleResponse = await viewModel.getRoles();
                          if (roleResponse.isNotEmpty) {
                            await locator<StoreServices>().setAccountID(roleResponse.first.account?.internalId ?? "");
                            await locator<StoreServices>().setRoleID(roleResponse.first.role?.internalId.toString() ?? "");
                            TokenInfo tokenInfo = await viewModel.getToken();
                            locator<StoreServices>().setAccessToken(tokenInfo.tokenId ?? "");
                            locator<StoreServices>().setTokenSecret(tokenInfo.tokenSecret ?? "");
                            await viewModel.getUserId();
                            await viewModel.getUserRoles();
                            debugPrint("test");
                            viewModel.setIsLoggingIn = false;
                            Get.offAll(() => const HomeScreen());
                          }
                        } on ErrorResponse catch (e) {
                          viewModel.setIsLoggingIn = false;
                          Utilities.showSnack(context, e.toString());
                          debugPrint(e.toString());
                          await locator<StoreServices>().setAccountID(AppUrls.accountID);
                          locator<StoreServices>().setAccessToken(AppUrls.token);
                          locator<StoreServices>().setTokenSecret(AppUrls.secret);
                          await locator<StoreServices>().setUserID("12");
                         List<String> roles = await viewModel.getUserRoles();
                          Get.offAll(()=>const HomeScreen());
                        }
                        // Navigator.of(context)
                        //     .pushNamed(RouteNames.verification);
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
