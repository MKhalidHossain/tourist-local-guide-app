import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/constants/app_colors.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/core/widgets/wide_custom_button.dart';
import 'package:kobeur/feature/auth/controllers/auth_controller.dart';
import '../../../../../core/validation/validators.dart';
import '../../../../../helpers/custom_snackbar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  // final String emailFocus;

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;

  final FocusNode _emailFocus = FocusNode();

  @override
  void initState() {
    _emailController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This will ensure that the focus is requested after the widget is built
      if (_emailFocus.hasFocus) {
        _emailFocus.requestFocus();
      }
    });
    // _emailFocus.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  bool get isFormValid {
    return Validators.email(_emailController.text) == null;
  }

  @override
  Widget build(BuildContext context) {
    // final focusedBorderColor = AppColors.context(context).primaryColor;
    // const fillColor = AppColors.background;
    // const borderColor = AppColors.secondayText;

    // final defaultPinTheme = PinTheme(
    //   width: 56,
    //   height: 56,
    //   textStyle: TextStyle(fontSize: 22, color: AppColors.primaryTextBlack),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(8),
    //     border: Border.all(color: borderColor),
    //   ),
    // );

    return GetBuilder<AuthController>(
      builder: (AuthController) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: BackButton(color: Colors.black),
            centerTitle: false,
            title: Text(
              "Forgot Password",
              style: TextStyle(
                color: AppColors.primaryTextBlack,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Info Text
                  'Select which contact details should we use to reset your password'
                      .text14Grey(),

                  const SizedBox(height: 28),

                  /// Title
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/images/email.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hint: Text(
                        'Email',
                        style: TextStyle(color: AppColors.secondayText),
                      ),
                      filled: true,
                      fillColor: const Color(0xffC4C4C4).withOpacity(0.25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    onFieldSubmitted:
                        (_) => FocusScope.of(context).requestFocus(_emailFocus),
                    textInputAction: TextInputAction.done,
                    validator: Validators.email,
                    style: TextStyle(
                      color: AppColors.secondayText,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    autofillHints: const [AutofillHints.email],
                  ),

                  const SizedBox(height: 36),

                  /// OTP Input
                  // Pinput(
                  //   length: 6,
                  //   controller: pinController,
                  //   focusNode: focusNode,
                  //   defaultPinTheme: defaultPinTheme,
                  //   hapticFeedbackType: HapticFeedbackType.lightImpact,
                  //   onCompleted: (pin) => debugPrint('Completed: $pin'),
                  //   onChanged: (value) => debugPrint('Changed: $value'),
                  //   focusedPinTheme: defaultPinTheme.copyWith(
                  //     decoration: defaultPinTheme.decoration!.copyWith(
                  //       borderRadius: BorderRadius.circular(8),
                  //       border: Border.all(color: focusedBorderColor),
                  //     ),
                  //   ),
                  //   submittedPinTheme: defaultPinTheme.copyWith(
                  //     decoration: defaultPinTheme.decoration!.copyWith(
                  //       color: fillColor,
                  //       borderRadius: BorderRadius.circular(8),
                  //       border: Border.all(color: focusedBorderColor),
                  //     ),
                  //   ),
                  //   errorPinTheme: defaultPinTheme.copyBorderWith(
                  //     border: Border.all(color: Colors.red),
                  //   ),
                  // ),
                  //const SizedBox(height: 12),

                  /// Resend
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Didn't Receive OTP",
                  //       style: TextStyle(color: AppColors.secondayText),
                  //     ),
                  //     TextButton(
                  //       onPressed: () {
                  //         // Resend logic here
                  //       },
                  //       child: Text(
                  //         "RESEND OTP",
                  //         style: TextStyle(
                  //           color: AppColors.context(context).primaryColor,
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //const SizedBox(height: 4),
                  WideCustomButton(
                    text: 'Continue',
                    onPressed: () {
                      final fEmail = _emailController.text;
                      if (fEmail.isEmpty) {
                        Get.snackbar(
                          'Enter a valid Email',
                          'email is required'.tr,
                        );
                      }
                      //  else if (fEmail.isEmail) {
                      //   Get.snackbar(
                      //     'Envalid email',
                      //     'Entered email is not valid'.tr,
                      //   );
                      // }
                      else {
                        AuthController.forgetPassword(fEmail);
                      }
                    },

                    buttonColor:
                        isFormValid
                            ? AppColors.context(context).primaryColor
                            : AppColors.secondaryColor,
                  ),

                  // context.primaryButton(
                  //   onPressed: () {
                  //     // final otp = pinController.text;
                  //     // if (otp.length == 6) {
                  //     //   Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(builder: (context) => Scaffold()),
                  //     //   );
                  //     // } else {
                  //     //   ScaffoldMessenger.of(context).showSnackBar(
                  //     //     const SnackBar(
                  //     //       content: Text('Please enter a valid 6-digit code.'),
                  //     //     ),
                  //     //   );
                  //     // }
                  //   },
                  //   text: "Continue",
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
