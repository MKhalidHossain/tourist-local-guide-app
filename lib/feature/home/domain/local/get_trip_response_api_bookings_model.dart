class TripBookingResponse {
  final int? statusCode;
  final bool? success;
  final String? message;
  final List<TripBooking>? data;

  TripBookingResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory TripBookingResponse.fromJson(Map<String, dynamic> json) {
    return TripBookingResponse(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((item) => TripBooking.fromJson(item)).toList()
          : null,
    );
  }
}

class TripBooking {
  final String? id;
  final LocalUser? localId;
  final TouristUser? touristId;
  final Offer? offerId;
  final Booking? booking;
  final DateTime? date;
  final int? participants;
  final String? status;
  final DateTime? createdAt;
  final double? totalAmount;
  final int? rating;

  TripBooking({
    this.id,
    this.localId,
    this.touristId,
    this.offerId,
    this.booking,
    this.date,
    this.participants,
    this.status,
    this.createdAt,
    this.totalAmount,
    this.rating,
  });

  factory TripBooking.fromJson(Map<String, dynamic> json) {
    return TripBooking(
      id: json['_id'],
      localId: json['localId'] != null ? LocalUser.fromJson(json['localId']) : null,
      touristId: json['touristId'] != null ? TouristUser.fromJson(json['touristId']) : null,
      offerId: json['offerId'] != null ? Offer.fromJson(json['offerId']) : null,
      booking: json['booking'] != null ? Booking.fromJson(json['booking']) : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      participants: json['participants'],
      status: json['status'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      totalAmount: json['totalAmount']?.toDouble(),
      rating: json['rating'],
    );
  }
}

class LocalUser {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final String? location;

  LocalUser({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.location,
  });

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImage: json['profileImage'],
      location: json['location'],
    );
  }
}

class TouristUser {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? location;
  final String? profileImage;

  TouristUser({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.location,
    this.profileImage,
  });

  factory TouristUser.fromJson(Map<String, dynamic> json) {
    return TouristUser(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      location: json['location'],
      profileImage: json['profileImage'],
    );
  }
}

class Offer {
  final String? id;
  final String? userId;
  final String? category;
  final String? offerType;
  final double? pricePerPerson;
  final int? maxParticipants;
  final String? description;
  final String? title;
  final List<String>? languages;
  final List<String>? photos;

  Offer({
    this.id,
    this.userId,
    this.category,
    this.offerType,
    this.pricePerPerson,
    this.maxParticipants,
    this.description,
    this.title,
    this.languages,
    this.photos,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['_id'],
      userId: json['userId'],
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson: json['pricePerPerson']?.toDouble(),
      maxParticipants: json['maxParticipants'],
      description: json['description'],
      title: json['title'],
      languages: json['languages'] != null ? List<String>.from(json['languages']) : null,
      photos: json['photos'] != null ? List<String>.from(json['photos']) : null,
    );
  }
}

class Booking {
  final String? id;
  final String? bookingCode;

  Booking({
    this.id,
    this.bookingCode,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      bookingCode: json['bookingCode'],
    );
  }
}





// class GetTripResponseApiBookingsModel {
//   int? statusCode;
//   bool? success;
//   String? message;
//   List<TripItem>? data;

//   GetTripResponseApiBookingsModel({this.statusCode, this.success, this.message, this.data});

//   factory GetTripResponseApiBookingsModel.fromJson(Map<String, dynamic> json) {
//     return GetTripResponseApiBookingsModel(
//       statusCode: json['statusCode'],
//       success: json['success'],
//       message: json['message'],
//       data: json['data'] != null
//           ? List<TripItem>.from(json['data'].map((x) => TripItem.fromJson(x)))
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'statusCode': statusCode,
//       'success': success,
//       'message': message,
//       'data': data?.map((x) => x.toJson()).toList(),
//     };
//   }
// }

// class TripItem {
//   String? id;
//   Local? localId;
//   Tourist? touristId;
//   Offer? offerId;
//   Booking? booking;
//   DateTime? date;
//   int? participants;
//   String? status;
//   DateTime? createdAt;
//   int? v;
//   int? totalAmount;
//   int? rating;

//   TripItem({
//     this.id,
//     this.localId,
//     this.touristId,
//     this.offerId,
//     this.booking,
//     this.date,
//     this.participants,
//     this.status,
//     this.createdAt,
//     this.v,
//     this.totalAmount,
//     this.rating,
//   });

