class CreateBookingResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final BookingData? data;

  CreateBookingResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory CreateBookingResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateBookingResponseModel(
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
  final Booking? booking;
  final Summary? summary;

  BookingData({this.booking, this.summary});

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      booking: json['booking'] != null ? Booking.fromJson(json['booking']) : null,
      summary: json['summary'] != null ? Summary.fromJson(json['summary']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking': booking?.toJson(),
      'summary': summary?.toJson(),
    };
  }
}

class Booking {
  final String? localId;
  final String? offerId;
  final String? date;
  final int? participants;
  final String? status;
  final String? paymentStatus;
  final String? id;
  final String? bookingCode;
  final String? createdAt;

  Booking({
    this.localId,
    this.offerId,
    this.date,
    this.participants,
    this.status,
    this.paymentStatus,
    this.id,
    this.bookingCode,
    this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      localId: json['localId'],
      offerId: json['offerId'],
      date: json['date'],
      participants: json['participants'],
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      id: json['_id'],
      bookingCode: json['bookingCode'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localId': localId,
      'offerId': offerId,
      'date': date,
      'participants': participants,
      'status': status,
      'paymentStatus': paymentStatus,
      '_id': id,
      'bookingCode': bookingCode,
      'createdAt': createdAt,
    };
  }
}

class Summary {
  final String? serviceName;
  final String? schedule;
  final int? participants;
  final int? pricePerPerson;
  final int? total;

  Summary({
    this.serviceName,
    this.schedule,
    this.participants,
    this.pricePerPerson,
    this.total,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      serviceName: json['serviceName'],
      schedule: json['schedule'],
      participants: json['participants'],
      pricePerPerson: json['pricePerPerson'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceName': serviceName,
      'schedule': schedule,
      'participants': participants,
      'pricePerPerson': pricePerPerson,
      'total': total,
    };
  }
}
