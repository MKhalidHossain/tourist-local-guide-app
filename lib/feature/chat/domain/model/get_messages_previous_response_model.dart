class GetMessagesPreviousResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final MessagesData data;

  GetMessagesPreviousResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetMessagesPreviousResponseModel.fromJson(Map<String, dynamic> json) {
    return GetMessagesPreviousResponseModel(
      statusCode: json["statusCode"] ?? 0,
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: MessagesData.fromJson(json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "success": success,
      "message": message,
      "data": data.toJson(),
    };
  }
}

class MessagesData {
  final List<MessageItem> messages;
  final int limit;
  final int totalMessages;

  MessagesData({
    required this.messages,
    required this.limit,
    required this.totalMessages,
  });

  factory MessagesData.fromJson(Map<String, dynamic> json) {
    return MessagesData(
      messages: (json["messages"] as List<dynamic>? ?? [])
          .map((e) => MessageItem.fromJson(e))
          .toList(),
      limit: json["limit"] ?? 0,
      totalMessages: json["totalMessages"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "messages": messages.map((e) => e.toJson()).toList(),
      "limit": limit,
      "totalMessages": totalMessages,
    };
  }
}

class MessageItem {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final String? fileUrl;
  final String? fileType;
  final DateTime createdAt;

  MessageItem({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
    this.fileUrl,
    this.fileType,
  });

  factory MessageItem.fromJson(Map<String, dynamic> json) {
    return MessageItem(
      id: json["_id"] ?? "",
      senderId: json["senderId"] ?? "",
      receiverId: json["receiverId"] ?? "",
      message: json["message"] ?? "",
      fileUrl: json["fileUrl"],
      fileType: json["fileType"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "senderId": senderId,
      "receiverId": receiverId,
      "message": message,
      "fileUrl": fileUrl,
      "fileType": fileType,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
