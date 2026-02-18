class GetHomeResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final HomeData? data;

  GetHomeResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetHomeResponseModel.fromJson(Map<String, dynamic> json) {
    return GetHomeResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? HomeData.fromJson(json['data']) : null,
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

class HomeData {
  final int? earnings;
  final int? totalTours;
  final int? averageRating;
  final List<Trip>? liveTrip;
  final List<Trip>? upcomingTrips;

  HomeData({
    this.earnings,
    this.totalTours,
    this.averageRating,
    this.liveTrip,
    this.upcomingTrips,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    // ✅ FIXED: Added helper function to handle both Map and List formats safely
    List<Trip> parseTrips(dynamic data) {
      if (data == null) return [];
      if (data is List) {
        // If it's already a list → parse directly
        return data.map((e) => Trip.fromJson(e)).toList();
      } else if (data is Map) {
        // If it's a map like { "0": {...}, "1": {...} } → take values as list
        return data.values.map((e) => Trip.fromJson(e)).toList();
      }
      return [];
    }

    return HomeData(
      earnings: json['earnings'],
      totalTours: json['totalTours'],
      averageRating: json['averageRating'],

      // ✅ FIXED: Replaced direct list cast with safe parsing
      liveTrip: parseTrips(json['liveTrip']),
      upcomingTrips: parseTrips(json['upcomingTrips']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'earnings': earnings,
      'totalTours': totalTours,
      'averageRating': averageRating,
      'liveTrip': liveTrip?.map((e) => e.toJson()).toList(),
      'upcomingTrips': upcomingTrips?.map((e) => e.toJson()).toList(),
    };
  }
}

class Trip {
  final String? id;
  final UserInfo? localId;
  final UserInfo? touristId;
  final String? offerId;
  final Booking? booking;
  final String? date;
  final int? participants;
  final String? status;
  final String? createdAt;
  final int? v;
  final int? totalAmount;

  Trip({
    this.id,
    this.localId,
    this.touristId,
    this.offerId,
    this.booking,
    this.date,
    this.participants,
    this.status,
    this.createdAt,
    this.v,
    this.totalAmount,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['_id'],
      localId: json['localId'] != null ? UserInfo.fromJson(json['localId']) : null,
      touristId: json['touristId'] != null ? UserInfo.fromJson(json['touristId']) : null,
      offerId: json['offerId'],
      booking: json['booking'] != null ? Booking.fromJson(json['booking']) : null,
      date: json['date'],
      participants: json['participants'],
      status: json['status'],
      createdAt: json['createdAt'],
      v: json['__v'],
      totalAmount: json['totalAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'localId': localId?.toJson(),
      'touristId': touristId?.toJson(),
      'offerId': offerId,
      'booking': booking?.toJson(),
      'date': date,
      'participants': participants,
      'status': status,
      'createdAt': createdAt,
      '__v': v,
      'totalAmount': totalAmount,
    };
  }
}

class UserInfo {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final String? location;

  UserInfo({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.location,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImage: json['profileImage'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
      'location': location,
    };
  }
}

class Booking {
  final String? id;
  final String? bookingCode;

  Booking({
    this.id,
    this.bookingCode,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      bookingCode: json['bookingCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'bookingCode': bookingCode,
    };
  }
}
