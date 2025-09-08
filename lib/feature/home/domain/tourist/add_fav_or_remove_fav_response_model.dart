class AddFavOrRemoveFavResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final FavData? data;

  AddFavOrRemoveFavResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory AddFavOrRemoveFavResponseModel.fromJson(Map<String, dynamic> json) {
    return AddFavOrRemoveFavResponseModel(
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
  final bool? favorite;
  final List<String>? favorites;

  FavData({this.favorite, this.favorites});

  factory FavData.fromJson(Map<String, dynamic> json) {
    return FavData(
      favorite: json['favorite'],
      favorites:
          json['favorites'] != null ? List<String>.from(json['favorites']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'favorite': favorite, 'favorites': favorites};
  }
}
