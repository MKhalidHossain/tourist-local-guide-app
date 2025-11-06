class ResendOnboardingResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final ResendOnboardingData? data;

  ResendOnboardingResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory ResendOnboardingResponseModel.fromJson(Map<String, dynamic> json) {
    return ResendOnboardingResponseModel(
      statusCode: json['statusCode'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ResendOnboardingData.fromJson(json['data'])
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

class ResendOnboardingData {
  final String? url;

  ResendOnboardingData({this.url});

  factory ResendOnboardingData.fromJson(Map<String, dynamic> json) {
    return ResendOnboardingData(
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}
