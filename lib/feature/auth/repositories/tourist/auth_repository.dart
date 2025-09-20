import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/urls.dart';
import '../../../../helpers/remote/data/api_client.dart';
import '../../../../utils/app_constants.dart';
import 'auth_repository_interface.dart';

class AuthRepository implements AuthRepositoryInterface {
  final ApiClient apiClient;

  final SharedPreferences sharedPreferences;
  AuthRepository({required this.apiClient, required this.sharedPreferences});

  RxString _token = "".obs;

  @override
  Future register(String email, String password, String confirmPassword) async {
    return await apiClient.postData(Urls.register, {
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
    });
  }

  @override
  Future accessAndRefreshToken(String refreshToken) async {
    return await apiClient.postData(Urls.refreshAccessToken, {
      "refreshToken": refreshToken,
    });
  }

  @override
  Future login(String email, String password) async {
    return await apiClient.postData(Urls.login, {
      "email": email,
      "password": password,
    });
  }

  @override
  Future forgetPassword(String? email) async {
    return await apiClient.postData(Urls.forgetPassword, {"email": email});
  }

  @override
  Future verifyCode(String otp, String email) async {
    return await apiClient.postData(Urls.verifyCode, {
      "email": email,
      "otp": int.tryParse(otp),
    });
  }

  @override
  Future resetPassword(
    String email,
    String newPassword,
    String repeatNewPassword,
  ) async {
    return await apiClient.postData(Urls.resetPassword, {
      "email": email,
      "newPassword": newPassword,
      "repeatNewPassword": repeatNewPassword,
    });
  }

  @override
  bool isLoggedIn() {
    try {
      final token = sharedPreferences.getString(AppConstants.token);
      return token != null && token.isNotEmpty;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<void> saveLogin(String token) async {
    await sharedPreferences.setString('IsLoggedIn', token);
    _token.value = token;
  }

  @override
  Future logout() async {
    return await apiClient.postData(Urls.logOut, {}).then((response) {
      clearUserCredentials();
      return response;
    });
  }

  //@override
  String? getToken() {
    // return sharedPreferences.getString('IsLoggedIn');
    return sharedPreferences.getString(AppConstants.token);
  }

  // // Try to update the code for saving user token and refresh token
  // // in the SharedPreferences.

  // @override
  // bool isLoggedIn() {
  //   sharedPreferences.getString(AppConstants.token);
  //   bool isLoggedIn = sharedPreferences.getBool('IsLoggedIn') ?? false;
  //   if (isLoggedIn) {
  //     sharedPreferences.setBool('IsLoggedIn', true);
  //     return true;
  //   }
  //   return false;
  // }

  // @override
  // Future logout() async {
  //   sharedPreferences.setBool('IsLoggedIn', false);

  //   var data = apiClient.postData(AppConstants.logout, {});

  //   apiClient.token = '';
  //   apiClient.updateHeader('');
  //   await sharedPreferences.setString(AppConstants.token, '');
  //   await sharedPreferences.setString(AppConstants.refreshToken, '');
  //   return data;
  // }

  @override
  /// Save user token and refresh token in the SharedPreferences
  ///
  /// This function is used to save the user's token and refresh token
  /// in the SharedPreferences. This token is used to authenticate the
  /// user in the APIs.
  ///
  /// [token] is the user's token.
  /// [refreshToken] is the user's refresh token.
  ///
  /// Returns [bool] indicating whether the operation was successful or not.
  Future<bool?> saveUserToken(String token, String refreshToken) async {
    print(
      'User Token ${token.toString()} ================================== from Repository ',
    );

    await sharedPreferences.setString(AppConstants.refreshToken, refreshToken);
    await sharedPreferences.setString(AppConstants.token, token);
    apiClient.token = token;
    apiClient.updateHeader(token);
    return true;
    // return await sharedPreferences.setString(AppConstants.token, token);
  }

    @override
  Future<bool?> saveUserRole(String userRole) async{
    print(
      'User Role ${userRole.toString()} ================================== from Repository to store in sharedPref ',
    );
    await sharedPreferences.setString(AppConstants.userRole, userRole);
    return true;
  }

    @override
  String getUserRole() {
    final userRole = sharedPreferences.getString(AppConstants.userRole)??" ";
    print(
      'Retrieved User Role. fjorm  getUserROle: $userRole ================================== from Repository ',
    );
    return userRole;
  }
  

  @override
  bool isFirstTimeInstall() {
    if (sharedPreferences.getBool('firstTimeInstall') == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void setFirstTimeInstall() {
    sharedPreferences.setBool('firstTimeInstall', true);
  }

  @override
  bool clearSharedAddress() {
    throw UnimplementedError();
  }

  @override
  Future<bool> clearUserCredentials() async {
    return await sharedPreferences.clear();
  }

  @override
  String getUserToken() {
    final token = sharedPreferences.getString(AppConstants.token) ?? '';
    apiClient.updateHeader(token);
    return token;
  }

  @override
  Future resendOtp(String email) {
    return apiClient.postData(Urls.forgetPassword, {"email": email});
  }

  @override
  Future sendOtp({required String phone}) {
    throw UnimplementedError();
  }

  @override
  Future updateToken() {
    throw UnimplementedError();
  }

  @override
  Future changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    return await apiClient.patchData(Urls.changePassword, {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    });
  }

  @override
  Future updateAccessAndRefreshToken() async {
    return await apiClient.postData(Urls.refreshAccessToken, {}) ?? ();
  }

  @override
  Future chooseRole(String role, String token) async {
    apiClient.updateHeader(token);
    return await apiClient.postData(Urls.chooseRole, {"role": role});
  }
  


}
