class GetSuperHatchResponseModel {
  int? statusCode;
  bool? success;
  String? message;
  List<SuperHatchData>? data;

  GetSuperHatchResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetSuperHatchResponseModel.fromJson(Map<String, dynamic> json) {
    return GetSuperHatchResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<SuperHatchData>.from(
              json['data'].map((x) => SuperHatchData.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['statusCode'] = statusCode;
    result['success'] = success;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.map((v) => v.toJson()).toList();
    }
    return result;
  }
}

class SuperHatchData {
  int? id;
  String? title;
  String? description;

  SuperHatchData({this.id, this.title, this.description});

  factory SuperHatchData.fromJson(Map<String, dynamic> json) {
    return SuperHatchData(
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
