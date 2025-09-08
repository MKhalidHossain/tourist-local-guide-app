import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/urls.dart';
import '../../../../helpers/remote/data/api_client.dart';
import 'local_home_repository_interface.dart';

class LocalHomeRepository implements LocalHomeRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocalHomeRepository(this.apiClient, this.sharedPreferences);

  @override
  Future<Response> updateOffer({
    required String offerId,
    required String category,
    required String offerType,
    required String pricePerPerson,
    required String maxParticipants,
    required String title,
    required String description,
    required String availabilityDate,
    required XFile photos,
    required String availabilityTimeSlots,
  }) async {
    return await apiClient.patchData(Urls.updateOffer, {
      "offerId": offerId,
      "category": category,
      "offerType": offerType,
      "pricePerPerson": pricePerPerson,
      "maxParticipants": maxParticipants,
      "title": title,
      "description": description,
      "availabilityDate": availabilityDate,
      "photos": photos,
      "availabilityTimeSlots": availabilityTimeSlots,
    });
  }

  @override
  Future<Response> getHome() async {
    return await apiClient.getData(Urls.getHome);
  }

  @override
  Future<Response> getBookingDetails(String tripId) async {
    return await apiClient.getData(Urls.getBookingDetails+tripId);
  }

  @override
  Future<Response> getBookings(String status) async {
    return await apiClient.getData(Urls.getBookings+status);
    print("Status for getBookings from local_home_repository: ${status}");
  }

  @override
  Future<Response> cencelBookings(String id) async {
    return await apiClient.patchData(Urls.cencelBooking + id, {});
  }

  // @override
  // Future<Response> getProfile() async {
  //   return await apiClient.getData(Urls.getProfile);
  // }

  // @override
  // Future<Response> updateProfile({
  //   required String firstName,
  //   required String lastName,
  //   required int age,
  //   required String gender,
  //   required String nationality,
  //   required String description,
  //   List<String>? languages,
  //   required XFile profileImage,
  // }) async {
  //   debugPrint("Updating profile with image: ${profileImage.path}");

  //   return await apiClient.patchData(
  //     Urls.updateProfile,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization':
  //           'Bearer ${sharedPreferences.getString(AppConstants.token) ?? ''}',
  //     },
  //     {
  //       "firstName": firstName,
  //       "lastName": lastName,
  //       "age": age,
  //       "gender": gender.toLowerCase(),
  //       "nationality": nationality,
  //       "languages": languages,
  //       "description": description,
  //       "profileImage":
  //           await profileImage.path, // Convert XFile to bytes if not null
  //     },
  //   );
  // }

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
  //   final Map<String, dynamic> body = {};

  //   if (firstName != null) body["firstName"] = firstName;
  //   if (lastName != null) body["lastName"] = lastName;
  //   if (age != null) body["age"] = age;
  //   if (gender != null) body["gender"] = gender;
  //   if (nationality != null) body["nationality"] = nationality;
  //   if (description != null) body["description"] = description;
  //   if (languages != null && languages.isNotEmpty) {
  //     body["languages"] = languages;
  //   }
  //   if (profileImage != null) {
  //     body["profileImage"] = profileImage.path;
  //   }

  //   // ✅ Ensure at least one field exists
  //   if (body.isEmpty) {
  //     throw Exception("Please provide at least one field to update.");
  //   }

  //   debugPrint("Updating profile with payload: $body");

  //   return await apiClient.patchData(
  //     Urls.updateProfile,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization':
  //           'Bearer ${sharedPreferences.getString(AppConstants.token)}',
  //     },
  //     body,
  //   );
  // }
}
