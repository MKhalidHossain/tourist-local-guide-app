import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/feature/home/domain/local/cencel_booking_response_model.dart';
import 'package:kobeur/feature/home/domain/local/create_offer_response_model.dart';

import 'package:kobeur/feature/home/domain/local/get_home_response_model.dart';
import 'package:kobeur/feature/home/domain/local/update_offer_response_model.dart';
import 'package:kobeur/feature/home/domain/tourist/add_fav_or_remove_fav_response_model.dart';
import 'package:kobeur/feature/home/domain/tourist/get_fab_response_model.dart';
import 'package:kobeur/feature/home/domain/tourist/get_favorite_hatch_response_model.dart';
import 'package:kobeur/feature/home/domain/tourist/get_local_profile_response_model.dart';
import 'package:kobeur/feature/home/domain/tourist/get_offer_details_response_model.dart';
import 'package:kobeur/feature/home/domain/tourist/get_super_hatch_response_model.dart';
import 'package:kobeur/feature/home/domain/tourist/rate_a_local_response_model.dart';
import 'package:kobeur/feature/home/domain/tourist/search_offer_response_model.dart';
import 'package:kobeur/feature/home/services/home_service_interface.dart';

import '../../../navigation/bottom_navigationber_screen.dart';
import '../domain/local/get_booking_details_response_model.dart';
import '../domain/local/get_trip_response_api_bookings_model.dart';

class HomeController extends GetxController implements GetxService {
  // final localHomeController = Get.find<LocalHomeController>();

  final HomeServiceInterface homeServiceInterface;

  HomeController(this.homeServiceInterface);
  CreateOfferResponseModel createOfferResponseModel =
      CreateOfferResponseModel();
  UpdateOfferResponseModel updateOfferResponseModel =
      UpdateOfferResponseModel();
  GetHomeResponseModel getHomeResponseModel = GetHomeResponseModel();
  GetTripsDetailsResponseModel getBookingDetailsResponseModel =
      GetTripsDetailsResponseModel();
  GetTripResponseApiBookingsModel getTripResponseApiBookingsModel =
      GetTripResponseApiBookingsModel();
  CancelBookingResponseModel cancelBookingResponseModel =
      CancelBookingResponseModel();
  GetSuperHatchResponseModel getSuperHatchResponseModel =
      GetSuperHatchResponseModel();
  GetFavoriteHatchResponseModel getFavoriteHatchResponseModel =
      GetFavoriteHatchResponseModel();
  SearchOfferResponseModel searchOfferResponseModel =
      SearchOfferResponseModel();
  GetOfferDetailsResponseModel getOfferDetailsResponseModel =
      GetOfferDetailsResponseModel();
  GetLocalProfileResponseModel getLocalProfileResponseModel =
      GetLocalProfileResponseModel();
  AddFavOrRemoveFavResponseModel addFavOrRemoveFavResponseModel =
      AddFavOrRemoveFavResponseModel();
  GetFavResponseModel getFavResponseModel = GetFavResponseModel();
  RateALocalResponseModel rateALocalResponseModel = RateALocalResponseModel();

  bool isLoading = false;