//   factory TripItem.fromJson(Map<String, dynamic> json) {
//     return TripItem(
//       id: json['_id'],
//       localId: json['localId'] != null ? Local.fromJson(json['localId']) : null,
//       touristId: json['touristId'] != null ? Tourist.fromJson(json['touristId']) : null,
//       offerId: json['offerId'] != null ? Offer.fromJson(json['offerId']) : null,
//       booking: json['booking'] != null ? Booking.fromJson(json['booking']) : null,
//       date: json['date'] != null ? DateTime.parse(json['date']) : null,
//       participants: json['participants'],
//       status: json['status'],
//       createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
//       v: json['__v'],
//       totalAmount: json['totalAmount'],
//       rating: json['rating'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'localId': localId?.toJson(),
//       'touristId': touristId?.toJson(),
//       'offerId': offerId?.toJson(),
//       'booking': booking?.toJson(),
//       'date': date?.toIso8601String(),
//       'participants': participants,
//       'status': status,
//       'createdAt': createdAt?.toIso8601String(),
//       '__v': v,
//       'totalAmount': totalAmount,
//       'rating': rating,
//     };
//   }
// }

// class Local {
//   String? id;
//   String? email;
//   String? firstName;
//   String? lastName;
//   String? profileImage;
//   String? location;

//   Local({this.id, this.email, this.firstName, this.lastName, this.profileImage, this.location});

//   factory Local.fromJson(Map<String, dynamic> json) {
//     return Local(
//       id: json['_id'],
//       email: json['email'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       profileImage: json['profileImage'],
//       location: json['location'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'email': email,
//       'firstName': firstName,
//       'lastName': lastName,
//       'profileImage': profileImage,
//       'location': location,
//     };
//   }
// }

// class Tourist {
//   String? id;
//   String? email;
//   String? firstName;
//   String? lastName;
//   String? location;
//   String? profileImage;

//   Tourist({this.id, this.email, this.firstName, this.lastName, this.location, this.profileImage});

//   factory Tourist.fromJson(Map<String, dynamic> json) {
//     return Tourist(
//       id: json['_id'],
//       email: json['email'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       location: json['location'],
//       profileImage: json['profileImage'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'email': email,
//       'firstName': firstName,
//       'lastName': lastName,
//       'location': location,
//       'profileImage': profileImage,
//     };
//   }
// }

// class Offer {
//   String? id;
//   String? userId;
//   String? category;
//   String? offerType;
//   int? pricePerPerson;
//   int? maxParticipants;
//   String? description;
//   String? title;
//   List<String>? languages;
//   List<String>? photos;
//   List<Availability>? availability;
//   int? v;

//   Offer({
//     this.id,
//     this.userId,
//     this.category,
//     this.offerType,
//     this.pricePerPerson,
//     this.maxParticipants,
//     this.description,
//     this.title,
//     this.languages,
//     this.photos,
//     this.availability,
//     this.v,
//   });

//   factory Offer.fromJson(Map<String, dynamic> json) {
//     return Offer(
//       id: json['_id'],
//       userId: json['userId'],
//       category: json['category'],
//       offerType: json['offerType'],
//       pricePerPerson: json['pricePerPerson'],
//       maxParticipants: json['maxParticipants'],
//       description: json['description'],
//       title: json['title'],
//       languages: json['languages'] != null ? List<String>.from(json['languages']) : null,
//       photos: json['photos'] != null ? List<String>.from(json['photos']) : null,
//       availability: json['availability'] != null
//           ? List<Availability>.from(json['availability'].map((x) => Availability.fromJson(x)))
//           : null,
//       v: json['__v'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'userId': userId,
//       'category': category,
//       'offerType': offerType,
//       'pricePerPerson': pricePerPerson,
//       'maxParticipants': maxParticipants,
//       'description': description,
//       'title': title,
//       'languages': languages,
//       'photos': photos,
//       'availability': availability?.map((x) => x.toJson()).toList(),
//       '__v': v,
//     };
//   }
// }

// class Availability {
//   DateTime? date;
//   List<String>? timeSlots;
//   String? id;

//   Availability({this.date, this.timeSlots, this.id});

//   factory Availability.fromJson(Map<String, dynamic> json) {
//     return Availability(
//       date: json['date'] != null ? DateTime.parse(json['date']) : null,
//       timeSlots: json['timeSlots'] != null ? List<String>.from(json['timeSlots']) : null,
//       id: json['_id'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'date': date?.toIso8601String(),
//       'timeSlots': timeSlots,
//       '_id': id,
//     };
//   }
// }

// class Booking {
//   String? id;
//   String? bookingCode;

//   Booking({this.id, this.bookingCode});

//   factory Booking.fromJson(Map<String, dynamic> json) {
//     return Booking(
//       id: json['_id'],
//       bookingCode: json['bookingCode'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'bookingCode': bookingCode,
//     };
//   }
// }
