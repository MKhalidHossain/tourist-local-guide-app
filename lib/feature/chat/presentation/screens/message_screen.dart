import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import 'chat_screen.dart'; // Update to match your structure

class MessageModel {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final int unreadCount;
  final bool isRead;
  final bool isMedia;
  final bool isDocument;
  final bool isSentByMe;

  MessageModel({
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.unreadCount = 0,
    this.isRead = false,
    this.isMedia = false,
    this.isDocument = false,
    this.isSentByMe = false,
  });
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MessageModel> messages = [
      MessageModel(
        name: "Bessie Cooper",
        message: "Hello! Guys",
        time: "5:27 am",
        unreadCount: 2,
        avatar: 'assets/images/user1.png',
        isSentByMe: false,
      ),
      MessageModel(
        name: "Cody Fisher",
        message: "Hello! Guys",
        time: "Yesterday",
        avatar: 'assets/images/user2.png',
        isSentByMe: true,
        isRead: true,
      ),
      MessageModel(
        name: "Kathryn Murphy",
        message: "Photo",
        time: "20/03/2025",
        avatar: 'assets/images/user3.png',
        isMedia: true,
        isRead: true,
        isSentByMe: true,
      ),
      MessageModel(
        name: "Arlene McCoy",
        message: "Document.pdf (1 page)",
        time: "5:27 am",
        avatar: 'assets/images/user4.png',
        isDocument: true,
        isSentByMe: true,
      ),
      MessageModel(
        name: "Theresa Webb",
        message: "Hello! Guys",
        time: "5:27 am",
        unreadCount: 3,
        avatar: 'assets/images/user5.png',
        isSentByMe: false,
      ),
      MessageModel(
        name: "Ralph Edwards",
        message: "👍🏻👍🏻",
        time: "5:27 am",
        avatar: 'assets/images/user1.png',
        isSentByMe: true,
        isRead: true,
      ),
      MessageModel(
        name: "Cody Fisher",
        message: "Hello! Guys",
        time: "Yesterday",
        avatar: 'assets/images/user2.png',
        isSentByMe: true,
        isRead: true,
      ),
      MessageModel(
        name: "Kathryn Murphy",
        message: "Photo",
        time: "20/03/2025",
        avatar: 'assets/images/user3.png',
        isMedia: true,
        isRead: true,
        isSentByMe: true,
      ),
      MessageModel(
        name: "Arlene McCoy",
        message: "Document.pdf (1 page)",
        time: "5:27 am",
        avatar: 'assets/images/user4.png',
        isDocument: true,
        isSentByMe: true,
      ),
      MessageModel(
        name: "Theresa Webb",
        message: "Hello! Guys",
        time: "5:27 am",
        avatar: 'assets/images/user5.png',
        isSentByMe: false,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Messages',
          style: TextStyle(
            color: AppColors.primaryTextBlack,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];

          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(message.avatar),
            ),
            title: Text(
              message.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            subtitle: Row(
              children: [
                if (message.isSentByMe &&
                    !message.isMedia &&
                    !message.isDocument)
                  Icon(
                    message.isRead ? Icons.done_all : Icons.check,
                    size: 16,
                    color: message.isRead ? Colors.blue : Colors.grey,
                  ),
                if (message.isSentByMe &&
                    !message.isMedia &&
                    !message.isDocument)
                  const SizedBox(width: 4),
                if (message.isMedia)
                  const Icon(Icons.photo, size: 14, color: Colors.black45),
                if (message.isDocument)
                  const Icon(
                    Icons.insert_drive_file,
                    size: 14,
                    color: Colors.black45,
                  ),
                if (message.isMedia || message.isDocument)
                  const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    message.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.secondayText,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message.time,
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                if (message.unreadCount > 0)
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message.unreadCount.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
            onTap: () {
              Get.to(() => ChatScreen());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => ChatScreen(),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
