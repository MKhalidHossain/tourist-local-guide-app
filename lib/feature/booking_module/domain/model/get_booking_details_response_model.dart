class GetBookingDetailsResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final BookingData? data;

  GetBookingDetailsResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetBookingDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetBookingDetailsResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class BookingData {
  final String? id;
  final TouristId? touristId;
  final LocalId? localId;
  final OfferId? offerId;
  final String? date;
  final int? participants;
  final String? status;
  final String? paymentStatus;
  final String? bookingCode;
  final String? createdAt;
  final int? v;
  final String? localName;
  final String? localCountry;
  final OfferId? offerDetails;
  final int? totalPrice;

  BookingData({
    this.id,
    this.touristId,
    this.localId,
    this.offerId,
    this.date,
    this.participants,
    this.status,
    this.paymentStatus,
    this.bookingCode,
    this.createdAt,
    this.v,
    this.localName,
    this.localCountry,
    this.offerDetails,
    this.totalPrice,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      id: json['_id'],
      touristId: json['touristId'] != null
          ? TouristId.fromJson(json['touristId'])
          : null,
      localId:
          json['localId'] != null ? LocalId.fromJson(json['localId']) : null,
      offerId:
          json['offerId'] != null ? OfferId.fromJson(json['offerId']) : null,
      date: json['date'],
      participants: json['participants'],
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      bookingCode: json['bookingCode'],
      createdAt: json['createdAt'],
      v: json['__v'],
      localName: json['localName'],
      localCountry: json['localCountry'],
      offerDetails: json['offerDetails'] != null
          ? OfferId.fromJson(json['offerDetails'])
          : null,
      totalPrice: json['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'touristId': touristId?.toJson(),
      'localId': localId?.toJson(),
      'offerId': offerId?.toJson(),
      'date': date,
      'participants': participants,
      'status': status,
      'paymentStatus': paymentStatus,
      'bookingCode': bookingCode,
      'createdAt': createdAt,
      '__v': v,
      'localName': localName,
      'localCountry': localCountry,
      'offerDetails': offerDetails?.toJson(),
      'totalPrice': totalPrice,
    };
  }
}

class TouristId {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profileImage;

  TouristId({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  factory TouristId.fromJson(Map<String, dynamic> json) {
    return TouristId(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
    };
  }
}

class LocalId {
  final String? id;
  final String? firstName;
  final String? profileImage;
  final String? location;

  LocalId({
    this.id,
    this.firstName,
    this.profileImage,
    this.location,
  });

  factory LocalId.fromJson(Map<String, dynamic> json) {
    return LocalId(
      id: json['_id'],
      firstName: json['firstName'],
      profileImage: json['profileImage'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'profileImage': profileImage,
      'location': location,
    };
  }
}

class OfferId {
  final String? id;
  final String? userId;
  final String? category;
  final String? offerType;
  final int? pricePerPerson;
  final int? maxParticipants;
  final String? description;
  final String? title;
  final List<String>? languages;
  final List<String>? photos;
  final List<Availability>? availability;
  final int? v;

  OfferId({
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
    this.availability,
    this.v,
  });

  factory OfferId.fromJson(Map<String, dynamic> json) {
    return OfferId(
      id: json['_id'],
      userId: json['userId'],
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson: json['pricePerPerson'],
      maxParticipants: json['maxParticipants'],
      description: json['description'],
      title: json['title'],
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : [],
      photos: json['photos'] != null ? List<String>.from(json['photos']) : [],
      availability: json['availability'] != null
          ? List<Availability>.from(
              json['availability'].map((x) => Availability.fromJson(x)))
          : [],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'category': category,
      'offerType': offerType,
      'pricePerPerson': pricePerPerson,
      'maxParticipants': maxParticipants,
      'description': description,
      'title': title,
      'languages': languages,
      'photos': photos,
      'availability': availability?.map((x) => x.toJson()).toList(),
      '__v': v,
    };
  }
}

class Availability {
  final String? date;
  final List<String>? timeSlots;
  final String? id;

  Availability({this.date, this.timeSlots, this.id});

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      date: json['date'],
      timeSlots: json['timeSlots'] != null
          ? List<String>.from(json['timeSlots'])
          : [],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'timeSlots': timeSlots,
      '_id': id,
    };
  }
}
