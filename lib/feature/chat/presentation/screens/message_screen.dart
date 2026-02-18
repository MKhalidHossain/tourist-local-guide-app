import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';
import '../../../../core/constants/app_colors.dart';
import 'chat_screen.dart';

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

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
    homeController.getUserAssociatedWithChat();
  }

  @override
  Widget build(BuildContext context) {
    String formatChatTime(String isoString) {
      try {
        DateTime utcTime = DateTime.parse(isoString).toLocal();
        return DateFormat.jm().format(utcTime);
      } catch (e) {
        return '';
      }
    }

    return GetBuilder<HomeController>(
      builder: (homeController) {
        final messagesAll =
            homeController.getUserAssociatedWithChatResponseModel.data;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            title: "Messages".text24Black(),
          ),
          body:
              homeController.isLoading
                  ? _buildShimmerEffect()
                  : (messagesAll == null || messagesAll.isEmpty)
                  ? _buildEmptyState()
                  : ListView.builder(
                    itemCount: messagesAll.length,
                    itemBuilder: (context, index) {
                      final message = messagesAll[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey.shade200,
                          child: ClipOval(
                            child: Image.network(
                              message.avatar ?? "",
                              fit: BoxFit.cover,
                              width: 48,
                              height: 48,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/profileBlankImage.png",
                                  fit: BoxFit.cover,
                                  width: 48,
                                  height: 48,
                                );
                              },
                            ),
                          ),
                        ),
                        title: Text(
                          message.name ?? 'User',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            if ((message.isSentByMe) &&
                                (message.isMedia) &&
                                (message.isDocument))
                              Icon(
                                (message.isRead) ? Icons.done_all : Icons.check,
                                size: 16,
                                color:
                                    (message.isRead)
                                        ? const Color(0XFFFF3951)
                                        : Colors.grey,
                              ),
                            if ((message.isMedia) || (message.isDocument))
                              const SizedBox(width: 4),
                            if (message.isMedia)
                              const Icon(
                                Icons.photo,
                                size: 14,
                                color: Colors.black45,
                              ),
                            if (message.isDocument)
                              const Icon(
                                Icons.insert_drive_file,
                                size: 14,
                                color: Colors.black45,
                              ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                message.message ?? '',
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
                              message.time != null
                                  ? formatChatTime(message.time)
                                  : '0.00',
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    (message.isRead)
                                        ? Colors.grey
                                        : Colors.black54,
                              ),
                            ),
                            if ((message.unreadCount) > 0)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  message.unreadCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        onTap: () {
                          Get.to(
                            () => ChatScreen(
                              receiverIdForChat: message.receiverId,
                              userReceiverNameForChat: message.name ?? '',
                              userReceiverImageForChat: message.avatar ?? '',
                            ),
                          );
                        },
                      );
                    },
                  ),
        );
      },
    );
  }

  /// 🟣 Empty State UI
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 60,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            "No messages yet",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Please send your first message to start chatting!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  /// ✨ Shimmer Loading Effect
  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(radius: 24, backgroundColor: Colors.white),
            title: Container(height: 14, width: 100, color: Colors.white),
            subtitle: Container(
              margin: const EdgeInsets.only(top: 6),
              height: 12,
              color: Colors.white,
            ),
            trailing: Container(height: 10, width: 30, color: Colors.white),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:kobeur/core/extensions/text_extensions.dart';
// import 'package:kobeur/feature/home/controllers/home_controller.dart';

// import '../../../../core/constants/app_colors.dart';
// import 'chat_screen.dart';

// class MessageModel {
//   final String name;
//   final String message;
//   final String time;
//   final String avatar;
//   final int unreadCount;
//   final bool isRead;
//   final bool isMedia;
//   final bool isDocument;
//   final bool isSentByMe;

//   MessageModel({
//     required this.name,
//     required this.message,
//     required this.time,
//     required this.avatar,
//     this.unreadCount = 0,
//     this.isRead = false,
//     this.isMedia = false,
//     this.isDocument = false,
//     this.isSentByMe = false,
//   });
// }

// class MessagesScreen extends StatefulWidget {
//   const MessagesScreen({super.key});

