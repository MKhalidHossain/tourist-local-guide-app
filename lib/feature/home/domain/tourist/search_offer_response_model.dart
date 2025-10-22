class SearchOfferResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final List<Data>? data;

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
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Data.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class Data {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final double? averageRating;
  final int? ratingCount;
  final List<Offer>? offers;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.averageRating,
    this.ratingCount,
    this.offers,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImage: json['profileImage'],
      averageRating:
          (json['averageRating'] != null)
              ? (json['averageRating'] as num).toDouble()
              : null,
      ratingCount: json['ratingCount'],
      offers:
          (json['offers'] as List<dynamic>?)
              ?.map((e) => Offer.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
      'averageRating': averageRating,
      'ratingCount': ratingCount,
      'offers': offers?.map((e) => e.toJson()).toList(),
    };
  }
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
  final double? rating; // optional field for sorting if added later

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
    this.rating,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['_id'],
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson:
          (json['pricePerPerson'] != null)
              ? (json['pricePerPerson'] as num).toDouble()
              : null,
      maxParticipants: json['maxParticipants'],
      description: json['description'],
      title: json['title'],
      languages:
          (json['languages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      availability:
          (json['availability'] as List<dynamic>?)
              ?.map((e) => Availability.fromJson(e))
              .toList(),
      rating:
          (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'category': category,
      'offerType': offerType,
      'pricePerPerson': pricePerPerson,
      'maxParticipants': maxParticipants,
      'description': description,
      'title': title,
      'languages': languages,
      'photos': photos,
      'availability': availability?.map((e) => e.toJson()).toList(),
      'rating': rating,
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
      timeSlots:
          (json['timeSlots'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'date': date, 'timeSlots': timeSlots, '_id': id};
  }
}
