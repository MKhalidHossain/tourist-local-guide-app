import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/urls.dart';
import '../../../helpers/remote/data/api_client.dart';
import 'home_repository_interface.dart';

class HomeRepository implements HomeRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  HomeRepository(this.apiClient, this.sharedPreferences);

  @override
  Future<Response> createOffer({
    required String category,
    required String offerType,
    required String pricePerPerson,
    required String maxParticipants,
    required String title,
    required String description,
    required List<Map<String, dynamic>> availability,
    required List<XFile> photos,
  }) async {
    print('THis is availability' + availability.toString());

    return await apiClient.postMultipartData(
      Urls.createOffer,
      body: {
        "category": category,
        "offerType": offerType,
        "pricePerPerson": pricePerPerson,
        "maxParticipants": maxParticipants,
        "title": title,
        "description": description,
        "availability": availability,
      },
      photos: photos,
    );
  }

  // }) async {
  //   return await apiClient.postData(Urls.createOffer, {
  //     "category": category,
  //     "offerType": offerType,
  //     "pricePerPerson": pricePerPerson,
  //     "maxParticipants": maxParticipants,
  //     "title": title,
  //     "description": description,
  //     "availability": availability,
  //     "photos": photos,

  //   });
  // }

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
  Future<Response> getTripsDetails(String tripId) async {
    return await apiClient.getData(Urls.getTripsDetails + tripId);
  }

  @override
  Future<Response> getBookingsAll() async {
    return await apiClient.getData(Urls.getBookingsAll);
  }

  @override
  Future<Response> getBookings(String status) async {
    return await apiClient.getData(Urls.getBookingsCategories + status);
  }

  @override
  Future<Response> cencelBookings(String id) async {
    return await apiClient.patchData(Urls.cencelBooking + id, {});
  }

  //
  // ************ tourist ************ //
  //
  @override
  Future<Response> getSuperHatch() async {
    return await apiClient.getData(Urls.getSuperHatch);
  }

  @override
  Future<Response> addFavOrRemove(String localId) async {
    return await apiClient.postData(
      Urls.addFavouriteOrRemoveFavourite + localId,
      {},
    );
  }

  @override
  Future<Response> cancelTrip(String localId) async {
    return await apiClient.patchData(Urls.cancelTripForTuourist + localId, {});
  }

  @override
  Future<Response> getFav() async {
    return await apiClient.getData(Urls.getFavorites);
  }

  @override
  Future<Response> getFavoriteHatch() async {
    return await apiClient.getData(Urls.getFavouriteHatch);
  }

  @override
  Future<Response> getLocalprofile(String localId) async {
    return await apiClient.getData(Urls.getLocalProfile + localId);
  }

  @override
  Future<Response> getOfferDetails(String localId, String offerId) async {
    return await apiClient.getData(
      Urls.getOfferDetails + localId + "/" + offerId,
    );
  }

  @override
  Future<Response> searchOffer(
    String country,
    List<String> dates,
    int participantsCount,
    List<String> languages,
    String offerType,
  ) async {
    return await apiClient.postData(Urls.searchOffer, {
      "country": country,
      "dates": dates,
      "participants": participantsCount,
      "languages": languages,
      "offerType": offerType,
    });
  }

  @override
  Future<Response> rateALocal(
    String localId,
    String comment,
    String rating,
  ) async {
    return await apiClient.postData(Urls.rateALocal, {
      "localId": localId,
      "comment": comment,
      "rating": rating,
    });
  }

  @override
  Future<Response> sendMessage(String receiverId, String message) async {
    return await apiClient.postData(Urls.sendMessage, {
      "receiverId": receiverId,
      "message": message,
    });
  }

  @override
  Future<Response> getMessages(String userId) async {
    return await apiClient.getData(Urls.getMessage + userId);
  }

  @override
  Future<Response> getUserAssociatedWithChat() async {
    return await apiClient.getData(Urls.getUserAssociatWithChat);
  }

  @override
  Future<Response> getAllOwnOffer() async {
    return await apiClient.getData(Urls.getAllOwnOffer);
  }

  @override
  Future<Response> getOwnOfferById(String offerId) async {
    return await apiClient.getData(Urls.getOwnOfferById + offerId);
  }

  @override
  Future<Response> confirmPayment(
    String paymentIntentId,
    String paymentMethodId,
  ) async {
    return await apiClient.postData(Urls.confirmPayment, {
      "paymentIntentId": paymentIntentId,
      "paymentMethodId": paymentMethodId,
    });
  }

  @override
  Future<Response> connectAccount() async {
    return await apiClient.postData(Urls.connectAccount, {});
  }

  @override
  Future<Response> createPayment(
    String bookingCode,
    String amount,
    String localId,
  ) async {
    return await apiClient.postData(Urls.createPayment, {
      "bookingCode": bookingCode,
      "amount": amount,
      "localId": localId,
    });
  }

  @override
  Future<Response> resendOnboarding(String localId) async {
    return await apiClient.postData(Urls.resendOnboarding, {
      "localId": localId,
    });
  }

  @override
  Future<Response> confirmBooking(String bookingId) async {
    return await apiClient.patchData(Urls.confirmBooking, {
      "bookingId": bookingId,
    });
  }

  @override
  Future<Response> createBooking(
    String localId,
    String offerId,
    String date,
    String selectedTimeSlot,
    String participants,
  ) async {
    return await apiClient.postData(Urls.createBooking, {
      "localId": localId,
      "offerId": offerId,
      "date": date,
      "timeSlot": selectedTimeSlot,
      "participants": participants,
    });
  }

  @override
  /*************  ✨ Windsurf Command ⭐  *************/
  /// Get bookings by status.
  ///
  /// [status] - status of bookings (e.g. pending, accepted, rejected)
  Future<Response> getBookingByStatus(String status) async {
    return await apiClient.getData(Urls.getBookingsByStatus + status);
  }

  @override
  Future<Response> getBookingDetails(String bookingId) async {
    return await apiClient.getData(Urls.getBookingDetails + bookingId);
  }

  @override
  Future<Response> updateBooking(String bookingId, String participants) async {
    return await apiClient.patchData(Urls.updateBooking + bookingId, {
      "bookingId": bookingId,
      "participants": participants,
    });
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
