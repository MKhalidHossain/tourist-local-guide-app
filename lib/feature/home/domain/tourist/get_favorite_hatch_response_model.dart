class GetFavoriteHatchResponseModel {
  int? statusCode;
  bool? success;
  String? message;
  FavoriteData? data;

  GetFavoriteHatchResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetFavoriteHatchResponseModel.fromJson(Map<String, dynamic> json) {
    return GetFavoriteHatchResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? FavoriteData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['statusCode'] = statusCode;
    result['success'] = success;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
}

class FavoriteData {
  List<FavoriteItem>? favorites;

  FavoriteData({this.favorites});

  factory FavoriteData.fromJson(Map<String, dynamic> json) {
    return FavoriteData(
      favorites:
          json['favorites'] != null
              ? List<FavoriteItem>.from(
                json['favorites'].map((x) => FavoriteItem.fromJson(x)),
              )
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (favorites != null) {
      result['favorites'] = favorites!.map((v) => v.toJson()).toList();
    }
    return result;
  }
}

class FavoriteItem {
  int? id;
  String? name;
  String? type;

  FavoriteItem({this.id, this.name, this.type});

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(id: json['id'], name: json['name'], type: json['type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['name'] = name;
    result['type'] = type;
    return result;
  }
}
