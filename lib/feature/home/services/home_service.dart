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
  Future<Response> getTripsDetails(String tripId) async {
    return await homeRepositoryInterface.getTripsDetails(tripId);
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
    List<String> dates,
    int participantsCount,
    List<String> languages,
    String offerType,
  ) async {
    return await homeRepositoryInterface.searchOffer(
      country,
      dates,
      participantsCount,
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
  Future<Response> sendMessage(String receiverId, String message) async {
    return await homeRepositoryInterface.sendMessage(receiverId, message);
  }

  @override
  Future<Response> getUserAssociatedWithChat() async {
    return await homeRepositoryInterface.getUserAssociatedWithChat();
  }

  @override
  Future<Response> getMessages(String userId) async {
    return await homeRepositoryInterface.getMessages(userId);
  }

  @override
  Future<Response> getAllOwnOffer() async {
    return await homeRepositoryInterface.getAllOwnOffer();
  }

  @override
  Future<Response> getOwnOfferById(String offerId) async {
    return await homeRepositoryInterface.getOwnOfferById(offerId);
  }

  @override
  Future<Response> confirmPayment(
    String paymentIntentId,
    String paymentMethodId,
  ) async {
    return await homeRepositoryInterface.confirmPayment(
      paymentIntentId,
      paymentMethodId,
    );
  }

  @override
  Future<Response> connectAccount() async {
    return await homeRepositoryInterface.connectAccount();
  }

  @override
  Future<Response> createPayment(
    String bookingCode,
    String amount,
    String localId,
  ) async {
    return await homeRepositoryInterface.createPayment(
      bookingCode,
      amount,
      localId,
    );
  }

  @override
  Future<Response> resendOnboarding(String localId) async {
    return await homeRepositoryInterface.resendOnboarding(localId);
  }

  @override
  Future<Response> confirmBooking(String bookingId) async {
    return await homeRepositoryInterface.confirmBooking(bookingId);
  }

  @override
  Future<Response> createBooking(
    String localId,
    String offerId,
    String date,
    String selectedTimeSlot,
    String participants,
  ) async {
    return await homeRepositoryInterface.createBooking(
      localId,
      offerId,
      date,
      selectedTimeSlot,
      participants,
    );
  }

  @override
  Future<Response> getBookingByStatus(String status) async {
    return await homeRepositoryInterface.getBookingByStatus(status);
  }

  @override
  Future<Response> getBookingDetails(String bookingId) async {
    return await homeRepositoryInterface.getBookingDetails(bookingId);
  }

  @override
  Future<Response> updateBooking(String bookingId, String participants) async {
    return await homeRepositoryInterface.updateBooking(bookingId, participants);
  }

  @override
  Future<Response> validateAccount(String accountId) async {
    return await homeRepositoryInterface.validateAccount(accountId);
  }
}
