class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String time;
  final String? messageId;
  final String? senderId;
  final String? receiverId;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.time,
    this.messageId,
    this.senderId,
    this.receiverId,
  });

  // Factory for creating from API/Socket JSON
  factory ChatMessage.fromJson(Map<String, dynamic> json, String currentUserId) {
    return ChatMessage(
      text: json['message'] ?? '',
      isSentByMe: json['senderId'] == currentUserId,
      time: json['time'] ?? DateTime.now().toIso8601String(),
      messageId: json['_id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
    );
  }

  // ✅ Convert ChatMessage → JSON for sending to API/Socket
  Map<String, dynamic> toJson() {
    return {
      "message": text,
      "time": time,
      "senderId": senderId,
      "receiverId": receiverId,
      "_id": messageId, // optional if your backend expects it
    };
  }
}