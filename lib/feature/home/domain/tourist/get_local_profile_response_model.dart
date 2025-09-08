class GetLocalProfileResponseModel {
  int? statusCode;
  bool? success;
  String? message;
  LocalProfileData? data;
  List<ErrorSource>? errorSources;
  LocalProfileErr? err;
  int? stack;

  GetLocalProfileResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.errorSources,
    this.err,
    this.stack,
  });

  factory GetLocalProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return GetLocalProfileResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? LocalProfileData.fromJson(json['data']) : null,
      errorSources: json['errorSources'] != null
          ? List<ErrorSource>.from(
              json['errorSources'].map((x) => ErrorSource.fromJson(x)))
          : [],
      err: json['err'] != null ? LocalProfileErr.fromJson(json['err']) : null,
      stack: json['stack'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['statusCode'] = statusCode;
    result['success'] = success;
    result['message'] = message;
    if (data != null) result['data'] = data!.toJson();
    if (errorSources != null) {
      result['errorSources'] = errorSources!.map((v) => v.toJson()).toList();
    }
    if (err != null) result['err'] = err!.toJson();
    result['stack'] = stack;
    return result;
  }
}

/// Success Data
class LocalProfileData {
  String? name;
  List<String>? languages;
  String? about;
  List<Offer>? offers;
  double? rating;
  List<Review>? reviews;

  LocalProfileData({
    this.name,
    this.languages,
    this.about,
    this.offers,
    this.rating,
    this.reviews,
  });

  factory LocalProfileData.fromJson(Map<String, dynamic> json) {
    return LocalProfileData(
      name: json['name'],
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : [],
      about: json['about'],
      offers: json['offers'] != null
          ? List<Offer>.from(json['offers'].map((x) => Offer.fromJson(x)))
          : [],
      rating: (json['rating'] != null)
          ? (json['rating'] as num).toDouble()
          : 0.0,
      reviews: json['reviews'] != null
          ? List<Review>.from(json['reviews'].map((x) => Review.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['name'] = name;
    result['languages'] = languages;
    result['about'] = about;
    if (offers != null) {
      result['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    result['rating'] = rating;
    if (reviews != null) {
      result['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return result;
  }
}

/// Example Offer (currently empty in JSON)
class Offer {
  int? id;
  String? title;
  String? description;

  Offer({this.id, this.title, this.description});

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['title'] = title;
    result['description'] = description;
    return result;
  }
}

/// Example Review (currently empty in JSON)
class Review {
  int? id;
  String? reviewer;
  String? comment;
  double? rating;

  Review({this.id, this.reviewer, this.comment, this.rating});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      reviewer: json['reviewer'],
      comment: json['comment'],
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['reviewer'] = reviewer;
    result['comment'] = comment;
    result['rating'] = rating;
    return result;
  }
}

/// Error Sources
class ErrorSource {
  String? path;
  String? message;

  ErrorSource({this.path, this.message});

  factory ErrorSource.fromJson(Map<String, dynamic> json) {
    return ErrorSource(
      path: json['path'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['path'] = path;
    result['message'] = message;
    return result;
  }
}

/// Error Object
class LocalProfileErr {
  int? statusCode;

  LocalProfileErr({this.statusCode});

  factory LocalProfileErr.fromJson(Map<String, dynamic> json) {
    return LocalProfileErr(
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['statusCode'] = statusCode;
    return result;
  }
}
