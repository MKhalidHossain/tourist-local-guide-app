class RoleSwitchResponseModel {
  final int ?statusCode;
  final bool ?success;
  final String ?message;
  final RoleSwitchData? data;

  RoleSwitchResponseModel({
     this.statusCode,
     this.success,
     this.message,
    this.data,
  });

  factory RoleSwitchResponseModel.fromJson(Map<String, dynamic> json) {
    return RoleSwitchResponseModel(
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? RoleSwitchData.fromJson(json['data'])
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

class RoleSwitchData {
  final String accessToken;
  final String refreshToken;

  RoleSwitchData({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RoleSwitchData.fromJson(Map<String, dynamic> json) {
    return RoleSwitchData(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
