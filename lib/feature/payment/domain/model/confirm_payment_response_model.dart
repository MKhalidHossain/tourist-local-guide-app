class ConfirmPaymentResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final ConfirmPaymentData? data;

  ConfirmPaymentResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory ConfirmPaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return ConfirmPaymentResponseModel(
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          json['data'] != null
              ? ConfirmPaymentData.fromJson(json['data'])
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

class ConfirmPaymentData {
  final String transactionId;
  final String bookingCode;

  ConfirmPaymentData({required this.transactionId, required this.bookingCode});

  factory ConfirmPaymentData.fromJson(Map<String, dynamic> json) {
    return ConfirmPaymentData(
      transactionId: json['transactionId'] ?? '',
      bookingCode: json['bookingCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'transactionId': transactionId, 'bookingCode': bookingCode};
  }
}
