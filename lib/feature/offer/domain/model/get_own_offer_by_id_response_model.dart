class GetOwnOfferByIdResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final OfferData? data;

  GetOwnOfferByIdResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetOwnOfferByIdResponseModel.fromJson(Map<String, dynamic> json) {
    return GetOwnOfferByIdResponseModel(
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? OfferData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "success": success,
      "message": message,
      "data": data?.toJson(),
    };
  }
}

class OfferData {
  final String id;
  final UserId userId;
  final String category;
  final String offerType;
  final double pricePerPerson;
  final int maxParticipants;
  final String description;
  final String title;
  final List<String> languages;
  final List<String> photos;
  final List<Availability> availability;
  final int v;

  OfferData({
    required this.id,
    required this.userId,
    required this.category,
    required this.offerType,
    required this.pricePerPerson,
    required this.maxParticipants,
    required this.description,
    required this.title,
    required this.languages,
    required this.photos,
    required this.availability,
    required this.v,
  });

  factory OfferData.fromJson(Map<String, dynamic> json) {
    return OfferData(
      id: json['_id'] ?? '',
      userId: UserId.fromJson(json['userId'] ?? {}),
      category: json['category'] ?? '',
      offerType: json['offerType'] ?? '',
      pricePerPerson: (json['pricePerPerson'] ?? 0).toDouble(),
      maxParticipants: json['maxParticipants'] ?? 0,
      description: json['description'] ?? '',
      title: json['title'] ?? '',
      languages: List<String>.from(json['languages'] ?? []),
      photos: List<String>.from(json['photos'] ?? []),
      availability:
          (json['availability'] as List<dynamic>? ?? [])
              .map((e) => Availability.fromJson(e))
              .toList(),
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "userId": userId.toJson(),
      "category": category,
      "offerType": offerType,
      "pricePerPerson": pricePerPerson,
      "maxParticipants": maxParticipants,
      "description": description,
      "title": title,
      "languages": languages,
      "photos": photos,
      "availability": availability.map((e) => e.toJson()).toList(),
      "__v": v,
    };
  }
}

class UserId {
  final String id;
  final String email;
  final List<String> languages;
  final DateTime registrationDate;
  final String role;
  final int age;
  final String description;
  final String firstName;
  final String gender;
  final String lastName;
  final String nationality;
  final double averageRating;
  final int ratingCount;
  final String location;
  final String profileImage;
  final List<dynamic> ratings;
  final int v;

  UserId({
    required this.id,
    required this.email,
    required this.languages,
    required this.registrationDate,
    required this.role,
    required this.age,
    required this.description,
    required this.firstName,
    required this.gender,
    required this.lastName,
    required this.nationality,
    required this.averageRating,
    required this.ratingCount,
    required this.location,
    required this.profileImage,
    required this.ratings,
    required this.v,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      languages: List<String>.from(json['languages'] ?? []),
      registrationDate:
          DateTime.tryParse(json['registrationDate'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      role: json['role'] ?? '',
      age: json['age'] ?? 0,
      description: json['description'] ?? '',
      firstName: json['firstName'] ?? '',
      gender: json['gender'] ?? '',
      lastName: json['lastName'] ?? '',
      nationality: json['nationality'] ?? '',
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      ratingCount: json['ratingCount'] ?? 0,
      location: json['location'] ?? '',
      profileImage: json['profileImage'] ?? '',
      ratings: List<dynamic>.from(json['ratings'] ?? []),
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "languages": languages,
      "registrationDate": registrationDate.toIso8601String(),
      "role": role,
      "age": age,
      "description": description,
      "firstName": firstName,
      "gender": gender,
      "lastName": lastName,
      "nationality": nationality,
      "averageRating": averageRating,
      "ratingCount": ratingCount,
      "location": location,
      "profileImage": profileImage,
      "ratings": ratings,
      "__v": v,
    };
  }
}

class Availability {
  final String id;
  final DateTime date;
  final List<String> timeSlots;

  Availability({required this.id, required this.date, required this.timeSlots});

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      id: json['_id'] ?? '',
      date:
          DateTime.tryParse(json['date'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      timeSlots: List<String>.from(json['timeSlots'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {"_id": id, "date": date.toIso8601String(), "timeSlots": timeSlots};
  }
}
