class ValidateAccountResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final ValidateAccountData? data;

  ValidateAccountResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory ValidateAccountResponseModel.fromJson(Map<String, dynamic> json) {
    return ValidateAccountResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? ValidateAccountData.fromJson(json['data'])
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

class ValidateAccountData {
  final String? stripeAccountId;
  final bool? chargesEnabled;

  ValidateAccountData({
    this.stripeAccountId,
    this.chargesEnabled,
  });

  factory ValidateAccountData.fromJson(Map<String, dynamic> json) {
    return ValidateAccountData(
      stripeAccountId: json['stripeAccountId'],
      chargesEnabled: json['charges_enabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stripeAccountId': stripeAccountId,
      'charges_enabled': chargesEnabled,
    };
  }
}
