import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/feature/profile/controllers/profile_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_colors.dart';

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String time;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.time,
  });
}

bool isOnline = false;
String lastSeen = "5 min ago";

class ChatScreen extends StatefulWidget {
  final String? userIdForChat;
  final String? userReceiverNameForChat;
  final String? userReceiverImageForChat;

  ChatScreen({
    super.key,
    this.userIdForChat,
    this.userReceiverNameForChat,
    this.userReceiverImageForChat,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ProfileController profileController;

  @override
  void initState() {
    super.initState();
    profileController = Get.find<ProfileController>();
    profileController.getUserProfile();
  }

  final List<ChatMessage> messages = [
    ChatMessage(
      text: "Hi there! How can I help you?",
      isSentByMe: false,
      time: "10:32 AM",
    ),
    ChatMessage(
      text: "Hi! I’m interested in your City Tour.",
      isSentByMe: true,
      time: "10:32 AM",
    ),
    ChatMessage(
      text: "Great! When are you planning to visit China?",
      isSentByMe: false,
      time: "10:32 AM",
    ),
    ChatMessage(
      text: "Great! When are you planning to visit China?",
      isSentByMe: true,
      time: "10:32 AM",
    ),
    ChatMessage(
      text:
          "Perfect! I have availability on Tuesday and Wednesday. Would either of those days work for you?",
      isSentByMe: false,
      time: "10:32 AM",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("userIdForChat: ${widget.userIdForChat}");

    return GetBuilder<ProfileController>(
      builder: (profileController) {
        print(
          " from chat Screen finding user id : ${profileController.getProfileResponseModel?.data?.sId}",
        );

        final senderProfile = profileController.getProfileResponseModel?.data;
        return profileController.isLoading
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
              backgroundColor: Colors.white,

              body: SafeArea(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BackButton(color: Colors.black),
                        CircleAvatar(
                          radius: size.width * 0.06,
                          backgroundColor: Colors.grey[200],
                          child: ClipOval(
                            child: Image.network(
                              widget.userReceiverImageForChat ?? '',
                              width: size.width * 0.12,
                              height: size.width * 0.12,
                              fit: BoxFit.cover,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;

                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(color: Colors.white),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/profileBlankImage.png",

                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        // CircleAvatar(
                        //   radius: 16,
                        //   backgroundImage: AssetImage('assets/images/user1.png'),
                        // ),
                        const SizedBox(width: 8),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.userReceiverNameForChat ?? 'User Name',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000),
                              ),
                            ),
                            const SizedBox(height: 4),

                            Row(
                              children: [
                                if (isOnline)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    margin: EdgeInsets.only(right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                Text(
                                  isOnline ? "Online" : "Last seen $lastSeen",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isMe = message.isSentByMe;

                          // Check if the previous message is from a different sender
                          bool isNewSender = true;
                          if (index > 0) {
                            final prev = messages[index - 1];
                            isNewSender = prev.isSentByMe != message.isSentByMe;
                          }

                          return Padding(
                            padding: EdgeInsets.only(
                              top: isNewSender ? 20 : 12,
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  isMe
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (!isMe)
                                  CircleAvatar(
                                    radius: size.width * 0.04,
                                    backgroundColor: Colors.grey[200],
                                    child: ClipOval(
                                      child: Image.network(
                                        widget.userReceiverImageForChat ?? '',
                                        width: size.width * 0.08,
                                        height: size.width * 0.08,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null)
                                            return child;

                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Image.asset(
                                            "assets/images/profileBlankImage.png",

                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),

                                // CircleAvatar(
                                //   radius: 14,
                                //   backgroundImage: AssetImage(
                                //     'assets/images/user1.png',
                                //   ),
                                // ),
                                if (!isMe) const SizedBox(width: 8),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isMe
                                              ? Color(0xFFFF4B5C)
                                              : Color(0xFFF2F2F2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          isMe
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          message.text,
                                          style: TextStyle(
                                            color:
                                                isMe
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 4),

                                        Text(
                                          message.time,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                isMe
                                                    ? AppColors.context(
                                                      context,
                                                    ).backgroundColor
                                                    : AppColors
                                                        .primaryTextBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (isMe)
                                  CircleAvatar(
                                    radius: size.width * 0.04,
                                    backgroundColor: Colors.grey[200],
                                    child: ClipOval(
                                      child: Image.network(
                                        senderProfile?.profileImage ?? '',
                                        width: size.width * 0.08,
                                        height: size.width * 0.08,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null)
                                            return child;

                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Image.asset(
                                            "assets/images/profileBlankImage.png",

                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                // CircleAvatar(
                                //   radius: 14,
                                //   backgroundImage: AssetImage(
                                //     'assets/images/user2.png',
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(height: 53),
                    _buildMessageInput(),
                  ],
                ),
              ),
            );
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.attach_file_outlined,
              color: AppColors.secondaryColor,
              size: 22,
            ),
            onPressed: () {
              // Handle file attachment
            },
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondayText,
                ),
              ),
              style: TextStyle(fontSize: 14),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.emoji_emotions_outlined,
              color: AppColors.secondaryColor,
              size: 22,
            ),
            onPressed: () {
              // Handle emoji picker
            },
          ),
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFFF4B5C),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.send, size: 18, color: Colors.white),
              onPressed: () {
                // Handle send
              },
            ),
          ),
        ],
      ),
    );
  }
}
