class GetTripsDetailsResponseModel {
  int? statusCode;
  bool? success;
  String? message;
  TripData? data;

  GetTripsDetailsResponseModel({this.statusCode, this.success, this.message, this.data});

  factory GetTripsDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetTripsDetailsResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? TripData.fromJson(json['data']) : null,
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

class TripData {
  TripDetails? trip;

  TripData({this.trip});

  factory TripData.fromJson(Map<String, dynamic> json) {
    return TripData(
      trip: json['trip'] != null ? TripDetails.fromJson(json['trip']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip': trip?.toJson(),
    };
  }
}

class TripDetails {
  String? id;
  Local? localId;
  Tourist? touristId;
  Offer? offerId;
  Booking? booking;
  DateTime? date;
  int? participants;
  String? status;
  DateTime? createdAt;
  int? v;
  int? totalAmount;

  TripDetails({
    this.id,
    this.localId,
    this.touristId,
    this.offerId,
    this.booking,
    this.date,
    this.participants,
    this.status,
    this.createdAt,
    this.v,
    this.totalAmount,
  });

  factory TripDetails.fromJson(Map<String, dynamic> json) {
    return TripDetails(
      id: json['_id'],
      localId: json['localId'] != null ? Local.fromJson(json['localId']) : null,
      touristId: json['touristId'] != null ? Tourist.fromJson(json['touristId']) : null,
      offerId: json['offerId'] != null ? Offer.fromJson(json['offerId']) : null,
      booking: json['booking'] != null ? Booking.fromJson(json['booking']) : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      participants: json['participants'],
      status: json['status'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      v: json['__v'],
      totalAmount: json['totalAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'localId': localId?.toJson(),
      'touristId': touristId?.toJson(),
      'offerId': offerId?.toJson(),
      'booking': booking?.toJson(),
      'date': date?.toIso8601String(),
      'participants': participants,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      '__v': v,
      'totalAmount': totalAmount,
    };
  }
}

class Local {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? location;

  Local({this.id, this.email, this.firstName, this.lastName, this.profileImage, this.location});

  factory Local.fromJson(Map<String, dynamic> json) {
    return Local(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImage: json['profileImage'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
      'location': location,
    };
  }
}

class Tourist {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? location;

  Tourist({this.id, this.email, this.firstName, this.lastName, this.profileImage, this.location});

  factory Tourist.fromJson(Map<String, dynamic> json) {
    return Tourist(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImage: json['profileImage'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
      'location': location,
    };
  }
}

class Offer {
  String? id;
  String? userId;
  String? category;
  String? offerType;
  int? pricePerPerson;
  int? maxParticipants;
  String? description;
  String? title;
  List<String>? languages;
  List<String>? photos;
  List<Availability>? availability;
  int? v;

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
    this.availability,
    this.v,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['_id'],
      userId: json['userId'],
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson: json['pricePerPerson'],
      maxParticipants: json['maxParticipants'],
      description: json['description'],
      title: json['title'],
      languages: json['languages'] != null ? List<String>.from(json['languages']) : null,
      photos: json['photos'] != null ? List<String>.from(json['photos']) : null,
      availability: json['availability'] != null
          ? List<Availability>.from(json['availability'].map((x) => Availability.fromJson(x)))
          : null,
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
  DateTime? date;
  List<String>? timeSlots;
  String? id;

  Availability({this.date, this.timeSlots, this.id});

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      timeSlots: json['timeSlots'] != null ? List<String>.from(json['timeSlots']) : null,
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date?.toIso8601String(),
      'timeSlots': timeSlots,
      '_id': id,
    };
  }
}

class Booking {
  String? id;
  String? bookingCode;

  Booking({this.id, this.bookingCode});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      bookingCode: json['bookingCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'bookingCode': bookingCode,
    };
  }
}
