class ConfirmBookingResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final BookingData? data;

  ConfirmBookingResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory ConfirmBookingResponseModel.fromJson(Map<String, dynamic> json) {
    return ConfirmBookingResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
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

class BookingData {
  final String? id;
  final String? touristId;
  final String? localId;
  final String? offerId;
  final String? date;
  final int? participants;
  final String? status;
  final String? paymentStatus;
  final String? bookingCode;
  final String? createdAt;
  final int? v;

  BookingData({
    this.id,
    this.touristId,
    this.localId,
    this.offerId,
    this.date,
    this.participants,
    this.status,
    this.paymentStatus,
    this.bookingCode,
    this.createdAt,
    this.v,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
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
