import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';

abstract class LocalHomeServiceInterface {
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
  Future<Response> cencelBookings(String id);
}
