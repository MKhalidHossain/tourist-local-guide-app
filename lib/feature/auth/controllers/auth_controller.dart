import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/feature/auth/presentation/screens/common/change_password_screen.dart';
import 'package:kobeur/feature/auth/presentation/screens/common/user_login_screen.dart';
import 'package:kobeur/feature/auth/presentation/screens/common/user_signup_screen.dart';
import 'package:kobeur/feature/auth/presentation/screens/common/verify_otp_screen.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';
import 'package:kobeur/feature/profile/presentation/screens/account_settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helpers/custom_snackbar.dart';
import '../../../helpers/remote/data/api_checker.dart';
import '../../../helpers/remote/data/api_client.dart';
import '../../../navigation/bottom_navigationber_screen.dart';
import '../../offer/presentation/screens/create_first_service_screen.dart';
import '../../profile/controllers/profile_controller.dart';
import '../domain/common/model/login_response_model.dart';
import '../domain/common/model/registration_response_model.dart';
import '../presentation/screens/common/language_picker_screen.dart';
import '../presentation/screens/common/tourist_or_local_screen.dart';
import '../sevices/tourist/auth_service_interface.dart';

class AuthController extends GetxController implements GetxService {
  ProfileController get profileController => Get.find<ProfileController>();
  HomeController get localHomeTripController => Get.find<HomeController>();

  // Avoid calling Get.find in constructor or onInit
  void someMethod() {
    // Access ProfileController only when needed
    print(profileController.userRole);
  }

  final AuthServiceInterface authServiceInterface;

  AuthController({required this.authServiceInterface});

  bool changePasswordIsLoading = false;

  bool _isLoading = false;
  bool _acceptTerms = false;
  bool get isLoading => _isLoading;
  bool get acceptTerms => _acceptTerms;
  final String _mobileNumber = '';
  String get mobileNumber => _mobileNumber;
  XFile? _pickedProfileFile;
  XFile? get pickedProfileFile => _pickedProfileFile;
  XFile identityImage = XFile('');
  List<XFile> identityImages = [];
  List<MultipartBody> multipartList = [];
  String countryDialCode = '+880';
  String email = '';

  bool isLoadingforProfile = false;
  bool? isFirstTime;
  String? userRole;
  bool isLoggedInforProfile = false;
  bool haveOffer = false;

  void setCountryCode(String code) {
    countryDialCode = code;
    update();
  }

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();

  FocusNode fNameNode = FocusNode();
  FocusNode lNameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode identityNumberNode = FocusNode();

  LogInResponseModel? logInResponseModel;
  RegistrationResponseModel? registrationResponseModel;

  onInit() {
    super.onInit();
    //_loadUserRole()
  }

  // VerifyCodeResponseModel? verifyCodeResponseModel;
  // ChangePasswordResponseModel? changePasswordResponseModel;
  // ForgetPasswordResponseModel? forgetPasswordResponseModel;
  // Future<void> _initApp() async {
  //   isLoadingforProfile = true;

  //   final prefs = await SharedPreferences.getInstance();
  //   isFirstTime = prefs.getBool('first_time') ?? true;

  //   if (isFirstTime!) {
  //     await prefs.setBool('first_time', false);
  //     Get.lazyPut(() => ProfileStorageService());
  //   }

  //   final authController = Get.find<AuthController>();
  //   isLoggedInforProfile = authController.isLoggedIn();

  //   debugPrint('isFirstTime: $isFirstTime, isLoggedIn: $isLoggedIn');

  //   if (isLoggedInforProfile) {
  //     await _loadUserRole();
  //   }

  //   isLoadingforProfile = false;
  // }

  Future<void> _checkIsFirstOffer() async {
    await localHomeTripController.getBookingsAll();
    haveOffer =
        localHomeTripController.getTripResponseApiBookingsModel.data?.length ==
                0
            ? false
            : true;
    debugPrint(
      'Loaded Local Offer Count is : ${localHomeTripController.getTripResponseApiBookingsModel.data?.length}',
    );
    update();
  }

