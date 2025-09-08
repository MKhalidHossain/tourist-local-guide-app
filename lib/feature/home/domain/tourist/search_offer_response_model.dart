class SearchOfferResponseModel {
  int? statusCode;
  bool? success;
  String? message;
  SearchOfferData? data;

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
      data: json['data'] != null ? SearchOfferData.fromJson(json['data']) : null,
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

class SearchOfferData {
  List<LocalItem>? locals;

  SearchOfferData({this.locals});

  factory SearchOfferData.fromJson(Map<String, dynamic> json) {
    return SearchOfferData(
      locals: json['locals'] != null
          ? List<LocalItem>.from(
              json['locals'].map((x) => LocalItem.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (locals != null) {
      result['locals'] = locals!.map((v) => v.toJson()).toList();
    }
    return result;
  }
}

class LocalItem {
  int? id;
  String? name;
  String? serviceType;

  LocalItem({this.id, this.name, this.serviceType});

  factory LocalItem.fromJson(Map<String, dynamic> json) {
    return LocalItem(
      id: json['id'],
      name: json['name'],
      serviceType: json['serviceType'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['name'] = name;
    result['serviceType'] = serviceType;
    return result;
  }
}
