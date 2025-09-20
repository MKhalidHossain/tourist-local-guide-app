import 'package:flutter/material.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import '../widgets/app_logo.dart';
import '../widgets/app_scaffold.dart';
//import '../widgets/app_scaffold.dart';

class SplashScreenWithoutLoading extends StatelessWidget {
  const SplashScreenWithoutLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppScaffold(
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height),
            child: IntrinsicHeight(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      MainAxisAlignment.center, // 🔥 Center vertically
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    AppLogo(),
                    // const SizedBox(height: 32),
                    "Explore like a local".text20Black(),
                  ],
                ),
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
// import 'package:kobeur/core/extensions/text_extensions.dart';
// import '../widgets/app_logo.dart';
// import '../widgets/app_scaffold.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key,});

//   @override
//   State<SplashScreen> createState() => SplashScreenState();
// }

// class SplashScreenState extends State<SplashScreen> {

//     void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 3), () {

//     });
//   }




//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return AppScaffold(
//       body: Column(
//         children: [
//           ConstrainedBox(
//             constraints: BoxConstraints(minHeight: size.height),
//             child: IntrinsicHeight(
//               child: Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment:
//                       MainAxisAlignment.center, // 🔥 Center vertically
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 40),
//                     AppLogo(),
//                     // const SizedBox(height: 32),
//                     "Explore like a local".text20Black(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
