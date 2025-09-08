class GetFavResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final FavData? data;

  GetFavResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetFavResponseModel.fromJson(Map<String, dynamic> json) {
    return GetFavResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? FavData.fromJson(json['data']) : null,
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

class FavData {
  final List<Favorite>? favorites;

  FavData({this.favorites});

  factory FavData.fromJson(Map<String, dynamic> json) {
    return FavData(
      favorites: json['favorites'] != null
          ? List<Favorite>.from(
              json['favorites'].map((x) => Favorite.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favorites': favorites?.map((x) => x.toJson()).toList(),
    };
  }
}

class Favorite {
  final String? id;
  final String? email;
  final List<String>? languages;
  final String? registrationDate;
  final List<dynamic>? ratings;
  final List<dynamic>? offers;
  final List<dynamic>? trips;
  final int? v;
  final String? role;
  final int? age;
  final String? description;
  final String? firstName;
  final String? gender;
  final String? lastName;
  final String? nationality;

  Favorite({
    this.id,
    this.email,
    this.languages,
    this.registrationDate,
    this.ratings,
    this.offers,
    this.trips,
    this.v,
    this.role,
    this.age,
    this.description,
    this.firstName,
    this.gender,
    this.lastName,
    this.nationality,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['_id'],
      email: json['email'],
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : [],
      registrationDate: json['registrationDate'],
      ratings: json['ratings'] ?? [],
      offers: json['offers'] ?? [],
      trips: json['trips'] ?? [],
      v: json['__v'],
      role: json['role'],
      age: json['age'],
      description: json['description'],
      firstName: json['firstName'],
      gender: json['gender'],
      lastName: json['lastName'],
      nationality: json['nationality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'languages': languages,
      'registrationDate': registrationDate,
      'ratings': ratings,
      'offers': offers,
      'trips': trips,
      '__v': v,
      'role': role,
      'age': age,
      'description': description,
      'firstName': firstName,
      'gender': gender,
      'lastName': lastName,
      'nationality': nationality,
    };
  }
}
