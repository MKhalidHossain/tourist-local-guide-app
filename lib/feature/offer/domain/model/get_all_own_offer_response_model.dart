class GetAllOwnOfferResponseModel {
  final int ?statusCode;
  final bool ?success;
  final String? message;
  final List<OwnOfferData>? data;

  GetAllOwnOfferResponseModel({
     this.statusCode,
     this.success,
     this.message,
     this.data,
  });

  factory GetAllOwnOfferResponseModel.fromJson(Map<String, dynamic> json) {
    return GetAllOwnOfferResponseModel(
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => OwnOfferData.fromJson(e))
          .toList(),
    );
  }
}

class OwnOfferData {
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

  OwnOfferData({
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
  });

  factory OwnOfferData.fromJson(Map<String, dynamic> json) {
    return OwnOfferData(
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
      availability: (json['availability'] as List<dynamic>? ?? [])
          .map((e) => Availability.fromJson(e))
          .toList(),
    );
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
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      languages: List<String>.from(json['languages'] ?? []),
      registrationDate: DateTime.tryParse(json['registrationDate'] ?? '') ??
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
    );
  }
}

class Availability {
  final String id;
  final DateTime date;
  final List<String> timeSlots;

  Availability({
    required this.id,
    required this.date,
    required this.timeSlots,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      id: json['_id'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      timeSlots: List<String>.from(json['timeSlots'] ?? []),
    );
  }
}
