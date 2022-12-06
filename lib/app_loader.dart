import 'package:blu_time/constants/app_gradients.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/screens/home/home_screen.dart';
import 'package:blu_time/screens/onboarding/login_screen.dart';
import 'package:blu_time/stores/store_services.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {

  Future<bool> isTokenValid() async {
    return false;
    var token = locator<StoreServices>().getAccessToken();
    return token.isNotEmpty;
  }

  Future<bool> dummyTimer() async {
    await Future.delayed(const Duration(milliseconds: 2500));
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
          if (snapshot.hasData){
            if ((snapshot.data?[0] ?? true) == false) {
              return const LoginScreen();
            } else {
              return const HomeScreen();
            }
          }
          else {
            return Container(
              decoration: const BoxDecoration(gradient: AppGradients.login),
              child: const Align(
                alignment: Alignment.center,
                child: Material(child: Text("bluTime")),
            ));
          }
        });
  }
}
