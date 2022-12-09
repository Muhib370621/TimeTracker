import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/constants/app_colors.dart';
import 'package:blu_time/screens/views/project_card.dart';
import 'package:blu_time/screens/views/task_card.dart';
import 'package:blu_time/screens/views/time_card.dart';
import 'package:blu_time/shared/routes/route_names.dart';
import 'package:blu_time/shared/widgets/app_common_button.dart';
import 'package:blu_time/shared/widgets/app_common_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Spacer(),
            Image.asset(AppAssets.appLogo,fit: BoxFit.cover,width: 180,),

            SizedBox(height: 100,),
            AppCommonTextField(),
            SizedBox(height: 20,),
            AppCommonButton(title: "LOG IN",onPressed: (){
              Navigator.of(context).pushNamed(RouteNames.verification);
            },),
            TimeCard(),
            ProjectCard(),
            TaskCard(),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
