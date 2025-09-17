class CreateOfferResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final OfferData? data;

  CreateOfferResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory CreateOfferResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateOfferResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? OfferData.fromJson(json['data']) : null,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'statusCode': statusCode,
  //     'success': success,
  //     'message': message,
  //     'data': data?.toJson(),
  //   };
  // }
}

class OfferData {
  final String? userId;
  final String? category;
  final String? offerType;
  final int? pricePerPerson;
  final int? maxParticipants;
  final String? description;
  final String? title;
  final List<String>? languages;
  final List<String>? photos;
  final List<AvailabilityModel>? availability;
  final String? id;
  final int? v;

  OfferData({
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
    this.id,
    this.v,
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
          ?.map((e) => AvailabilityModel.fromJson(e))
          .toList(),
      id: json['_id'],
      v: json['__v'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'userId': userId,
  //     'category': category,
  //     'offerType': offerType,
  //     'pricePerPerson': pricePerPerson,
  //     'maxParticipants': maxParticipants,
  //     'description': description,
  //     'title': title,
  //     'languages': languages,
  //     'photos': photos,
  //     'availability': availability?.map((e) => e.toJson()).toList(),
  //     '_id': id,
  //     '__v': v,
  //   };
  // }
}

class AvailabilityModel {
  final String? date;
  final List<String>? timeSlots;
  final String? id;

  AvailabilityModel({
    this.date,
    this.timeSlots,
    this.id,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityModel(
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
