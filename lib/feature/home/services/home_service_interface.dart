import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeServiceInterface {
  Future<Response> createOffer({
    required String category,
    required String offerType,
    required String pricePerPerson,
    required String maxParticipants,
    required String title,
    required String description,
    required List<Map<String, dynamic>> availability,
    required List<XFile> photos,
  });
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
  });

  Future<Response> getAllOwnOffer();
  Future<Response> getOwnOfferById(String offerId);

  Future<Response> getHome();
  Future<Response> getTripsDetails(String tripId);
  Future<Response> getBookings(String status);
  Future<Response> getBookingsAll();
  Future<Response> cencelBookings(String id);
  //
  // ************ tourist ************ //
  //
  Future<Response> getSuperHatch();
  Future<Response> getFavoriteHatch();
  Future<Response> searchOffer(
    String country,
    List<String> dates,
    int participantsCount,
    List<String> languages,
    String offerType,
  );
  Future<Response> getOfferDetails(String localId, String offerId);
  Future<Response> getLocalProfile(String localId);
  Future<Response> addFavOrRemove(String localId);
  Future<Response> getFav();
  Future<Response> rateALocal(String localId, String comment, String rating);
  Future<Response> cancelTrip(String localId);
  Future<Response> sendMessage(String receiverId, String message);
  Future<Response> getMessages(String userId);
  Future<Response> getUserAssociatedWithChat();
  Future<Response> connectAccount();
  Future<Response> createPayment(
    String bookingCode,
    String amount,
    String localId,
  );
  Future<Response> confirmPayment(
    String paymentIntentId,
    String paymentMethodId,
  );
  Future<Response> resendOnboarding(String localId);
    //bookings
   Future<Response> createBooking(
    String localId,
    String offerId,
    String date,
    String selectedTimeSlot,
    String participants,
  );
   Future<Response> confirmBooking(
    String bookingId,
  );
   Future<Response> updateBooking(
    String bookingId,
    String participants
  );
   Future<Response> getBookingDetails(String bookingId);
   Future<Response> getBookingByStatus(String status);
}
