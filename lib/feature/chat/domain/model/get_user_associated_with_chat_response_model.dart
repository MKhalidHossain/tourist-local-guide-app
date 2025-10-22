class GetUserAssociatedWithChatResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final List<ChatData>? data;

  GetUserAssociatedWithChatResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetUserAssociatedWithChatResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return GetUserAssociatedWithChatResponseModel(
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => ChatData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "success": success,
      "message": message,
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }
}

class ChatData {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final int unreadCount;
  final bool isRead;
  final bool isMedia;
  final bool isDocument;
  final bool isSentByMe;
  final String senderId;
  final String receiverId;
  final String? fileUrl;
  final String? fileType;
  final ChatUser sender;
  final ChatUser receiver;

  ChatData({
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    required this.unreadCount,
    required this.isRead,
    required this.isMedia,
    required this.isDocument,
    required this.isSentByMe,
    required this.senderId,
    required this.receiverId,
    this.fileUrl,
    this.fileType,
    required this.sender,
    required this.receiver,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      name: json['name'] ?? '',
      message: json['message'] ?? '',
      time: json['time'] ?? '',
      avatar: json['avatar'] ?? '',
      unreadCount: json['unreadCount'] ?? 0,
      isRead: json['isRead'] ?? false,
      isMedia: json['isMedia'] ?? false,
      isDocument: json['isDocument'] ?? false,
      isSentByMe: json['isSentByMe'] ?? false,
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      fileUrl: json['fileUrl'],
      fileType: json['fileType'],
      sender: ChatUser.fromJson(json['sender'] ?? {}),
      receiver: ChatUser.fromJson(json['receiver'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "message": message,
      "time": time,
      "avatar": avatar,
      "unreadCount": unreadCount,
      "isRead": isRead,
      "isMedia": isMedia,
      "isDocument": isDocument,
      "isSentByMe": isSentByMe,
      "senderId": senderId,
      "receiverId": receiverId,
      "fileUrl": fileUrl,
      "fileType": fileType,
      "sender": sender.toJson(),
      "receiver": receiver.toJson(),
    };
  }
}

class ChatUser {
  final String id;
  final String name;
  final String avatar;

  ChatUser({required this.id, required this.name, required this.avatar});

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "avatar": avatar};
  }
}
