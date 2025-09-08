class CreateOfferResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final OfferData data;

  CreateOfferResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory CreateOfferResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateOfferResponseModel(
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
      'data': data.toJson(),
    };
  }
}

class OfferData {
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
  final String id;
  final int v;

  OfferData({
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
    required this.id,
    required this.v,
  });

  factory OfferData.fromJson(Map<String, dynamic> json) {
    return OfferData(
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
      id: json['_id'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      '_id': id,
      '__v': v,
    };
  }
}

class Availability {
  final String date;
  final List<String> timeSlots;
  final String id;

  Availability({
    required this.date,
    required this.timeSlots,
    required this.id,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      date: json['date'],
      timeSlots: List<String>.from(json['timeSlots'] ?? []),
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
