class SearchOfferResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final List<SearchOfferData>? data;

  SearchOfferResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory SearchOfferResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchOfferResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<SearchOfferData>.from(
              json['data'].map((x) => SearchOfferData.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "message": message,
        "data": data?.map((x) => x.toJson()).toList(),
      };
}

class SearchOfferData {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final List<Offer>? offers;

  SearchOfferData({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.offers,
  });

  factory SearchOfferData.fromJson(Map<String, dynamic> json) {
    return SearchOfferData(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImage: json['profileImage'],
      offers: json['offers'] != null
          ? List<Offer>.from(json['offers'].map((x) => Offer.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profileImage": profileImage,
        "offers": offers?.map((x) => x.toJson()).toList(),
      };
}

class Offer {
  final String? id;
  final String? category;
  final String? offerType;
  final double? pricePerPerson;
  final int? maxParticipants;
  final String? description;
  final String? title;
  final List<String>? languages;
  final List<String>? photos;
  final List<Availability>? availability;

  Offer({
    this.id,
    this.category,
    this.offerType,
    this.pricePerPerson,
    this.maxParticipants,
    this.description,
    this.title,
    this.languages,
    this.photos,
    this.availability,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['_id'],
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson: (json['pricePerPerson'] is int)
          ? (json['pricePerPerson'] as int).toDouble()
          : json['pricePerPerson']?.toDouble(),
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
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category": category,
        "offerType": offerType,
        "pricePerPerson": pricePerPerson,
        "maxParticipants": maxParticipants,
        "description": description,
        "title": title,
        "languages": languages,
        "photos": photos,
        "availability": availability?.map((x) => x.toJson()).toList(),
      };
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
      timeSlots: json['timeSlots'] != null
          ? List<String>.from(json['timeSlots'])
          : [],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "timeSlots": timeSlots,
        "_id": id,
      };
}
