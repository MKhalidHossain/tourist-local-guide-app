import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeRepositoryInterface {
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
  Future<Response> getHome();
  Future<Response> getBookingDetails(String tripId);
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
    String date,
    String participants,
    String languages,
    String offerType,
  );
  Future<Response> getOfferDetails(String localId, String offerId);
  Future<Response> getLocalprofile(String localId);
  Future<Response> addFavOrRemove(String localId);
  Future<Response> getFav();
  Future<Response> rateALocal(String localId, String comment, String rating);

  Future<Response> cancelTrip(String localId);

  Future<Response> sendMessage(String userId, String message);
  Future<Response> getMessages(String userId);
  Future<Response> getUserAssociatedWithChat();

}
