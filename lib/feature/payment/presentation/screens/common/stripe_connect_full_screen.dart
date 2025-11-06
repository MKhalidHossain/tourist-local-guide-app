import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/constants/app_colors.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';
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
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();

    // ✅ For iOS WKWebView (required for newer versions)
    WebViewPlatform.instance = WebKitWebViewPlatform();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.background)
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint("➡️ Loading started: $url");
            if (!mounted) return;
            setState(() {
              isLoading = true;
              statusMessage = "Loading...";
            });
          },
          onPageFinished: (url) {
            debugPrint("✅ Finished loading: $url");
            if (!mounted) return;
            setState(() {
              isLoading = false;
              statusMessage = "Page loaded";
            });
          },
          onWebResourceError: (error) {
            final msg = "❌ WebView error: ${error.description}";
            debugPrint(msg);
            showCustomSnackBar(msg, isError: true);
            if (!mounted) return;
            setState(() => statusMessage = msg);
          },
          onNavigationRequest: (request) {
            final url = request.url;
            debugPrint("🔗 Navigating to: $url");

            final uri = Uri.tryParse(url);
            final status = uri?.queryParameters['status'];

            if (status == 'success') {
              final successMsg = "✅ Stripe connection successful!";
              debugPrint(successMsg);
              showCustomSnackBar(successMsg);

              if (!mounted) return NavigationDecision.prevent;
              setState(() => isLoading = true);

              // 🔹 Call validateAccount() (does not return anything)
              try {
                homeController.validateAccount(
                  homeController.connectAccountResponseModel.data?.accountId ?? "",
                );
              } catch (e) {
                debugPrint('Validation error: $e');
                showCustomSnackBar('Validation error', isError: true);
              }

              // ✅ Continue to next screen
              if (!mounted) return NavigationDecision.prevent;
              setState(() => isLoading = false);
              Get.offAll(() => CreateFirstServiceScreen());

              return NavigationDecision.prevent;
            } else if (status == 'cancel') {
              final cancelMsg = "🚫 Stripe onboarding cancelled!";
              debugPrint(cancelMsg);
              showCustomSnackBar(cancelMsg, isError: true);
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

          // ✅ Loading indicator
          if (isLoading) const Center(child: CircularProgressIndicator()),

          // ✅ Status overlay (bottom)
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
// import 'package:kobeur/feature/home/controllers/home_controller.dart';

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
//   late HomeController homeController;

//   @override
//   void initState() {
//     super.initState();
//     homeController = Get.find<HomeController>();

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

//                 // if (url.contains('stripe/success')) {
//                 if (url.endsWith('status=success')) {
//                   final successMsg = "✅ Stripe connection successful!";
//                   debugPrint(successMsg);
//                   showCustomSnackBar(successMsg);
//                   // Get.offAll(() => CreateFirstServiceScreen());
//                   // start async validation but don't await here (onNavigationRequest must return sync)
//                   setState(() => isLoading = true);

//                   homeController
//                       .validateAccount(
//                         homeController
//                             .connectAccountResponseModel
//                             .data!
//                             .accountId
//                             .toString(),
//                       )
//                       // .then((isValid) {
//                       //   setState(() => isLoading = false);
//                       //   // if (isValid == true) {
//                       //   //   final successMsg2 = "✅ Account validated, continuing...";
//                       //   //   debugPrint(successMsg2);
//                       //   //   showCustomSnackBar(successMsg2);
//                       //   //   // navigate after successful validation
//                       //   //   Get.offAll(() => CreateFirstServiceScreen());
//                       //   // } else {
//                       //   //   final failMsg = "⚠️ Account validation failed";
//                       //   //   debugPrint(failMsg);
//                       //   //   showCustomSnackBar(failMsg, isError: true);
//                       //   //   // optionally: Get.back();
//                       //   // }
//                       // })
//                       .catchError((e) {
//                         setState(() => isLoading = false);
//                         debugPrint('Validation error: $e');
//                         showCustomSnackBar('Validation error', isError: true);
//                       });

//                   return NavigationDecision.prevent;

//                   // return NavigationDecision.prevent;
//                   // } else if (url.contains('stripe/cancel')) {
//                 } else if (url.contains('status=cencel')) {
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
