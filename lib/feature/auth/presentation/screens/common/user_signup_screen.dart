import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/common/button/button_widget.dart';
import 'package:kobeur/feature/auth/controllers/auth_controller.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/validation/validators.dart';
import '../../../../../core/widgets/app_logo.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/or_divider_with_circle_widget.dart';
import '../../../../../helpers/custom_snackbar.dart';
import 'user_login_screen.dart';

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({super.key});

  @override
  State<UserSignupScreen> createState() => UserSignupScreenState();
}

class UserSignupScreenState extends State<UserSignupScreen> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    // Add listener to scroll when keyboard appears
    _emailFocus.addListener(_scrollToShowButton);
    _passwordFocus.addListener(_scrollToShowButton);
    _confirmPasswordFocus.addListener(_scrollToShowButton);

    super.initState();
  }

  void _scrollToShowButton() {
    if (_emailFocus.hasFocus ||
        _passwordFocus.hasFocus ||
        _confirmPasswordFocus.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _scrollController.dispose();
    // Remove listeners to prevent memory leaks
    _emailFocus.removeListener(_scrollToShowButton);
    _passwordFocus.removeListener(_scrollToShowButton);
    _confirmPasswordFocus.removeListener(_scrollToShowButton);
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return AppScaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 80,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              AppLogo(),
                              const SizedBox(height: 32),
                              Center(
                                child: Text(
                                  "Get Started",
                                  style: TextStyle(
                                    color: AppColors.context(context).textColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'by creating a free account',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Email Field
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
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: AppColors.secondayText,
                                  ),
                                  filled: true,
                                  fillColor: const Color(
                                    0xffC4C4C4,
                                  ).withOpacity(0.25),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onFieldSubmitted:
                                    (_) => FocusScope.of(
                                      context,
                                    ).requestFocus(_passwordFocus),
                                textInputAction: TextInputAction.next,
                                validator: Validators.email,
                              ),
                              const SizedBox(height: 16),

                              // Password Field
                              TextFormField(
                                controller: _passwordController,
                                focusNode: _passwordFocus,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      'assets/images/password.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: AppColors.secondayText,
                                  ),
                                  filled: true,
                                  fillColor: const Color(
                                    0xffC4C4C4,
                                  ).withOpacity(0.25),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onFieldSubmitted:
                                    (_) => FocusScope.of(
                                      context,
                                    ).requestFocus(_confirmPasswordFocus),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Confirm Password Field
                              TextFormField(
                                controller: _confirmPasswordController,
                                focusNode: _confirmPasswordFocus,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      'assets/images/password.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(
                                    color: AppColors.secondayText,
                                  ),
                                  filled: true,
                                  fillColor: const Color(
                                    0xffC4C4C4,
                                  ).withOpacity(0.25),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onFieldSubmitted:
                                    (_) => FocusScope.of(context).unfocus(),
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please repeat your password';
                                  } else if (value !=
                                      _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Sign Up Button (now stays visible when keyboard appears)
                              context.primaryButton(
                                onPressed: () {
                                  String email = _emailController.text;
                                  String password = _passwordController.text;
                                  String confirmPassword =
                                      _confirmPasswordController.text;

                                  if (email.isEmpty) {
                                    showCustomSnackBar('email is required'.tr);
                                  } else if (password.isEmpty ||
                                      confirmPassword.isEmpty) {
                                    showCustomSnackBar(
                                      'Password and confirm password are required'
                                          .tr,
                                    );
                                  } else if (password.length < 6) {
                                    showCustomSnackBar(
                                      'Password must be at least 6 characters',
                                    );
                                  } else if (password != confirmPassword) {
                                    showCustomSnackBar(
                                      'Passwords do not match',
                                    );
                                  } else {
                                    authController.register(
                                      email,
                                      password,
                                      confirmPassword,
                                    );
                                  }
                                },
                                text: "Sign up",
                              ),
                              const SizedBox(height: 24),
                              OrDividerWithCircle(),
                              const SizedBox(height: 16),

                              // Google Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/google.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  label: Text("Continue With Google"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.background,
                                    foregroundColor: AppColors.primaryTextBlack,
                                    elevation: 1,
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Apple Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/apple.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  label: Text("Continue With Apple"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.context(
                                          context,
                                        ).backgroundColor,
                                    foregroundColor:
                                        AppColors.context(context).primaryColor,
                                    elevation: 1,
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 60),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Fixed "Already have an account?" at bottom
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          MediaQuery.of(context).viewInsets.bottom > 0
                              ? MediaQuery.of(context).viewInsets.bottom
                              : 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: AppColors.primaryTextBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(UserLoginScreen()),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: AppColors.context(context).primaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kobeur/core/common/button/button_widget.dart';
// import 'package:kobeur/feature/auth/controllers/auth_controller.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/validation/validators.dart';
// import '../../../../../core/widgets/app_logo.dart';
// import '../../../../../core/widgets/app_scaffold.dart';
// import '../../../../../core/widgets/or_divider_with_circle_widget.dart';
// import '../../../../../helpers/custom_snackbar.dart';
// import 'user_login_screen.dart';

// class UserSignupScreen extends StatefulWidget {
//   const UserSignupScreen({super.key});

//   @override
//   State<UserSignupScreen> createState() => UserSignupScreenState();
// }

// class UserSignupScreenState extends State<UserSignupScreen> {
//   final FocusNode _emailFocus = FocusNode();
//   final FocusNode _passwordFocus = FocusNode();
//   final FocusNode _confirmPasswordFocus = FocusNode();

//   late TextEditingController _emailController;
//   late TextEditingController _passwordController;
//   late TextEditingController _confirmPasswordController;

//   @override
//   void initState() {
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//     _confirmPasswordController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return GetBuilder<AuthController>(
//       builder: (authController) {
//         return AppScaffold(
//           body: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 12.0),
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints(minHeight: size.height),
//                       child: IntrinsicHeight(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const SizedBox(height: 40),
//                             AppLogo(),
//                             const SizedBox(height: 32),
//                             Center(child: Text("Get Started")),
//                             Center(
//                               child: Text(
//                                 'by creating a free account',
//                                 style: TextStyle(
//                                   color: AppColors.primaryTextBlack,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 12),

//                             /// Email
//                             TextFormField(
//                               controller: _emailController,
//                               focusNode: _emailFocus,
//                               keyboardType: TextInputType.emailAddress,
//                               decoration: InputDecoration(
//                                 prefixIcon: Padding(
//                                   padding: EdgeInsets.all(12.0),
//                                   child: Image.asset(
//                                     'assets/images/email.png',
//                                     width: 24,
//                                     height: 24,
//                                   ),
//                                 ),
//                                 hint: Text(
//                                   'Email',
//                                   style: TextStyle(
//                                     color: AppColors.primaryTextBlack,
//                                   ),
//                                 ),
//                               ),
//                               onFieldSubmitted:
//                                   (_) => FocusScope.of(
//                                     context,
//                                   ).requestFocus(_passwordFocus),
//                               textInputAction: TextInputAction.done,
//                               validator: Validators.email,
//                               style: TextStyle(
//                                 color: AppColors.secondayText,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               autofillHints: const [AutofillHints.email],
//                             ),
//                             const SizedBox(height: 12),

//                             /// Password
//                             TextFormField(
//                               controller: _passwordController,
//                               focusNode: _passwordFocus,
//                               keyboardType: TextInputType.emailAddress,
//                               obscureText: true,
//                               decoration: InputDecoration(
//                                 prefixIcon: Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: Image.asset(
//                                     'assets/images/password.png',
//                                     width: 24,
//                                     height: 24,
//                                   ),
//                                 ),
//                                 hint: Text(
//                                   'Password',
//                                   style: TextStyle(
//                                     color: AppColors.primaryTextBlack,
//                                   ),
//                                 ),
//                               ),
//                               onFieldSubmitted:
//                                   (_) => FocusScope.of(
//                                     context,
//                                   ).requestFocus(_passwordFocus),
//                               textInputAction: TextInputAction.done,
//                               //validator: Validators.email,
//                               style: TextStyle(
//                                 color: AppColors.secondayText,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               autofillHints: const [AutofillHints.password],
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter a password';
//                                 } else if (value.length < 6) {
//                                   return 'Password must be at least 6 characters';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 12),
//                             TextFormField(
//                               controller: _confirmPasswordController,
//                               focusNode: _confirmPasswordFocus,
//                               keyboardType: TextInputType.emailAddress,
//                               obscureText: true,
//                               decoration: InputDecoration(
//                                 prefixIcon: Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: Image.asset(
//                                     'assets/images/password.png',
//                                     width: 24,
//                                     height: 24,
//                                   ),
//                                 ),
//                                 hint: Text(
//                                   'Confirm Password',
//                                   style: TextStyle(
//                                     color: AppColors.primaryTextBlack,
//                                   ),
//                                 ),
//                               ),
//                               onFieldSubmitted:
//                                   (_) => FocusScope.of(
//                                     context,
//                                   ).requestFocus(_passwordFocus),
//                               textInputAction: TextInputAction.done,
//                               //validator: Validators.email,
//                               style: TextStyle(
//                                 color: AppColors.secondayText,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               // autofillHints: const [AutofillHints.email],
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please repeat your password';
//                                 } else if (value !=
//                                     _confirmPasswordController.text) {
//                                   return 'Passwords do not match';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 16),
//                             // TextFormField(
//                             //   keyboardType: TextInputType.emailAddress,
//                             //   decoration: InputDecoration(
//                             //     prefixIcon: Padding(
//                             //       padding: const EdgeInsets.all(12.0),
//                             //       child: Image.asset(
//                             //         'assets/images/password.png',
//                             //         width: 24,
//                             //         height: 24,
//                             //       ),
//                             //     ),
//                             //     hint: Text(
//                             //       'Confirm Password',
//                             //       style: TextStyle(color: AppColors.secondayText),
//                             //     ),
//                             //     onFieldSubmitted:
//                             //         (_) => FocusScope.of(
//                             //           context,
//                             //         ).requestFocus(_passwordFocus),
//                             //     textInputAction: TextInputAction.done,
//                             //     //validator: Validators.email,
//                             //     style: TextStyle(
//                             //       color: AppColors.secondayText,
//                             //       fontSize: 16,
//                             //       fontWeight: FontWeight.w400,
//                             //     ),
//                             //     autofillHints: const [AutofillHints.email],
//                             //   ),
//                             //   const SizedBox(height: 16),

//                             /// Sign Up button
//                             context.primaryButton(
//                               onPressed: () {
//                                 String email = _emailController.text;
//                                 String password = _passwordController.text;
//                                 String confirmPassword =
//                                     _confirmPasswordController.text;

//                                 if (email.isEmpty) {
//                                   showCustomSnackBar('email is required'.tr);
//                                 } else if (password.isEmpty &&
//                                     confirmPassword.isEmpty) {
//                                   showCustomSnackBar(
//                                     'Password  and confirm password is required'
//                                         .tr,
//                                   );
//                                 } else if (password.length < 5) {
//                                   showCustomSnackBar(
//                                     'minimum password length is 8',
//                                   );
//                                 } else if (password != confirmPassword) {
//                                   showCustomSnackBar('Passwords do not match');
//                                 } else {
//                                   authController.register(
//                                     email,
//                                     password,
//                                     confirmPassword,
//                                   );
//                                 }
//                               },
//                               text: "Sign up",
//                               backgroundColor:
//                                   AppColors.context(context).primaryColor,
//                             ),
//                             const SizedBox(height: 16),
//                             OrDividerWithCircle(),
//                             const SizedBox(height: 16),

//                             /// Google
//                             SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton.icon(
//                                 onPressed: () {},
//                                 icon: Image.asset(
//                                   'assets/images/google.png',
//                                   height: 24,
//                                   width: 24,
//                                 ),
//                                 label: Text(
//                                   "Continue With Google",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: AppColors.background,
//                                   foregroundColor: AppColors.primaryTextBlack,
//                                   elevation: 1,
//                                   padding: EdgeInsets.symmetric(vertical: 16),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     side: BorderSide(
//                                       color: Colors.grey,
//                                       width: 1,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 12),

//                             /// Apple
//                             SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton.icon(
//                                 onPressed: () {},
//                                 icon: Image.asset(
//                                   'assets/images/apple.png',
//                                   height: 24,
//                                   width: 24,
//                                 ),
//                                 label: Text(
//                                   "Continue With Apple",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor:
//                                       AppColors.context(
//                                         context,
//                                       ).backgroundColor,
//                                   foregroundColor:
//                                       AppColors.context(context).primaryColor,
//                                   elevation: 1,
//                                   padding: EdgeInsets.symmetric(vertical: 16),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     side: BorderSide(
//                                       color: Colors.grey,
//                                       width: 1,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Already have an account? ",
//                       style: TextStyle(
//                         color: AppColors.primaryTextBlack,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Get.to(UserLoginScreen());
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) =>
//                         //   ),
//                         // );
//                       },
//                       child: Text(
//                         'Sign in',
//                         style: TextStyle(
//                           color: AppColors.context(context).primaryColor,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
