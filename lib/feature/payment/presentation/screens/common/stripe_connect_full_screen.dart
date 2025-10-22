import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/constants/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../../../utils/display_helper.dart';
import '../../../../offer/presentation/screens/common/create_first_service_screen.dart';

class StripeConnectFullScreen extends StatefulWidget {
  final String connectUrl;

  const StripeConnectFullScreen({super.key, required this.connectUrl});

  @override
  State<StripeConnectFullScreen> createState() =>
      _StripeConnectFullScreenState();
}

class _StripeConnectFullScreenState extends State<StripeConnectFullScreen> {
  late final WebViewController _controller;
  bool isLoading = true;
  String statusMessage = "Initializing WebView...";

  @override
  void initState() {
    super.initState();

    // ✅ For iOS WKWebView
    WebViewPlatform.instance = WebKitWebViewPlatform();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(AppColors.background)
          ..enableZoom(true)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                debugPrint("➡️ Loading started: $url");
                setState(() {
                  isLoading = true;
                  statusMessage = "Loading...";
                });
              },
              onPageFinished: (url) {
                debugPrint("✅ Finished loading: $url");
                setState(() {
                  isLoading = false;
                  statusMessage = "Page loaded";
                });
              },
              onWebResourceError: (error) {
                final msg = "❌ WebView error: ${error.description}";
                debugPrint(msg);
                showCustomSnackBar(msg, isError: true);
                setState(() => statusMessage = msg);
              },
              onNavigationRequest: (request) {
                final url = request.url;
                debugPrint("🔗 Navigating to: $url");
                setState(() => statusMessage = url);

                // ✅ Handle Stripe deep link return (custom scheme)
                if (url.startsWith('kobeur://stripe_return')) {
                  debugPrint('✅ Stripe returned to app via deep link!');
                  showCustomSnackBar("Stripe account connected successfully!");
                  Get.offAll(() => CreateFirstServiceScreen());
                  return NavigationDecision.prevent;
                }

                // ✅ Optional: handle cancel URLs
                if (url.contains('stripe/cancel')) {
                  showCustomSnackBar(
                    "Stripe onboarding cancelled!",
                    isError: true,
                  );
                  Get.back();
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.connectUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Stripe Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading) const Center(child: CircularProgressIndicator()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Colors.black.withOpacity(0.6),
              child: Text(
                statusMessage,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kobeur/core/constants/app_colors.dart';

// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// import '../../../../../utils/display_helper.dart';
// import '../../../../offer/presentation/screens/common/create_first_service_screen.dart';

// // Example custom snackbar (replace with your own global helper if you already have one)

// class StripeConnectFullScreen extends StatefulWidget {
//   final String connectUrl;

//   const StripeConnectFullScreen({super.key, required this.connectUrl});

//   @override
//   State<StripeConnectFullScreen> createState() =>
//       _StripeConnectFullScreenState();
// }

// class _StripeConnectFullScreenState extends State<StripeConnectFullScreen> {
//   late final WebViewController _controller;
//   bool isLoading = true;
//   String statusMessage = "Initializing WebView...";

//   @override
//   void initState() {
//     super.initState();

//     // ✅ For iOS WKWebView (already set globally in main.dart ideally)
//     WebViewPlatform.instance = WebKitWebViewPlatform();

//     _controller =
//         WebViewController()
//           ..setJavaScriptMode(JavaScriptMode.unrestricted)
//           ..setBackgroundColor(AppColors.background)
//           ..enableZoom(true)
//           // ..setUserAgent(
//           //   "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile Safari/605.1.15",
//           // )
//           ..setNavigationDelegate(
//             NavigationDelegate(
//               onPageStarted: (url) {
//                 final msg = "➡️ Loading started: $url";
//                 debugPrint(msg);
//                 // showCustomSnackBar(msg);
//                 setState(() {
//                   isLoading = true;
//                   statusMessage = msg;
//                 });
//               },
//               onPageFinished: (url) {
//                 final msg = "✅ Finished loading: $url";
//                 debugPrint(msg);
//                 showCustomSnackBar(msg);
//                 setState(() {
//                   isLoading = false;
//                   statusMessage = msg;
//                 });
//               },
//               onWebResourceError: (error) {
//                 final msg = "❌ WebView error: ${error.description}";
//                 debugPrint(msg);
//                 showCustomSnackBar(msg, isError: true);
//                 setState(() => statusMessage = msg);
//               },
//               onNavigationRequest: (request) {
//                 final url = request.url;
//                 final msg = "🔗 Navigating to: $url";
//                 debugPrint(msg);
//                 // showCustomSnackBar(msg);
//                 setState(() => statusMessage = msg);

//                 if (url.contains('stripe/success')) {
//                   final successMsg = "✅ Stripe connection successful!";
//                   debugPrint(successMsg);
//                   showCustomSnackBar(successMsg);
//                   Get.offAll(() => CreateFirstServiceScreen());
//                   return NavigationDecision.prevent;
//                 } else if (url.contains('stripe/cancel')) {
//                   final cancelMsg = "🚫 Stripe onboarding cancelled!";
//                   debugPrint(cancelMsg);
//                   showCustomSnackBar(cancelMsg, isError: true);
//                   Get.back();
//                   return NavigationDecision.prevent;
//                 }

//                 return NavigationDecision.navigate;
//               },
//             ),
//           )
//           ..loadRequest(Uri.parse(widget.connectUrl));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Connect Stripe Account'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: _controller),

//           // ✅ Loading spinner
//           if (isLoading) const Center(child: CircularProgressIndicator()),

//           // ✅ WebView status overlay (always visible at bottom)
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               color: Colors.black.withOpacity(0.6),
//               child: Text(
//                 statusMessage,
//                 style: const TextStyle(color: Colors.white, fontSize: 13),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
