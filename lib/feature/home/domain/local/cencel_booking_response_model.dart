class CancelBookingResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final CancelBookingData data;

  CancelBookingResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory CancelBookingResponseModel.fromJson(Map<String, dynamic> json) {
    return CancelBookingResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: CancelBookingData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class CancelBookingData {
  final String id;
  final String touristId;
  final String localId;
  final String offerId;
  final String date;
  final int participants;
  final String status;
  final String paymentStatus;
  final String bookingCode;
  final String createdAt;
  final int v;

  CancelBookingData({
    required this.id,
    required this.touristId,
    required this.localId,
    required this.offerId,
    required this.date,
    required this.participants,
    required this.status,
    required this.paymentStatus,
    required this.bookingCode,
    required this.createdAt,
    required this.v,
  });

  factory CancelBookingData.fromJson(Map<String, dynamic> json) {
    return CancelBookingData(
      id: json['_id'],
      touristId: json['touristId'],
      localId: json['localId'],
      offerId: json['offerId'],
      date: json['date'],
      participants: json['participants'],
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      bookingCode: json['bookingCode'],
      createdAt: json['createdAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'touristId': touristId,
      'localId': localId,
      'offerId': offerId,
      'date': date,
      'participants': participants,
      'status': status,
      'paymentStatus': paymentStatus,
      'bookingCode': bookingCode,
      'createdAt': createdAt,
      '__v': v,
    };
  }
}
