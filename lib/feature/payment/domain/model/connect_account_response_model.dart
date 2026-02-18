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
      statusCode: json['statusCode'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
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
  final String? url;
  final String? accountId;

  ConnectAccountData({
    this.url,
    this.accountId,
  });

  factory ConnectAccountData.fromJson(Map<String, dynamic> json) {
    return ConnectAccountData(
      url: json['url'] as String?,
      accountId: json['accountId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'accountId': accountId,
    };
  }
}
