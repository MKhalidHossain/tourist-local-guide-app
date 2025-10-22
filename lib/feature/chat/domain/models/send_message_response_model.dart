class SendMessageResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final MessageData? data;

  SendMessageResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory SendMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return SendMessageResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? MessageData.fromJson(json['data']) : null,
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

class MessageData {
  final String? name;
  final String? message;
  final String? avatar;
  final int? unreadCount;
  final bool? isRead;
  final bool? isMedia;
  final bool? isDocument;
  final bool? isSentByMe;
  final String? senderId;
  final String? receiverId;
  final String? fileUrl;
  final String? fileType;
  final UserInfo? sender;
  final UserInfo? receiver;

  MessageData({
    this.name,
    this.message,
    this.avatar,
    this.unreadCount,
    this.isRead,
    this.isMedia,
    this.isDocument,
    this.isSentByMe,
    this.senderId,
    this.receiverId,
    this.fileUrl,
    this.fileType,
    this.sender,
    this.receiver,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      name: json['name'],
      message: json['message'],
      avatar: json['avatar'],
      unreadCount: json['unreadCount'],
      isRead: json['isRead'],
      isMedia: json['isMedia'],
      isDocument: json['isDocument'],
      isSentByMe: json['isSentByMe'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      fileUrl: json['fileUrl'],
      fileType: json['fileType'],
      sender: json['sender'] != null ? UserInfo.fromJson(json['sender']) : null,
      receiver: json['receiver'] != null ? UserInfo.fromJson(json['receiver']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'message': message,
      'avatar': avatar,
      'unreadCount': unreadCount,
      'isRead': isRead,
      'isMedia': isMedia,
      'isDocument': isDocument,
      'isSentByMe': isSentByMe,
      'senderId': senderId,
      'receiverId': receiverId,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'sender': sender?.toJson(),
      'receiver': receiver?.toJson(),
    };
  }
}

class UserInfo {
  final String? id;
  final String? name;
  final String? avatar;

  UserInfo({
    this.id,
    this.name,
    this.avatar,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
    };
  }
}