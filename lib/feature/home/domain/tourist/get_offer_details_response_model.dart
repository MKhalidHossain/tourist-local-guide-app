class GetOfferDetailsResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final OfferDetailsData? data;

  GetOfferDetailsResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetOfferDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetOfferDetailsResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? OfferDetailsData.fromJson(json['data']) : null,
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

class OfferDetailsData {
  final Local? local;
  final Offer? offer;

  OfferDetailsData({this.local, this.offer});

  factory OfferDetailsData.fromJson(Map<String, dynamic> json) {
    return OfferDetailsData(
      local: json['local'] != null ? Local.fromJson(json['local']) : null,
      offer: json['offer'] != null ? Offer.fromJson(json['offer']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'local': local?.toJson(),
      'offer': offer?.toJson(),
    };
  }
}

class Local {
  final String? id;
  final List<String>? languages;
  final int? age;
  final String? description;
  final String? firstName;
  final String? gender;
  final String? lastName;
  final double? averageRating;
  final int? ratingCount;
  final String? location;
  final String? profileImage;
  final List<dynamic>? ratings;

  Local({
    this.id,
    this.languages,
    this.age,
    this.description,
    this.firstName,
    this.gender,
    this.lastName,
    this.averageRating,
    this.ratingCount,
    this.location,
    this.profileImage,
    this.ratings,
  });

  factory Local.fromJson(Map<String, dynamic> json) {
    return Local(
      id: json['_id'],
      languages: json['languages'] != null ? List<String>.from(json['languages']) : [],
      age: json['age'],
      description: json['description'],
      firstName: json['firstName'],
      gender: json['gender'],
      lastName: json['lastName'],
      averageRating: (json['averageRating'] != null)
          ? json['averageRating'].toDouble()
          : null,
      ratingCount: json['ratingCount'],
      location: json['location'],
      profileImage: json['profileImage'],
      ratings: json['ratings'] != null ? List<dynamic>.from(json['ratings']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'languages': languages,
      'age': age,
      'description': description,
      'firstName': firstName,
      'gender': gender,
      'lastName': lastName,
      'averageRating': averageRating,
      'ratingCount': ratingCount,
      'location': location,
      'profileImage': profileImage,
      'ratings': ratings,
    };
  }
}

class Offer {
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
      languages: json['languages'] != null ? List<String>.from(json['languages']) : [],
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
      timeSlots: json['timeSlots'] != null ? List<String>.from(json['timeSlots']) : [],
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
