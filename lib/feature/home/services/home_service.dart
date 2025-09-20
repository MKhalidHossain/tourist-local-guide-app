import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import '../repositories/home_repository_interface.dart';
import 'home_service_interface.dart';

class HomeService implements HomeServiceInterface {
  final HomeRepositoryInterface homeRepositoryInterface;

  HomeService(this.homeRepositoryInterface);

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
    return await homeRepositoryInterface.createOffer(
      category: category,
      offerType: offerType,
      pricePerPerson: pricePerPerson,
      maxParticipants: maxParticipants,
      title: title,
      description: description,
      availability: availability,
      photos: photos,
 
    );
  }

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
    return await homeRepositoryInterface.updateOffer(
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
    return await homeRepositoryInterface.getHome();
  }

  @override
  Future<Response> getBookingDetails(String tripId) async {
    return await homeRepositoryInterface.getBookingDetails(tripId);
  }

  @override
  Future<Response> getBookingsAll() async {
    return await homeRepositoryInterface.getBookingsAll();
  }

  @override
  Future<Response> getBookings(String status) async {
    return await homeRepositoryInterface.getBookings(status);
  }

  @override
  Future<Response> cencelBookings(String id) async {
    return await homeRepositoryInterface.cencelBookings(id);
  }

  //
  // ************ tourist ************ //
  //
  @override
  Future<Response> getSuperHatch() async {
    return await homeRepositoryInterface.getSuperHatch();
  }

  @override
  Future<Response> addFavOrRemove(String localId) async {
    return await homeRepositoryInterface.addFavOrRemove(localId);
  }

  @override
  Future<Response> cancelTrip(String localId) async {
    return await homeRepositoryInterface.cancelTrip(localId);
  }

  @override
  Future<Response> getFav() async {
    return await homeRepositoryInterface.getFav();
  }

  @override
  Future<Response> getFavoriteHatch() async {
    return await homeRepositoryInterface.getFavoriteHatch();
  }

  @override
  Future<Response> getLocalProfile(String localId) async {
    return await homeRepositoryInterface.getLocalprofile(localId);
  }

  @override
  Future<Response> getOfferDetails(String localId, String offerId) async {
    return await homeRepositoryInterface.getOfferDetails(localId, offerId);
  }

  @override
  Future<Response> searchOffer(
    String country,
    String date,
    String participants,
    String languages,
    String offerType,
  ) async {
    return await homeRepositoryInterface.searchOffer(
      country,
      date,
      participants,
      languages,
      offerType,
    );
  }

  @override
  Future<Response> rateALocal(
    String localId,
    String comment,
    String rating,
  ) async {
    return await homeRepositoryInterface.rateALocal(localId, comment, rating);
  }
  
  @override
  Future<Response> sendMessage(String userId, String message) async{
    return await homeRepositoryInterface.sendMessage(userId, message);
  }
  
  @override
  Future<Response> getUserAssociatedWithChat() async{
    return await homeRepositoryInterface.getUserAssociatedWithChat();
  }
  
  @override
  Future<Response> getMessages(String userId) async{
    return await homeRepositoryInterface.getMessages(userId);
  }
}