  Future<void> _loadUserRole() async {
    await profileController.getUserProfile();
    userRole = profileController.getProfileResponseModel?.data?.role;
    if (userRole == null || userRole!.isEmpty) {
      userRole = await authServiceInterface.getUserRole();
    }
    debugPrint('Loaded User Role: $userRole');
    update();
  }

 

  void addImageAndRemoveMultiParseData() {
    multipartList.clear();
    identityImages.clear();
    update();
  }

  void pickImage(bool isBack, bool isProfile) async {
    if (isProfile) {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        _pickedProfileFile = pickedFile;
      }
    } else {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        identityImage = pickedFile;
        identityImages.add(identityImage);
        multipartList.add(MultipartBody('identity_images[]', identityImage));
      }
    }
    update();
  }

  void removeImage(int index) {
    identityImages.removeAt(index);
    multipartList.removeAt(index);
    update();
  }

  final List<String> _identityTypeList = ['passport', 'driving_license', 'nid'];
  List<String> get identityTypeList => _identityTypeList;
  String _identityType = '';
  String get identityType => _identityType;

  void setIdentityType(String setValue) {
    _identityType = setValue;
    update();
  }

  Future<void> register(
    String email,
    String password,
    String confirmPassword,
  ) async {
    _isLoading = true;
    update();
    print(
      "REGISTER API BODY: {email: $email, password: $password, confirmPassword: $confirmPassword}",
    );
    try {
      Response? response = await authServiceInterface.register(
        email,
        password,
        confirmPassword,
      );
      if (response!.statusCode == 201) {
        registrationResponseModel = RegistrationResponseModel.fromJson(
          response.body,
        );

        String token = registrationResponseModel!.data!.accessToken!;
        String refreshToken = registrationResponseModel!.data!.refreshToken!;
        print(
          "REGISTER API BODY: {email: $email, password: $password, confirmPassword: $confirmPassword}",
        );

        debugPrint("Register tokens - Access: $token, Refresh: $refreshToken");

        await setUserToken(token, refreshToken);

        Get.off(() => TouristORLocalScreen());
        showCustomSnackBar('Welcome you have successfully Registered');
      } else {
        _isLoading = false;
        ApiChecker.checkApi(response);
        if (response.statusCode == 400) {
          showCustomSnackBar(
            response.body['message'] ?? 'Something went wrong',
            isError: true,
          );
        } else {
          showCustomSnackBar(
            response.body['message'] ??
                "Registration failed. Please try again.",
            isError: true,
          );
        }
        print(
          ' ❌ Registration failed: ${response.statusCode} ${response.body} ',
        );
      }
      update();
    } catch (e) {
      _isLoading = false;
      print("❌ Error during registration: $e");
      showCustomSnackBar(
        "Something went wrong. Please try again later.",
        isError: true,
      );
    }
  }

  // Future<void> login(String email, String password) async {
  //   _isLoading = true;
  //   update();
  //   print("LOGIN API BODY: {email: $email, password: $password}");

  //   try {
  //     Response? response = await authServiceInterface.login(email, password);

  //     if (response == null) {
  //       _isLoading = false;
  //       update();
  //       print("❌ No response from server");
  //       showCustomSnackBar("No response from server", isError: true);
  //       return;
  //     }

  //     if (response.statusCode == 200) {
  //       // Successful login
  //       logInResponseModel = LogInResponseModel.fromJson(response.body);

  //       final String refreshToken = logInResponseModel!.data!.refreshToken!;
  //       final String token = logInResponseModel!.data!.accessToken!;

  //       print(
  //         "LOGIN SUCCESS: AccessToken: $token, RefreshToken: $refreshToken",
  //       );

  //       await setUserToken(token, refreshToken);
  //       await _loadUserRole();

  //       authServiceInterface.chooseRole(userRole!, token);

  //       // Navigate based on user role
  //       if (userRole != null && userRole!.isNotEmpty) {
  //         final role = userRole!.toLowerCase();
  //         if (role == 'tourist') {
  //           Get.offAll(() => BottomNavbar(userRole: userRole));
  //         } else if (role == 'local') {
  //           Get.offAll(() => CreateFirstServiceScreen());
  //         } else {
  //           showCustomSnackBar(
  //             'You have not selected your role yet, please select your role',
  //             isError: true,
  //           );
  //         }
  //       } else {
  //         showCustomSnackBar(
  //           'You have not selected your role yet, please select your role',
  //           isError: true,
  //         );
  //         Get.offAll(() => UserLoginScreen());
  //       }

  //       showCustomSnackBar('Welcome, you have successfully Logged In');
  //     } else if (response.statusCode == 202) {
  //       // Optional: handle unverified phone
  //       final isPhoneVerified = response.body['data']['is_phone_verified'];
  //       if (isPhoneVerified == 0) {
  //         print("❌ Phone not verified");
  //         showCustomSnackBar('Please verify your phone first', isError: true);
  //       }
  //     } else if (response.statusCode == 401) {
  //       print("❌ Unauthorized login attempt");
  //       showCustomSnackBar(
  //         "Sorry, you don't have an account. Please create an account.",
  //         isError: true,
  //       );
  //       Get.offAll(() => UserSignupScreen());
  //     } else {
  //       // Any other API error
  //       print('❌ Login failed: ${response.statusCode} ${response.body}');
  //       ApiChecker.checkApi(response);
  //       showCustomSnackBar(
  //         response.body['message'] ?? "Login failed. Please try again.",
  //         isError: true,
  //       );
  //     }
  //   } catch (e) {
  //     _isLoading = false;
  //     print("❌ Error during login: $e");
  //     showCustomSnackBar(
  //       "Something went wrong. Please try again later.",
  //       isError: true,
  //     );
  //   } finally {
  //     _isLoading = false;
  //     update();
  //   }
  // }

  //testing to commnet this main file can not remove this

  Future<void> login(String email, String password) async {
    _isLoading = true;
    update();

    Response? response = await authServiceInterface.login(email, password);

    if (response == null) {
      print("No response found");
    }
    if (response!.statusCode == 200) {
      logInResponseModel = LogInResponseModel.fromJson(response.body);

      final String refreshToken = logInResponseModel!.data!.refreshToken!;
      final String token = logInResponseModel!.data!.accessToken!;

      print(
        'accessToken ${logInResponseModel!.data!.accessToken}} NOW for you Kobeur \n ',
      );
      print('refreshToken $refreshToken NOW Iwalker');
      print(
        'User Token $token  ================================== from comtroller ',
      );
      await setUserToken(token, refreshToken);
      update();

      debugPrint("Login tokens - Access: $token,\n Refresh: $refreshToken");

      await _loadUserRole();
      debugPrint("✅ Access Token: $token\n");
      debugPrint("✅ Refresh Token: $refreshToken\n");
      debugPrint("✅ User Role: $userRole\n");

      debugPrint(
        'the role of user  $userRole \n\n\n\n\n\n\n\n\n\n\n\nToken $token  ================================== from controller ',
      );

      // for Nevigation to Tourist or Local
      if (userRole != null && userRole!.isNotEmpty) {
        final role = userRole!;
        print('User Role after login for store: $role');
        await saveUserRole(role);
        if (userRole.toString().toLowerCase() == 'tourist') {
          debugPrint(
            'User Role: $userRole ================================= from Auth controller after login \n\n\n\n\n\n\n',
          );
          Get.offAll(() => BottomNavbar(userRole: userRole));
        } else if (userRole.toString().toLowerCase() == 'local') {
          _checkIsFirstOffer().then((_) {
            haveOffer
                ? Get.offAll(() => BottomNavbar(userRole: userRole))
                : Get.offAll(() => CreateFirstServiceScreen());
          });
        } else {
          showCustomSnackBar(
            'You have not selected your role yet, please select your role',
            isError: true,
          );
        }
      } else {
        showCustomSnackBar(
          'You have not selected your role yet, please select your role',
          isError: true,
        );
        Get.offAll(() => UserLoginScreen());
      }

      //Get.offAll(() => TouristORLocalScreen());

      //Get.offAll(BottomNavbar());

      showCustomSnackBar('Welcome, you have successfully Logged In');
      _isLoading = false;
    } else if (response.statusCode == 202) {
      if (response.body['data']['is_phone_verified'] == 0) {}
    } else if (response.statusCode == 401) {
      Get.offAll(UserSignupScreen());
      showCustomSnackBar(
        "Sorry you don't have no account, please create a account",
      );
    } else {
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  // bool isLoggedIn() {
  //   final prefs = SharedPreferences.getInstance();
  //   return prefs.then((value) => value.getString(AppConstants.TOKEN) != null);
  // }

  bool isLoggedIn() {
    return authServiceInterface.isLoggedIn();
    // if do not work then use this
    //return authRepository.isLoggedIn();
  }

  Future<void> handleLoginSuccess(String token) async {
    await authServiceInterface.saveLogin(token);
    update();
  }

  String? getToken() {
    return authServiceInterface.getUserToken();
  }

  // bool isFirstTimeInstall() {
  //   return true;
  // }

  Future<bool> isFirstTimeInstall() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_time') ?? true;
  }

  bool logging = false;

  Future<void> logOut() async {
    logging = true;
    update();
    Response? response = await authServiceInterface.logout();

    if (isLoggedIn() == false) {
      if (response!.statusCode == 200) {
        // await preferences.setString(AppConstants.token, ''

        showCustomSnackBar('You have logout Successfully');
        Get.offAll(() => UserLoginScreen());
      } else {
        logging = false;
        ApiChecker.checkApi(response);
        print(response.body['message'] + ' for logout from controller');
        Get.snackbar('Error', response.body['message']);
        Get.offAll(() => UserLoginScreen());
      }
    } else {
      print(response.toString() + ' from controller');
    }
    update();
  }

  Future<void> permanentDelete() async {
    logging = true;
    update();

    update();
  }

  Future<Response> sendOtp({
    required String countryCode,
    required String phone,
  }) async {
    _isLoading = true;
    update();

    Response? response = Response();

    update();
    return response;
  }

  Future<void> otpVerification(String otp, String email) async {
    _isLoading = true;
    update();
    Response? response = await authServiceInterface.verifyCode(otp, email);
    if (response!.body['success'] == true) {
      showCustomSnackBar('Otp verification has been successful');
      Get.to(ChangePassword(userEmail: email));
    } else {
      showCustomSnackBar('There is a problem in sending OTP');
      // Get.find<AuthController>().logOut();
    }

    update();
  }

  Future<void> resendOtp(String email) async {
    _isLoading = true;
    update();
    Response? response = await authServiceInterface.resendOtp(email);
    if (response!.body['status'] == true) {
      showCustomSnackBar('Otp has been successful to your mail');

      Get.to(VerifyOtpScreen(email: email));
    }

    update();
  }

  Future<void> forgetPassword(String emails) async {
    email = emails;
    _isLoading = true;
    update();

    Response? response = await authServiceInterface.forgetPassword(emails);

    if (response?.statusCode == 200) {
      _isLoading = false;
      showCustomSnackBar('successfully sent otp');
      Get.to(() => VerifyOtpScreen(email: email));
    } else {
      _isLoading = false;
      showCustomSnackBar('invalid mail');
    }
    update();
  }

  Future<void> resetPassword(
    String email,
    String newPassword,
    String repeatNewPassword,
  ) async {
    _isLoading = true;
    update();

    Response? response = await authServiceInterface.resetPassword(
      email,
      newPassword,
      repeatNewPassword,
    );
    if (response!.statusCode == 200) {
      showCustomSnackBar('Password Change Successfully');
      Get.offAll(() => AccountSettingsScreen());
    } else {
      showCustomSnackBar(response.body['message'] ?? 'Something went wrong');
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    changePasswordIsLoading = true;
    update();
    try {
      Response? response = await authServiceInterface.changePassword(
        currentPassword,
        newPassword,
        confirmPassword,
      );

      print("Check the response data-> ${response}");

      if (response!.statusCode == 200) {
        Get.snackbar("Success", "Password Change Successfully");
        // debugPrint(response.body.toString());
        debugPrint(jsonEncode(response.body));
        Get.off(() => AccountSettingsScreen());
      } else {
        _isLoading = false;
        ApiChecker.checkApi(response);
        if (response.statusCode == 400) {
          Get.snackbar(
            "Failed",
            response.body['message'] ?? 'Something went wrong',
          );
        } else {
          Get.snackbar(
            "Failed",
            response.body['message'] ??
                "Registration failed. Please try again.",
          );
        }
        print(
          ' ❌ Registration failed: ${response.statusCode} ${response.body} ',
        );
      }
    } catch (e) {
      _isLoading = false;
      print("❌ Error changing password: $e");
      Get.snackbar('Error occures', 'error is : $e');
      showCustomSnackBar(
        "Something went wrong. Please try again later. Error is : $e",
        isError: true,
      );
    }

    changePasswordIsLoading = false;
    update();
  }

  bool updateFcm = false;

  Future<void> updateAccessAndRefreshToken() async {
    Response? response =
        await authServiceInterface.updateAccessAndRefreshToken();
    if (response?.statusCode == 200) {
      String token = response!.body['accessToken'];
      String refreshToken = response.body['refreshToken'];

      print('accessToken $token NOWW');
      print('refreshToken $refreshToken');

      setUserToken(token, refreshToken);
      updateFcm = false;
    } else {
      updateFcm = false;
      ApiChecker.checkApi(response!);
    }

    update();
  }

  String _verificationCode = '';
  String _otp = '';
  String get otp => _otp;
  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    if (_verificationCode.isNotEmpty) {
      _otp = _verificationCode;
    }
    update();
  }

  void clearVerificationCode() {
    updateVerificationCode('');
    _verificationCode = '';
    update();
  }

  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  void setRememberMe() {
    _isActiveRememberMe = true;
  }

  String getUserToken() {
    return authServiceInterface.getUserToken();
  }

  String getUserRole() {
    return authServiceInterface.getUserRole();
  }

  Future<void> setUserToken(String token, String refreshToken) async {
    await authServiceInterface.saveUserToken(token, refreshToken);
  }

  Future<void> saveUserRole(String userRole) async {
    debugPrint('Saving User Role: $userRole');
    await authServiceInterface.saveUserRole(userRole);
  }

  Future<bool> getFirsTimeInstall() async {
    return authServiceInterface.isFirstTimeInstall();
  }

  Future<void> setFirstTimeInstall() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_time', false);
  }

  // void setFirstTimeInstall() {
  //   return authServiceInterface.setFirstTimeInstall();
  // }

  Future<void> chooseRole(String role) async {
    _isLoading = true;
    update();

    try {
      // 🔑 Fetch token internally so UI doesn't need to pass it
      final token = await getUserToken();

      if (token == null || token.isEmpty) {
        showCustomSnackBar(
          "User not authenticated. Please log in again.",
          isError: true,
        );
        _isLoading = false;
        update();
        return;
      }

      // Call API with role + token
      Response? response = await authServiceInterface.chooseRole(role, token);

      if (response != null && response.statusCode == 200) {
        showCustomSnackBar('You have successfully selected your role as $role');

        // Navigate to next screen
        Get.to(LanguagePickerScreen(userRole: role));
        // Get.to(VerifyOtpScreen(role: role));
      } else if (response != null) {
        showCustomSnackBar(
          response?.body['message'] ?? 'Something went wrong',
          isError: true,
        );
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      showCustomSnackBar("Unexpected error: $e", isError: true);
    }

    _isLoading = false;
    update();
  }

  // Future<void> chooseRole(String role) async {
  //   _isLoading = true;
  //   update();
  //   Response? response = await authServiceInterface.chooseRole(role);
  //   if (response!.statusCode == 200) {
  //     showCustomSnackBar('You have successfully selected your role as $role');
  //     Get.to(LanguagePickerScreen());

  //     //Get.to(VerifyOtpScreen(role: role));
  //   } else {
  //     showCustomSnackBar(
  //       response.body['message'] ?? 'Something went wrong',
  //       isError: true,
  //     );
  //     ApiChecker.checkApi(response);
  //   }

  //   _isLoading = false;
  //   update();
  // }
}
