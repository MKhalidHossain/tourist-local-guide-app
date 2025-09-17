import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/feature/auth/controllers/auth_controller.dart';
import 'package:kobeur/feature/profile/domain/model/get_profile_response_model.dart';
import '../../../helpers/remote/data/api_client.dart';
import '../../../navigation/bottom_navigationber_screen.dart';
import '../../../utils/display_helper.dart';
import '../../auth/presentation/screens/common/user_login_screen.dart';
import '../../offer/presentation/screens/create_first_service_screen.dart';
import '../domain/model/update_profile_response_model.dart';
import '../services/profile_service_interface.dart';

class ProfileController extends GetxController implements GetxService {
  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    getUserRole();
    _getSafeToken();
  }

  final ProfileServiceInterface profileServiceInterface;
  ProfileController(this.profileServiceInterface);

  GetProfileResponseModel? getProfileResponseModel = GetProfileResponseModel();
  RxString name = "".obs;
  RxString image = "".obs;
  RxString nationality = "".obs;
  UpdateProfileResponseModel updateProfileResponseModel =
      UpdateProfileResponseModel();

  String? userRole;
  bool isValidUser = false;
  bool isLoading = false;
  XFile? _pickedProfileFile;
  XFile? get pickedProfileFile => _pickedProfileFile;

  XFile identityImage = XFile('');

  List<XFile> identityImages = [];

  List<MultipartBody> multipartList = [];

  /// ✅ Common method to get token safely
  Future<String?> _getSafeToken() async {
    final token = await authController.getUserToken();
    if (token == null || token.isEmpty) {
      print("⚠️ No token found. Redirecting to login...");
      SnackBar(content: Text('User not authenticated. Please log in again.'));
      await authController.logOut();
      Get.offAll(() => UserLoginScreen());
      return null;
    } else {
      isValidUser = true;
      debugPrint("✅ User token retrieved successfully: $token");
    }
    return token;
  }

  // void pickProfileImage() async {
  //   _pickedProfileFile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   update();
  // }
  void pickImage(bool isback, bool isProfile) async {
    if (isProfile) {
      _pickedProfileFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        //; source: isback ? ImageSource.camera : ImageSource.gallery,
      );
    } else {
      identityImage =
          (await ImagePicker().pickImage(source: ImageSource.gallery))!;

      identityImages.add(identityImage);
      multipartList.add(MultipartBody('identity_images[]', identityImage));
      // _pickedProfileFile = await ImagePicker().pickVideo(
      //   source: isback ? ImageSource.camera : ImageSource.gallery,
      // );
    }
    update();
  }

  void clearPickedImage() {
    _pickedProfileFile = null;
    update();
  }

  Future<void> getUserRole() async {
    await getUserProfile();
    userRole = getProfileResponseModel?.data?.role ?? '';
    debugPrint(
      'Loaded User Role: $userRole     ============================== < from ProfileController',
    );
  }

  Future<void> getUserProfile() async {
    try {
      isLoading = true;
      update();

      final response = await profileServiceInterface.getProfile();

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ Profile fetched successfully\n");
        getProfileResponseModel = GetProfileResponseModel.fromJson(
          response.body,
        );

        name.value =
            ("${getProfileResponseModel?.data?.firstName} ${getProfileResponseModel?.data?.lastName}") ??
            'No Name';
        image.value = getProfileResponseModel?.data?.profileImage ?? '';
        nationality.value =
            getProfileResponseModel?.data?.nationality ?? 'Country';

        name.refresh();
        image.refresh();
        nationality.refresh();

        update();

        refresh();

        print("✅ Profile fetched successfully\n");
      } else if (response.statusCode == 401) {
        // Handle unauthorized access, maybe redirect to login
        print(
          "⚠️ Unauthorized access. Please log in again. need to check access token\n",
        );
      } else if (response.statusCode == 403) {
        // Handle forbidden access
        print(
          "⚠️ Forbidden access. You do not have permission to view this profile.\n",
        );
      } else {
        print("❌ Failed to fetch profile: ${response.statusCode}\n");
      }
    } catch (e) {
      print("⚠️ Error fetching profile: $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  // onno rokom api call hocche

  // Future<void> getApicall() async {
  //   try {
  //     isLoading = true;
  //     update();
  //     final response = await http.get(Uri.parse('https://kobeur.onrender.com/api/v1/profile'),

  //     headers: {
  //       'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NzI0MmJkYjgxOTZiMjkwZWEyNDE4MCIsImlhdCI6MTc1NDIwMjkyNSwiZXhwIjoxNzU0ODA3NzI1fQ.x2A1bFFiAcqZQNAlqS8yZFKc_fWcp1OK6lfkULpcjXE'
  //     },
  //     );
  //     if (response.statusCode == 200) {
  //       print("✅ Profile fetched successfully\n");

  //       print(response.body);
  //     } else {
  //       print("❌ Failed to fetch profile: ${response.statusCode}\n");
  //     }
  //   } catch (e) {
  //     print("⚠️ Error fetching profile: $e\n");
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }

  // }

  Future<void> updateUserProfile({
    required String firstName,
    required String lastName,
    required int age,
    required userRole,
    required String gender,
    required String nationality,
    required String description,
    List<String>? languages,
    required XFile profileImage, // Store as a File
  }) async {
    try {
      isLoading = true;
      update();

      debugPrint(
        "Updating profile with image: ${profileImage.path} \n "
        "First Name: $firstName, Last Name: $lastName, "
        "Age: $age, Gender: $gender, Nationality: $nationality, "
        "Description: $description, Languages: $languages, Profile Image: ${profileImage.path}",
      );

      final response = await profileServiceInterface.updateProfile(
        firstName: firstName,
        lastName: lastName,
        age: age,
        gender: gender,
        nationality: nationality,
        description: description,
        languages: languages,
        profileImage: profileImage,
      );

      debugPrint("Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        updateProfileResponseModel = UpdateProfileResponseModel.fromJson(
          response.body,
        );
        print("✅ Profile updated successfully\n");
        if (isValidUser && userRole != null && userRole!.isNotEmpty) {
          // for Nevigation to Tourist or Local
          if (userRole.toString().toLowerCase() == 'tourist') {
            debugPrint(
              'User Role: $userRole ================================= from Auth controller after login \n\n\n\n\n\n\n',
            );
            Get.offAll(() => BottomNavbar(userRole: userRole));
          } else if (userRole.toString().toLowerCase() == 'local') {
            Get.offAll(() => CreateFirstServiceScreen());
          } else {
            showCustomSnackBar(
              'You have not selected your role yet, please select your role',
              isError: true,
            );
            Get.offAll(() => UserLoginScreen());
          }
        }
      } else {
        debugPrint("❌ Failed to update profile: ${response.statusCode}");
        Get.snackbar(
          'Error',
          'Failed to update profile: ${response.body['message']}',
        );
      }
    } catch (e) {
      print("⚠️ Error updating profile: $e\n ");
      Get.snackbar('Exception', 'Error updating profile: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updateSpacificFieldUserProfile({
    String? firstName,
    String? lastName,
    int? age,
    String? userRole,
    String? gender,
    String? nationality,
    String? description,
    List<String>? languages,
    XFile? profileImage,
  }) async {
    try {
      // ✅ Check if at least one field is provided
      if (firstName == null &&
          lastName == null &&
          age == null &&
          userRole == null &&
          gender == null &&
          nationality == null &&
          description == null &&
          (languages == null || languages.isEmpty) &&
          profileImage == null) {
        Get.snackbar("Error", "Please provide at least one field to update.");
        return;
      }

      isLoading = true;
      update();

      // Call repository
      final response = await profileServiceInterface
          .updateSpacificFieldUserProfile(
            firstName: firstName,
            lastName: lastName,
            age: age,
            gender: gender,
            nationality: nationality,
            description: description,
            languages: languages,
            profileImage: profileImage,
          );

      if (response.statusCode == 200 || response.statusCode == 201) {
        updateProfileResponseModel = UpdateProfileResponseModel.fromJson(
          response.body,
        );
        debugPrint("✅ Profile updated successfully: ${response.body}");

        Get.snackbar(
          "Profile Update Successfully",
          "New data added successfully",
        );

        // // ✅ Handle userRole navigation logic
        // if (isValidUser && userRole != null && userRole.isNotEmpty) {
        //   if (userRole.toLowerCase() == 'tourist') {
        //     Get.offAll(() => BottomNavbar(userRole: userRole));
        //   } else if (userRole.toLowerCase() == 'local') {
        //     Get.offAll(() => CreateFirstServiceScreen());
        //   } else {
        //     showCustomSnackBar(
        //       'You have not selected your role yet, please select your role',
        //       isError: true,
        //     );
        //     Get.offAll(() => UserLoginScreen());
        //   }
        // }
      } else {
        Get.snackbar(
          'Error',
          'Failed to update profile: ${response.body['message']}',
        );
      }
    } catch (e) {
      Get.snackbar('Exception', 'Error updating specific field of profile: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  // Future<void> updateSpacificFieldUserProfile({
  //   String? firstName,
  //   String? lastName,
  //   int? age,
  //   String? userRole,
  //   String? gender,
  //   String? nationality,
  //   String? description,
  //   List<String>? languages,
  //   XFile? profileImage,
  // }) async {
  //   try {
  //     // ✅ Ensure at least one field is provided
  //     final noDataProvided =
  //         firstName == null &&
  //         lastName == null &&
  //         age == null &&
  //         userRole == null &&
  //         gender == null &&
  //         nationality == null &&
  //         description == null &&
  //         (languages == null || languages.isEmpty) &&
  //         profileImage == null;

  //     if (noDataProvided) {
  //       Get.snackbar("Error", "Please provide at least one field to update.");
  //       return;
  //     }

  //     isLoading = true;
  //     update();

  //     debugPrint(
  //       "Updating profile with: "
  //       "First Name: $firstName, Last Name: $lastName, "
  //       "Age: $age, Gender: $gender, Nationality: $nationality, "
  //       "Description: $description, Languages: $languages, "
  //       "Profile Image: ${profileImage?.path}",
  //     );

  //     final response = await profileServiceInterface
  //         .updateSpacificFieldUserProfile(
  //           firstName: firstName,
  //           lastName: lastName,
  //           age: age,
  //           gender: gender,
  //           nationality: nationality,
  //           description: description,
  //           languages: languages,
  //           profileImage: profileImage,
  //         );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       updateProfileResponseModel = UpdateProfileResponseModel.fromJson(
  //         response.body,
  //       );
  //       print("✅ Profile updated successfully\n");

  //       // ✅ userRole handling stays the same
  //       if (isValidUser && userRole != null && userRole.isNotEmpty) {
  //         if (userRole.toLowerCase() == 'tourist') {
  //           Get.offAll(() => BottomNavbar(userRole: userRole));
  //         } else if (userRole.toLowerCase() == 'local') {
  //           Get.offAll(() => CreateFirstServiceScreen());
  //         } else {
  //           showCustomSnackBar(
  //             'You have not selected your role yet, please select your role',
  //             isError: true,
  //           );
  //           Get.offAll(() => UserLoginScreen());
  //         }
  //       }
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'Failed to update profile: ${response.body['message']}',
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar('Exception', 'Error updating Spacific field off profile: $e');
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }

  Future<void> ChangePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      isLoading = true;
      update();

      final response = await profileServiceInterface.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        updateProfileResponseModel = UpdateProfileResponseModel.fromJson(
          response.body,
        );
        print("✅ Password changed successfully\n");
      } else {
        print("❌ Failed to changing password: ${response.statusCode}\n");
      }
    } catch (e) {
      print("⚠️ Error changing password: $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }
}
