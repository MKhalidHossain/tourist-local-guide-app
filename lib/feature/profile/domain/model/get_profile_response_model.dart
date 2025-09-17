import 'package:flutter/material.dart';

class GetProfileResponseModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  GetProfileResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  GetProfileResponseModel.fromJson(Map<String, dynamic> json) {
    debugPrint("Parsing GetProfileResponseModel from JSON: ${json['data']}");
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;

   
  }
}

class Data {
  String? sId;
  String? email;
  List<String>? languages;
  String? registrationDate;
  List<dynamic>? ratings;
  List<dynamic>? trips;
  int? iV;
  String? role;
  int? age;
  String? description;
  String? firstName;
  String? gender;
  String? lastName;
  String? nationality;
  String? profileImage;

  Data({
    this.sId,
    this.email,
    this.languages,
    this.registrationDate,
    this.ratings,
    this.trips,
    this.iV,
    this.role,
    this.age,
    this.description,
    this.firstName,
    this.gender,
    this.lastName,
    this.nationality,
    this.profileImage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    debugPrint("Parsing GetProfileResponseModel from JSON 2: ${json['profileImage']}");
    sId = json['_id'];
    email = json['email'];
    languages = json['languages'].cast<String>();
    registrationDate = json['registrationDate'];
    if (json['ratings'] != null) {
      ratings = json['ratings'];
    }
    if (json['trips'] != null) {
      trips = json['trips'];
    }
    iV = json['__v'];
    role = json['role'];
    age = json['age'];
    description = json['description'];
    firstName = json['firstName'];
    gender = json['gender'];
    lastName = json['lastName'];
    nationality = json['nationality'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['languages'] = languages;
    data['registrationDate'] = registrationDate;
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    if (trips != null) {
      data['trips'] = trips!.map((v) => v.toJson()).toList();
    }
    if (ratings != null) {
      data['ratings'] = ratings;
    }
    if (trips != null) {
      data['trips'] = trips;
    }
    data['lastName'] = lastName;
    data['nationality'] = nationality;
    data['profileImage'] = profileImage;
    return data;
  }
}