//   @override
//   State<MessagesScreen> createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen> {
//   late HomeController homeController;

//   @override
//   void initState() {
//     super.initState();
//     homeController = Get.find<HomeController>();
//     homeController.getUserAssociatedWithChat();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String formatChatTime(String isoString) {
//       try {
//         DateTime utcTime =
//             DateTime.parse(isoString).toLocal(); // convert to local
//         return DateFormat.jm().format(utcTime); // e.g., "5:27 AM"
//       } catch (e) {
//         return '';
//       }
//     }

//     return GetBuilder<HomeController>(
//       builder: (homeController) {
//         print(
//           "This is from message screen :${homeController.getUserAssociatedWithChatResponseModel.data?.first.name ?? 'No name'}",
//         );
//         // final receiverData =
//         //     homeController.getUserAssociatedWithChatResponseModel.data;
//         final messagesAll =
//             homeController.getUserAssociatedWithChatResponseModel.data;

//         return homeController.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : Scaffold(
//               backgroundColor: AppColors.background,
//               appBar: AppBar(
//                 backgroundColor: AppColors.background,
//                 elevation: 0,
//                 // leading: SizedBox(height: 40),
//                 // centerTitle: false,
//                 title: "Messages".text24Black(),
//               ),
//               body: ListView.builder(
//                 itemCount: messagesAll?.length,
//                 itemBuilder: (context, index) {
//                   final message = messagesAll?[index];

//                   return ListTile(
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 4,
//                     ),
//                     leading: CircleAvatar(
//                       radius: 24,
//                       backgroundColor: Colors.grey.shade200,
//                       child: ClipOval(
//                         child: Image.network(
//                           message?.avatar ?? "", // your avatar URL
//                           fit: BoxFit.cover,
//                           width: 48,
//                           height: 48,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Image.asset(
//                               "assets/images/profileBlankImage.png", // placeholder asset
//                               fit: BoxFit.cover,
//                               width: 48,
//                               height: 48,
//                             );
//                           },
//                         ),
//                       ),
//                     ),

//                     title: Text(
//                       message?.name ?? 'User',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     subtitle: Row(
//                       children: [
//                         if ((message?.isSentByMe ?? false) &&
//                             (message?.isMedia ?? false) &&
//                             (message?.isDocument ?? false))
//                           Icon(
//                             (message?.isRead ?? false)
//                                 ? Icons.done_all
//                                 : Icons.check,
//                             size: 16,
//                             color:
//                                 (message?.isRead ?? false)
//                                     ? Color(0XFFFF3951)
//                                     : Colors.grey,
//                           ),
//                         if ((message?.isSentByMe ?? false) &&
//                             (message?.isMedia ?? false) &&
//                             (message?.isDocument ?? false))
//                           const SizedBox(width: 4),
//                         if ((message?.isMedia) ?? false)
//                           const Icon(
//                             Icons.photo,
//                             size: 14,
//                             color: Colors.black45,
//                           ),
//                         if ((message?.isDocument) ?? false)
//                           const Icon(
//                             Icons.insert_drive_file,
//                             size: 14,
//                             color: Colors.black45,
//                           ),
//                         if ((message?.isMedia ?? false) ||
//                             (message?.isDocument ?? false))
//                           const SizedBox(width: 4),
//                         Expanded(
//                           child: Text(
//                             message?.message ?? '',
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               color: AppColors.secondayText,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     trailing: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           message?.time != null
//                               ? formatChatTime((message?.time) ?? '0.00')
//                               : '0.00',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color:
//                                 ((message?.isRead) ?? false)
//                                     ? Colors.grey
//                                     : Colors.black54,
//                           ),
//                         ),
//                         if ((message?.unreadCount ?? 0) > 0)
//                           Container(
//                             margin: EdgeInsets.only(top: 4),
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 6,
//                               vertical: 2,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Text(
//                               message!.unreadCount.toString(),
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                     onTap: () {
//                       Get.to(
//                         () => ChatScreen(
//                           receiverIdForChat: message?.receiverId,
//                           userReceiverNameForChat: message?.name ?? '',
//                           userReceiverImageForChat: message?.avatar ?? '',
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             );
//       },
//     );
//   }
// }
