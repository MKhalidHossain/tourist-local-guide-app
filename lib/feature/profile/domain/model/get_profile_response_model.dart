class GetProfileResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final ProfileData? data;

  GetProfileResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return GetProfileResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
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

class ProfileData {
  final String? id;
  final String? email;
  final List<String>? languages;
  final String? registrationDate;
  final int? v;
  final String? role;
  final int? age;
  final String? description;
  final String? firstName;
  final String? gender;
  final String? lastName;
  final String? nationality;
  final double? averageRating;
  final int? ratingCount;
  final String? location;
  final String? profileImage;
  final List<dynamic>? ratings;
  final String? stripeAccountId;

  ProfileData({
    this.id,
    this.email,
    this.languages,
    this.registrationDate,
    this.v,
    this.role,
    this.age,
    this.description,
    this.firstName,
    this.gender,
    this.lastName,
    this.nationality,
    this.averageRating,
    this.ratingCount,
    this.location,
    this.profileImage,
    this.ratings,
    this.stripeAccountId,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['_id'],
      email: json['email'],
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : [],
      registrationDate: json['registrationDate'],
      v: json['__v'],
      role: json['role'],
      age: json['age'],
      description: json['description'],
      firstName: json['firstName'],
      gender: json['gender'],
      lastName: json['lastName'],
      nationality: json['nationality'],
      averageRating: (json['averageRating'] is int)
          ? (json['averageRating'] as int).toDouble()
          : json['averageRating'],
      ratingCount: json['ratingCount'],
      location: json['location'],
      profileImage: json['profileImage'],
      ratings: json['ratings'] != null
          ? List<dynamic>.from(json['ratings'])
          : [],
      stripeAccountId: json['stripeAccountId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'languages': languages,
      'registrationDate': registrationDate,
      '__v': v,
      'role': role,
      'age': age,
      'description': description,
      'firstName': firstName,
      'gender': gender,
      'lastName': lastName,
      'nationality': nationality,
      'averageRating': averageRating,
      'ratingCount': ratingCount,
      'location': location,
      'profileImage': profileImage,
      'ratings': ratings,
      'stripeAccountId': stripeAccountId,
    };
  }
}
