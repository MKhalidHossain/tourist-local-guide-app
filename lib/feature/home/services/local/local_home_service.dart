import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import '../../repositories/local/local_home_repository_interface.dart';
import 'local_home_service_interface.dart';

class LocalHomeService implements LocalHomeServiceInterface {
  final LocalHomeRepositoryInterface localHomeRepositoryInterface;

  LocalHomeService(this.localHomeRepositoryInterface);

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
    return await localHomeRepositoryInterface.updateOffer(
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
  }

  @override
  Future<Response> getHome() async {
    return await localHomeRepositoryInterface.getHome();
  }

  @override
  Future<Response> getBookingDetails(String tripId) async {
    return await localHomeRepositoryInterface.getBookingDetails(tripId);
  }

  @override
  Future<Response> getBookings(String status) async {
    return await localHomeRepositoryInterface.getBookings(status);
  }

  @override
  Future<Response> cencelBookings(String id) async {
    return await localHomeRepositoryInterface.cencelBookings(id);
  }
}
