class UpdateOfferResponseModel {
   int? statusCode;
   bool? success;
   String? message;
   OfferData? data;

  UpdateOfferResponseModel({
     this.statusCode,
     this.success,
     this.message,
     this.data,
  });

  factory UpdateOfferResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateOfferResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: OfferData.fromJson(json['data']),
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

class OfferData {
  final String id;
  final String userId;
  final String category;
  final String offerType;
  final int pricePerPerson;
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
      id: json['_id'],
      userId: json['userId'],
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson: json['pricePerPerson'],
      maxParticipants: json['maxParticipants'],
      description: json['description'],
      title: json['title'],
      languages: List<String>.from(json['languages'] ?? []),
      photos: List<String>.from(json['photos'] ?? []),
      availability: (json['availability'] as List<dynamic>?)
              ?.map((e) => Availability.fromJson(e))
              .toList() ??
          [],
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
      'availability': availability.map((e) => e.toJson()).toList(),
      '__v': v,
    };
  }
}

class Availability {
  final String id;
  final String date;
  final List<String> timeSlots;

  Availability({
    required this.id,
    required this.date,
    required this.timeSlots,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      id: json['_id'],
      date: json['date'],
      timeSlots: List<String>.from(json['timeSlots'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date,
      'timeSlots': timeSlots,
    };
  }
}
