import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kobeur/feature/home/domain/local/get_home_response_model.dart';
import 'package:kobeur/feature/home/domain/local/get_trip_response_api_bookings_model.dart';
import 'package:kobeur/feature/home/domain/local/update_offer_response_model.dart';
import 'package:kobeur/feature/home/services/local/local_home_service_interface.dart';

import '../domain/local/get_booking_details_response_model.dart';

class LocalHomeTripController extends GetxController implements GetxService {
  // final localHomeController = Get.find<LocalHomeController>();

  final LocalHomeServiceInterface localHomeServiceInterface;

  LocalHomeTripController(this.localHomeServiceInterface);

  UpdateOfferResponseModel updateOfferResponseModel =
      UpdateOfferResponseModel();
  GetHomeResponseModel getHomeResponseModel = GetHomeResponseModel();
  GetTripsDetailsResponseModel getBookingDetailsResponseModel =
      GetTripsDetailsResponseModel();

  // TripBookingResponse getTripResponseApiBookingsModel =
  //     TripBookingResponse();

  TripBookingResponse upcomingTrips = TripBookingResponse();
  TripBookingResponse completedTrips = TripBookingResponse();
  TripBookingResponse cancelledTrips = TripBookingResponse();

  bool isLoading = false;

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

      final response = await localHomeServiceInterface.updateOffer(
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
          "Failed to update offer: ${response.body['message']}",
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

      final response = await localHomeServiceInterface.getHome();

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

      final response = await localHomeServiceInterface.getBookingDetails(
        tripId,
      );

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



   Future<void> getBookings(String status) async {
    try {
      isLoading = true;
   
      update();

      debugPrint("🔄 Fetching bookings with status: $status");

      final response = await localHomeServiceInterface.getBookings(status);

      debugPrint("📡 Status Code: ${response.statusCode}");
      debugPrint("📡 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final tripResponse = TripBookingResponse.fromJson(response.body);
        
        switch (status.toLowerCase()) {
          case 'upcoming':
            upcomingTrips = tripResponse;
            break;
          case 'completed':
            completedTrips = tripResponse;
            break;
          case 'cancelled':
            cancelledTrips = tripResponse;
            break;
        }

        debugPrint("✅ $status trips fetched successfully: ${tripResponse.data?.length ?? 0} items");
      } else {
       
        debugPrint("❌ Failed to fetch $status trips: ${response.statusCode}");
      }
    } catch (e) {
     
      debugPrint("⚠️ Error fetching $status trips: $e");
    } finally {
      isLoading = false;
      update();
    }
  }


    List<TripBooking> getCurrentTabData(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return upcomingTrips.data ?? [];
      case 1:
        return completedTrips.data ?? [];
      case 2:
        return cancelledTrips.data ?? [];
      default:
        return [];
    }
  }

  // Future<void> getBookings(String status) async {
  //   try {
  //     isLoading = true;
  //     update();

  //     final response = await localHomeServiceInterface.getBookings(status);

  //     debugPrint("Status Code: ${response.statusCode}");
  //     debugPrint("Response Body: ${response.body}");

  //     if (response.statusCode == 200) {
  //       print("✅ getBookings : for local fetched successfully\n");
  //       getTripResponseApiBookingsModel =
  //           GetTripResponseApiBookingsModel.fromJson(response.body);

  //       isLoading = false;
  //       update();
  //     } else {
  //       getTripResponseApiBookingsModel =
  //           GetTripResponseApiBookingsModel.fromJson(response.body);
  //     }
  //   } catch (e) {
  //     print("⚠️ Error fetching profile : getBookings : $e\n");
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }
}