  Future<void> createOffer({
    required String category,
    required String offerType,
    required String pricePerPerson,
    required String maxParticipants,
    required String title,
    required String description,
    required List<Map<String, dynamic>> availability,
    required List<XFile> photos,
  }) async {
    try {
      isLoading = true;
      update();

      // print(
      //       "category: $category" +
      //       "offerType: $offerType" +
      //       "pricePerPerson: $pricePerPerson" +
      //       "maxParticipants: $maxParticipants" +
      //       "title: $title" +
      //       "description: $description" +
      //       "availability: $availability" +
      //       "photos: $photos" +

      // );

      final response = await homeServiceInterface.createOffer(
        category: category,
        offerType: offerType,
        pricePerPerson: pricePerPerson,
        maxParticipants: maxParticipants,
        title: title,
        description: description,
        availability: availability,
        photos: photos,
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        print("✅ Offer updated successfully from local \n");
        createOfferResponseModel = CreateOfferResponseModel.fromJson(
          response.body,
        );
        isLoading = false;
        update();
        Get.to(() => BottomNavbar(userRole: 'Local'));
      } else {
        print(
          "❌ Failed to : create Offer : from local: ${response.statusCode}\n",
        );
        Get.snackbar(
          "Error",
          "Failed to : creat Offer :: ${response.body['message']}",
        );
      }
    } catch (e) {
      print("⚠️ Error : creat Offer : from local: $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updateOffer({
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
    try {
      isLoading = true;
      update();

      print(
        "offerId: $offerId" +
            "category: $category" +
            "offerType: $offerType" +
            "pricePerPerson: $pricePerPerson" +
            "maxParticipants: $maxParticipants" +
            "title: $title" +
            "description: $description" +
            "availabilityDate: $availabilityDate" +
            "photos: $photos" +
            "availabilityTimeSlots: $availabilityTimeSlots",
      );

      final response = await homeServiceInterface.updateOffer(
        offerId: offerId,
        category: category,
        offerType: offerType,
        pricePerPerson: pricePerPerson,
        maxParticipants: maxParticipants,
        title: title,
        description: description,
        availabilityDate: availabilityDate,
        photos: photos,
        availabilityTimeSlots: availabilityTimeSlots,
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ Offer updated successfully from local \n");
        updateOfferResponseModel = UpdateOfferResponseModel.fromJson(
          response.body,
        );
        isLoading = false;
        update();
      } else {
        print("❌ Failed to update offer from local: ${response.statusCode}\n");
        Get.snackbar(
          "Error",
          "Failed to updateOffer: ${response.body['message']}",
        );
      }
    } catch (e) {
      print("⚠️ Error updating offer from local: $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getHome() async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.getHome();

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ getHome : for local fetched successfully\n");
        getHomeResponseModel = GetHomeResponseModel.fromJson(response.body);

        isLoading = false;
        update();
      }
    } catch (e) {
      print("⚠️ Error fetching profile: $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getBookingDetails(String tripId) async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.getBookingDetails(tripId);

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ getBookingDetails: for local fetched successfully\n");
        getBookingDetailsResponseModel = GetTripsDetailsResponseModel.fromJson(
          response.body,
        );

        isLoading = false;
        update();
      }
    } catch (e) {
      print("⚠️ Error fetching profile : getBookingDetails : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getBookingsAll() async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.getBookingsAll();

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ getBookingsAll : for local fetched successfully\n");
        getTripResponseApiBookingsModel =
            GetTripResponseApiBookingsModel.fromJson(response.body);

        isLoading = false;
        update();
      } else {
        getTripResponseApiBookingsModel =
            GetTripResponseApiBookingsModel.fromJson(response.body);
      }
    } catch (e) {
      print("⚠️ Error fetching profile : getBookingsAll : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getBookings(String status) async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.getBookings(status);

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ getBookings : for local fetched successfully\n");
        getTripResponseApiBookingsModel =
            GetTripResponseApiBookingsModel.fromJson(response.body);

        isLoading = false;
        update();
      } else {
        getTripResponseApiBookingsModel =
            GetTripResponseApiBookingsModel.fromJson(response.body);
      }
    } catch (e) {
      print("⚠️ Error fetching profile : getBookings : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> cencelBooking(String bookingId) async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.cencelBookings(bookingId);

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ CancelBooking : for local fetched successfully\n");
        cancelBookingResponseModel = CancelBookingResponseModel.fromJson(
          response.body,
        );

        isLoading = false;
        update();
      } else if (response.statusCode == 400) {
        print(" Cannot cancel less than 24 hours before scheduled time\n");

        Get.snackbar(
          "less than 24 hours left",
          "Cannot cancel less than 24 hours before scheduled time",
        );
        cancelBookingResponseModel = CancelBookingResponseModel.fromJson(
          response.body,
        );
        isLoading = false;
        update();
      } else {
        print(
          " ❌ Error fetching LocalHomeController : cencelBooking : ${response.body['message']}\n",
        );
        Get.snackbar("error", "${response.body['message']}");
      }
    } catch (e) {
      print("⚠️ Error fetching LocalHomeController : cencelBooking : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  //
  //
  // ********************* Tourist Section ********************* //
  //
  //
  Future<void> getSuperHatch() async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.getSuperHatch();

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ getSuperHatch : for Tourist fetched successfully\n");
        getSuperHatchResponseModel = GetSuperHatchResponseModel.fromJson(
          response.body,
        );

        isLoading = false;
        update();
      } else {
        getSuperHatchResponseModel = GetSuperHatchResponseModel.fromJson(
          response.body,
        );
      }
    } catch (e) {
      print("⚠️ Error fetching profile : getSuperHatch : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getFavoriteHatch() async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.getFavoriteHatch();

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ getFavoriteHatch : for Tourist fetched successfully\n");
        getFavoriteHatchResponseModel = GetFavoriteHatchResponseModel.fromJson(
          response.body,
        );

        isLoading = false;
        update();
      } else {
        getFavoriteHatchResponseModel = GetFavoriteHatchResponseModel.fromJson(
          response.body,
        );
      }
    } catch (e) {
      print("⚠️ Error fetching profile : getFavoriteHatch : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> searchOffer(
    String country,
    String date,
    String participants,
    String languages,
    String offerType,
  ) async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.searchOffer(
        country,
        date,
        participants,
        languages,
        offerType,
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ searchOffer : for Tourist fetched successfully\n");
        searchOfferResponseModel = SearchOfferResponseModel.fromJson(
          response.body,
        );

        isLoading = false;
        update();
      } else {
        searchOfferResponseModel = SearchOfferResponseModel.fromJson(
          response.body,
        );
      }
    } catch (e) {
      print("⚠️ Error fetching profile : searchOffer : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getOfferDetails(String localId, String offerId) async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.getOfferDetails(
        localId,
        offerId,
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ getOfferDetails : for Tourist fetched successfully\n");
        getOfferDetailsResponseModel = GetOfferDetailsResponseModel.fromJson(
          response.body,
        );

        // isLoading = false;
        // update();
      } else {
        getOfferDetailsResponseModel = GetOfferDetailsResponseModel.fromJson(
          response.body,
        );
      }
    } catch (e) {
      print("⚠️ Error fetching profile : getOfferDetails : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getLocalProfile(String localId) async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.getLocalProfile(localId);

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ getLocalProfile : for Tourist fetched successfully\n");
        getLocalProfileResponseModel = GetLocalProfileResponseModel.fromJson(
          response.body, // <-- decode JSON string to Map
        );

        isLoading = false;
        update();
      } else {
        getLocalProfileResponseModel = GetLocalProfileResponseModel.fromJson(
          jsonDecode(response.body), // <-- decode JSON string to Map
        );
      }
    } catch (e) {
      print("⚠️ Error fetching profile : getLocalProfile : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> addFavOrRemoveFav(String localId) async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.addFavOrRemove(localId);

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ addFavOrRemoveFav : for Tourist fetched successfully\n");
        addFavOrRemoveFavResponseModel =
            AddFavOrRemoveFavResponseModel.fromJson(response.body);

        isLoading = false;
        update();
      } else {
        addFavOrRemoveFavResponseModel =
            AddFavOrRemoveFavResponseModel.fromJson(response.body);
      }
    } catch (e) {
      print("⚠️ Error fetching profile : addFavOrRemoveFav : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getFab(String localId) async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.getFav();

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ getFab : for Tourist fetched successfully\n");
        getFavResponseModel = GetFavResponseModel.fromJson(response.body);

        isLoading = false;
        update();
      } else {
        getFavResponseModel = GetFavResponseModel.fromJson(response.body);
      }
    } catch (e) {
      print("⚠️ Error fetching profile : getFab : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> rateALocal(String localId, String comment, String rating) async {
    try {
      isLoading = true;
      update();

      final response = await homeServiceInterface.rateALocal(
        localId,
        comment,
        rating,
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ rateALocal : for Tourist fetched successfully\n");
        rateALocalResponseModel = RateALocalResponseModel.fromJson(
          response.body,
        );

        isLoading = false;
        update();
      } else {
        rateALocalResponseModel = RateALocalResponseModel.fromJson(
          response.body,
        );
      }
    } catch (e) {
      print("⚠️ Error fetching profile : rateALocal : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }
  // Future<void> cancelTrip(String localId, String comment, String rating) async {
  //   try {
  //     isLoading = true;
  //     update();

  //     final response = await localHomeServiceInterface.rateALocal(localId, comment, rating);

  //     debugPrint("Status Code: ${response.statusCode}");
  //     debugPrint("Response Body: ${response.body}");

  //     if (response.statusCode == 200) {
  //       print("✅ getFab : for Tourist fetched successfully\n");
  //       getFavResponseModel = GetFavResponseModel.fromJson(
  //         response.body,
  //       );

  //       isLoading = false;
  //       update();
  //     } else {
  //       getFavResponseModel = GetFavResponseModel.fromJson(
  //         response.body,
  //       );
  //     }
  //   } catch (e) {
  //     print("⚠️ Error fetching profile : getFab : $e\n");
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }
}
