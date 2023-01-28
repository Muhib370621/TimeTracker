import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/controllers/bottomNavigationController.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final WebViewController webController;
  final BottomNavController controller = Get.put(BottomNavController());
  double loadingProgress = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint(progress.toString());
            loadingProgress = progress.toDouble();
            setState(() {

            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://dev.blubanyan.com/bluChat/SolarSuccess/?userId=11&recordType=job&recordId=${controller.projectId.value}'));

    ever(controller.projectId, (_) {
          debugPrint("$_ has been changed");
          debugPrint('https://dev.blubanyan.com/bluChat/SolarSuccess/?userId=11&recordType=job&recordId=${controller.projectId.value}');
      webController.loadRequest(Uri.parse('https://dev.blubanyan.com/bluChat/SolarSuccess/?userId=11&recordType=job&recordId=${controller.projectId.value}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BluTimeAppHeader(
      leadingImage: AppAssets.profilePlaceholder,
      backEnabled: false,
    ),
      body: Stack(
        children: [
         WebViewWidget(controller: webController),
          if (loadingProgress < 100)
          LinearProgressIndicator(
            value: loadingProgress / 100,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green,),
          )
        ],
      ),
    );
  }
}
