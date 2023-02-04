import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/constants/app_styles.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/screens/onboarding/login_screen.dart';
import 'package:blu_time/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  Future<bool> isTokenValid() async {
    var token = locator<StoreServices>().getAccessToken();
    return token.isNotEmpty;
  }

  Future<bool> dummyTimer() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        isTokenValid(),
        dummyTimer(),
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshot) {
        if (snapshot.hasData) {
          if ((snapshot.data?[0] ?? true) == false) {
            return const LoginScreen();
          } else {
            return CustomBottomNavigationBar();
          }
        } else {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 100),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.appLogo,
                      // semanticsLabel: 'Acme Logo',
                      fit: BoxFit.cover, width: 200,
                    ),
                    // Image.asset(AppAssets.appLogo,fit: BoxFit.cover,width: 200,),
                    const Spacer(),
                    Column(
                      children: [
                        Image.asset(
                          AppAssets.appNameLogo,
                          width: 120,
                        ),
                        // Text.rich( TextSpan(
                        //       text: "bluTime",
                        //       style: AppTextStyles.bold.copyWith(fontSize: 35),
                        // ),),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Your Timekeeping Buddy",
                          style: AppTextStyles.normal,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
