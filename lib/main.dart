import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/constants/splash_screen.dart';
import 'package:kobeur/core/constants/splash_screen_without_loading.dart';
import 'package:kobeur/feature/auth/controllers/auth_controller.dart';
import 'package:kobeur/feature/auth/presentation/screens/common/user_login_screen.dart';
import 'package:kobeur/helpers/dependency_injection.dart';
import 'package:kobeur/navigation/bottom_navigationber_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      'pk_test_51S6pMbRZVOYD6qjBukBi2VyPiTtIhzAyYzmfyAo4izzIwemOo7I3fUYELhxmTJeNln7zMiztFA4CKihsybqrJlo800nWzvIXZY';

  // Stripe.merchantIdentifier = 'merchant.kobeur.app';
  // Stripe.urlScheme = 'flutterstripe';

  await Stripe.instance.applySettings();

  /// ✅ Apply full Stripe settings

  await initDI();
  //final authController = Get.find<AuthController>();
  // final authController = Get.find<AuthController>();
  runApp(MyApp());
}

// http://localhost:5001/api/v1
class MyApp extends StatelessWidget {
  // final bool isFirstTimeInstall;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kobeur',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffF5F5F5)),
      ),
      home: const SplashScreen(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final profileController = Get.find<ProfileController>();
  final authController = Get.find<AuthController>();

  bool isLoading = true;
  bool? isFirstTime;
  // String? userRole;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    setState(() => isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('first_time') ?? true;

    if (isFirstTime!) {
      await prefs.setBool('first_time', false);
    }

    final authController = Get.find<AuthController>();
    isLoggedIn = authController.isLoggedIn();

    debugPrint('isFirstTime: $isFirstTime, isLoggedIn: $isLoggedIn');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SplashScreenWithoutLoading();
    }
    return GetBuilder<AuthController>(
      builder: (authController) {
        if (authController.isLoggedIn()) {
          final role = authController.getUserRole();
          print('Retrieved userRole: $role');
          if (role == null || role.isEmpty) {
            return UserLoginScreen();
          }
          print(
            'User is logged in, navigating to userRole: ${authController.userRole} \n\n\n\n ',
          );
          return BottomNavbar(userRole: role);
        }
        return UserLoginScreen();
      },
    );
  }
}
