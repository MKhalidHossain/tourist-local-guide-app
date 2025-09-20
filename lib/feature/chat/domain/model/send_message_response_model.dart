class SendMessageResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final MessageData data;

  SendMessageResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory SendMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return SendMessageResponseModel(
      statusCode: json["statusCode"] ?? 0,
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: MessageData.fromJson(json["data"] ?? {}),
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

class MessageData {
  final String senderId;
  final String receiverId;
  final String message;
  final String? fileUrl;
  final String? fileType;

  MessageData({
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.fileUrl,
    this.fileType,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      senderId: json["senderId"] ?? "",
      receiverId: json["receiverId"] ?? "",
      message: json["message"] ?? "",
      fileUrl: json["fileUrl"],
      fileType: json["fileType"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "message": message,
      "fileUrl": fileUrl,
      "fileType": fileType,
    };
  }
}
