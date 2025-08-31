import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/urls.dart';

import '../../../helpers/remote/data/api_client.dart';
import 'profile_repository_interface.dart';

class ProfileRepository implements ProfileRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ProfileRepository(this.apiClient, this.sharedPreferences);

  @override
  Future<Response> getProfile() async {
    return await apiClient.getData(Urls.getProfile);
  }

  @override
  Future<Response> updateProfile({
    required String firstName,
    required String lastName,
    required int age,
    required String gender,
    required String nationality,
    required String description,
    List<String>? languages,
    required XFile profileImage,
  }) async {
    debugPrint("Updating profile with image: ${profileImage.path}");

    return await apiClient.patchData(
      Urls.updateProfile,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${sharedPreferences.getString(AppConstants.token) ?? ''}',
      },
      {
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "gender": gender.toLowerCase(),
        "nationality": nationality,
        "languages": languages,
        "description": description,
        "profileImage":
            await profileImage.path, // Convert XFile to bytes if not null
      },
    );
  }

  @override
  Future<Response> updateSpacificFieldUserProfile({
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
    String? nationality,
    String? description,
    List<String>? languages,
    XFile? profileImage,
  }) async {
    final Map<String, dynamic> body = {};

    if (firstName != null) body["firstName"] = firstName;
    if (lastName != null) body["lastName"] = lastName;
    if (age != null) body["age"] = age;
    if (gender != null) body["gender"] = gender;
    if (nationality != null) body["nationality"] = nationality;
    if (description != null) body["description"] = description;
    if (languages != null && languages.isNotEmpty) {
      body["languages"] = languages;
    }
    if (profileImage != null) {
      body["profileImage"] = profileImage.path;
    }

    // ✅ Ensure at least one field exists
    if (body.isEmpty) {
      throw Exception("Please provide at least one field to update.");
    }

    debugPrint("Updating profile with payload: $body");

    return await apiClient.patchData(
      Urls.updateProfile,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${sharedPreferences.getString(AppConstants.token)}',
      },
      body,
    );
  }

  // @override
  // Future<Response> updateSpacificFieldUserProfile({
  //   String? firstName,
  //   String? lastName,
  //   int? age,
  //   String? gender,
  //   String? nationality,
  //   String? description,
  //   List<String>? languages,
  //   XFile? profileImage,
  // }) async {
  //   String? updatedField;
  //   // ✅ Ensure at least one field is provided
  //   final noDataProvided =
  //       firstName == null &&
  //       lastName == null &&
  //       age == null &&
  //       gender == null &&
  //       nationality == null &&
  //       description == null &&
  //       (languages == null || languages.isEmpty) &&
  //       profileImage == null;

  //   if (noDataProvided) {
  //     throw Exception("Please provide at least one field to update.");
  //   } else if (firstName != null) {
  //     updatedField = 'firstName: $firstName';
  //   } else if (lastName != null) {
  //     updatedField = 'lastName: $lastName';
  //   } else if (age != null) {
  //     updatedField = 'age: $age';
  //   } else if (gender != null) {
  //     updatedField = 'gender: $gender';
  //   } else if (nationality != null) {
  //     updatedField = 'nationality: $nationality';
  //   } else if (description != null) {
  //     updatedField = 'description: $description';
  //   } else if (languages != null && languages.isNotEmpty) {
  //     updatedField = 'languages: ${languages.join(", ")}';
  //   } else if (profileImage != null) {
  //     updatedField = 'profileImage: ${profileImage.path}';
  //   }
  //   if (updatedField != null) {
  //     debugPrint('Updating profile field: $updatedField');
  //   }

  //   return await apiClient.patchData(
  //     Urls.updateProfile,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization':
  //           'Bearer ${sharedPreferences.getString(AppConstants.token)}',
  //     },
  //     {
  //       "firstName": firstName,
  //       "lastName": lastName,
  //       "age": age,
  //       "gender": gender,
  //       "nationality": nationality,
  //       "languages": languages,
  //       "description": description,
  //       "profileImage":
  //        profileImage.path, // Convert XFile to bytes if not null
  //     },
  //   );
  // }

  @override
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await apiClient.postData(Urls.changePassword, {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    });
  }
}
