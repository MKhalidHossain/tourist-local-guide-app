class GetBookingByStatusResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final List<BookingData>? data;

  GetBookingByStatusResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetBookingByStatusResponseModel.fromJson(Map<String, dynamic> json) {
    return GetBookingByStatusResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BookingData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "success": success,
      "message": message,
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }
}

class BookingData {
  final String? bookingId;
  final String? bookingCode;
  final String? status;
  final String? date;
  final int? participants;
  final String? createdAt;
  final String? direction;
  final int? totalPrice;
  final OfferDetails? offerDetails;
  final Tourist? tourist;
  final Local? local;

  BookingData({
    this.bookingId,
    this.bookingCode,
    this.status,
    this.date,
    this.participants,
    this.createdAt,
    this.direction,
    this.totalPrice,
    this.offerDetails,
    this.tourist,
    this.local,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      bookingId: json['bookingId'],
      bookingCode: json['bookingCode'],
      status: json['status'],
      date: json['date'],
      participants: json['participants'],
      createdAt: json['createdAt'],
      direction: json['direction'],
      totalPrice: json['totalPrice'],
      offerDetails: json['offerDetails'] != null
          ? OfferDetails.fromJson(json['offerDetails'])
          : null,
      tourist:
          json['tourist'] != null ? Tourist.fromJson(json['tourist']) : null,
      local: json['local'] != null ? Local.fromJson(json['local']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "bookingId": bookingId,
      "bookingCode": bookingCode,
      "status": status,
      "date": date,
      "participants": participants,
      "createdAt": createdAt,
      "direction": direction,
      "totalPrice": totalPrice,
      "offerDetails": offerDetails?.toJson(),
      "tourist": tourist?.toJson(),
      "local": local?.toJson(),
    };
  }
}

class OfferDetails {
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

  OfferDetails({
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

  factory OfferDetails.fromJson(Map<String, dynamic> json) {
    return OfferDetails(
      id: json['_id'],
      userId: json['userId'],
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson: json['pricePerPerson'],
      maxParticipants: json['maxParticipants'],
      description: json['description'],
      title: json['title'],
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      availability: (json['availability'] as List<dynamic>?)
          ?.map((e) => Availability.fromJson(e))
          .toList(),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "userId": userId,
      "category": category,
      "offerType": offerType,
      "pricePerPerson": pricePerPerson,
      "maxParticipants": maxParticipants,
      "description": description,
      "title": title,
      "languages": languages,
      "photos": photos,
      "availability": availability?.map((e) => e.toJson()).toList(),
      "__v": v,
    };
  }
}

class Availability {
  final String? date;
  final List<String>? timeSlots;
  final String? id;

  Availability({
    this.date,
    this.timeSlots,
    this.id,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      date: json['date'],
      timeSlots: (json['timeSlots'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "timeSlots": timeSlots,
      "_id": id,
    };
  }
}

class Tourist {
  final String? id;
  final String? name;
  final String? email;
  final String? profileImage;

  Tourist({
    this.id,
    this.name,
    this.email,
    this.profileImage,
  });

  factory Tourist.fromJson(Map<String, dynamic> json) {
    return Tourist(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "profileImage": profileImage,
    };
  }
}

class Local {
  final String? id;
  final String? name;
  final String? profileImage;
  final String? email;
  final String? location;

  Local({
    this.id,
    this.name,
    this.profileImage,
    this.email,
    this.location,
  });

  factory Local.fromJson(Map<String, dynamic> json) {
    return Local(
      id: json['id'],
      name: json['name'],
      profileImage: json['profileImage'],
      email: json['email'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "profileImage": profileImage,
      "email": email,
      "location": location,
    };
  }
}
