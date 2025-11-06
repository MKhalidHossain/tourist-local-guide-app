import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/widgets/app_scaffold.dart';
import 'package:kobeur/core/widgets/wide_custom_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../home/controllers/home_controller.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ConnectStripeScreen extends StatefulWidget {
  ConnectStripeScreen({super.key});

  @override
  State<ConnectStripeScreen> createState() => _ConnectStripeScreenState();
}

class _ConnectStripeScreenState extends State<ConnectStripeScreen> {
  late HomeController homeController = Get.find<HomeController>();

@override
void initState() {
  super.initState();
  if (WebViewPlatform.instance == null) {
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      WebViewPlatform.instance = WebKitWebViewPlatform();
    } else {
      WebViewPlatform.instance = AndroidWebViewPlatform();
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text(
          'Connect Stripe',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/stripe_icon.png',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Connect your Stripe account\n to start receiving payments",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      // color: Color(0xffFF3951),
                      color: Colors.black,
                      fontFamily: 'outfit',
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WideCustomButton(
                  text: 'Connect with Stripe',
                  onPressed: () async {
                    await Get.find<HomeController>().connectAccount();
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
