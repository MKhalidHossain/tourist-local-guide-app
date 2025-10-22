class ConnectAccountResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final ConnectAccountData? data;

  ConnectAccountResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory ConnectAccountResponseModel.fromJson(Map<String, dynamic> json) {
    return ConnectAccountResponseModel(
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          json['data'] != null
              ? ConnectAccountData.fromJson(json['data'])
              : null,
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

class ConnectAccountData {
  final String url;

  ConnectAccountData({required this.url});

  factory ConnectAccountData.fromJson(Map<String, dynamic> json) {
    return ConnectAccountData(url: json['url'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'url': url};
  }
}
