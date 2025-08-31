import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileServiceInterface {
  Future<Response> getProfile();
  Future<Response> updateProfile({
    required String firstName,
    required String lastName,
    required int age,
    required String gender,
    required String nationality,
    required String description,
    List<String>? languages,
    required XFile profileImage,
  });
  Future<Response> updateSpacificFieldUserProfile({
    String ?firstName,
    String? lastName,
    int? age,
    String? gender,
    String? nationality,
    String? description,
    List<String>? languages,
    XFile? profileImage,
  });

  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
