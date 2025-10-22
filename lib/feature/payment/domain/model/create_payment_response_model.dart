class CreatePaymentResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final PaymentData? data;

  CreatePaymentResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory CreatePaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return CreatePaymentResponseModel(
      statusCode: json['statusCode'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? PaymentData.fromJson(json['data'] as Map<String, dynamic>)
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

class PaymentData {
  final String? transactionId;
  final String? clientSecret;

  PaymentData({this.transactionId, this.clientSecret});

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      transactionId: json['transactionId'] as String?,
      clientSecret: json['clientSecret'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'clientSecret': clientSecret,
    };
  }
}
