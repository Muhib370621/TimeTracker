import 'package:blu_time/constants/app_assets.dart';
import 'package:blu_time/controllers/bottomNavigationController.dart';
import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/shared/widgets/blutime_app_header.dart';
import 'package:blu_time/stores/store_services.dart';
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
    String chatURl = 'https://dev.blubanyan.com/bluChat/SolarSuccess/?userId=${locator<StoreServices>().getUserID()}&recordType=job&recordId=${controller.currentProject.value?.bluchatId}';
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
      ..loadRequest(Uri.parse(chatURl));

    ever(controller.currentProject, (_) {
          debugPrint("$_ has been changed");
          chatURl = 'https://dev.blubanyan.com/bluChat/SolarSuccess/?userId=${locator<StoreServices>().getUserID()}&recordType=job&recordId=${controller.currentProject.value?.bluchatId}';
          debugPrint(chatURl);
      webController.loadRequest(Uri.parse(chatURl));
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
