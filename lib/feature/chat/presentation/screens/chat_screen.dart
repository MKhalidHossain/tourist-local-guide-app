import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';
import 'package:kobeur/feature/profile/controllers/profile_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/urls.dart';
import '../../../../utils/app_constants.dart';
import '../../domain/models/chat_message_model.dart';

bool isOnline = false;
String lastSeen = "5 min ago";

class ChatScreen extends StatefulWidget {
  final String? receiverIdForChat;
  final String? userReceiverNameForChat;
  final String? userReceiverImageForChat;
  final String? userSenderImageForChat;

  const ChatScreen({
    super.key,
    this.receiverIdForChat,
    this.userReceiverNameForChat,
    this.userReceiverImageForChat,
    this.userSenderImageForChat,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late HomeController homeController;
  late ProfileController profileController;
  late TextEditingController _messageController;
  late IO.Socket _socket;

  List<ChatMessage> _messages = [];
  bool _isLoading = true;
  bool _isSending = false;
  final ScrollController _scrollController = ScrollController();

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.token);
  }

  void _connectSocket(String currentUserId, String token) {
    _socket = IO.io(
      Urls.socketBaseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setReconnectionAttempts(10)
          .setReconnectionDelay(3000)
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      print('✅ Socket connected');
      _socket.emit('join', {
        'userId': currentUserId,
        'receiverId': widget.receiverIdForChat,
      });
      _setupSocketListeners(currentUserId);
    });

    _socket.onConnectError((err) => print('❌ Socket connect error: $err'));
    _socket.onDisconnect((_) => print('⚠️ Socket disconnected'));
    _socket.onError((err) => print('🔥 Socket error: $err'));
  }

  void _setupSocketListeners(String currentUserId) {
    _socket.on('message-received', (data) {
      if (data is Map<String, dynamic>) {
        final newMessage = ChatMessage.fromJson(data, currentUserId);
        if (newMessage.senderId == widget.receiverIdForChat ||
            newMessage.receiverId == widget.receiverIdForChat) {
          setState(() => _messages.insert(0, newMessage));
          _scrollToBottom();
        }
      }
    });

    _socket.on('user-online', (_) => setState(() => isOnline = true));
    _socket.on('user-offline', (_) {
      setState(() {
        isOnline = false;
        lastSeen = "Just now";
      });
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _loadInitialMessages() async {
    try {
      await homeController.getMessage(widget.receiverIdForChat!);
      final apiMessages =
          homeController.getMessagesPreviousResponseModel.data?.messages ?? [];

      final currentUserId =
          profileController.getProfileResponseModel?.data?.sId;

      setState(() {
        _messages =
            apiMessages.map((message) {
              return ChatMessage(
                text: message.message ?? '',
                isSentByMe: message.senderId == currentUserId,
                time: message.time ?? DateTime.now().toIso8601String(),
                messageId: message.senderId,
                senderId: message.senderId,
                receiverId: message.receiverId,
              );
            }).toList();
        _isLoading = false;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (e) {
      print('Error loading messages: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
    profileController = Get.find<ProfileController>();
    _messageController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadInitialMessages();
      final token = await getToken();
      final currentUserId =
          profileController.getProfileResponseModel?.data?.sId;
      if (token != null && currentUserId != null) {
        _connectSocket(currentUserId, token);
      }
    });
  }

  void sendMessage() {
    if (_messageController.text.isEmpty || _isSending) return;
    final currentUserId = profileController.getProfileResponseModel?.data?.sId;
    if (currentUserId == null) return;

    setState(() => _isSending = true);
    // final tempMessage = ChatMessage(
    //   text: _messageController.text,
    //   isSentByMe: true,
    //   time: DateTime.now().toIso8601String(),
    //   messageId: 'temp-${DateTime.now().millisecondsSinceEpoch}',
    //   senderId: currentUserId,
    //   receiverId: widget.receiverIdForChat,
    // );

    // setState(() => _messages.insert(0, tempMessage));
    _scrollToBottom();

    final payload = {
      "to": widget.receiverIdForChat,
      "message": _messageController.text,
    };
    _socket.emit('new-message', payload);
    homeController.sendMessage(
      widget.receiverIdForChat!,
      _messageController.text,
    );

    _messageController.clear();
    setState(() => _isSending = false);
  }

  @override
  void dispose() {
    if (_socket.connected) {
      _socket.emit('leave', {
        'userId': profileController.getProfileResponseModel?.data?.sId,
      });
      _socket.disconnect();
    }
    _socket.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String formatChatTime(String isoString) {
    try {
      DateTime utcTime = DateTime.parse(isoString).toLocal();
      return DateFormat.jm().format(utcTime);
    } catch (_) {
      return DateFormat.jm().format(DateTime.now());
    }
  }

  Widget _buildMessageBubble(ChatMessage message, bool isNewSender, int index) {
    final size = MediaQuery.of(context).size;
    final isMe = message.isSentByMe;

    return Padding(
      padding: EdgeInsets.only(top: isNewSender ? 20 : 12),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: size.width * 0.04,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child:
                    widget.userReceiverImageForChat != null &&
                            widget.userReceiverImageForChat!.isNotEmpty
                        ? Image.network(
                          widget.userReceiverImageForChat!,
                          width: size.width * 0.08,
                          height: size.width * 0.08,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (_, __, ___) => Image.asset(
                                "assets/images/profileBlankImage.png",
                              ),
                        )
                        : Image.asset("assets/images/profileBlankImage.png"),
              ),
            ),

          if (!isMe) const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFFFF4B5C) : const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatChatTime(message.time),
                    style: TextStyle(
                      fontSize: 10,
                      color: isMe ? Colors.white70 : Colors.black54,
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
                  profileController
                          .getProfileResponseModel
                          ?.data
                          ?.profileImage ??
                      '',
                  width: size.width * 0.08,
                  height: size.width * 0.08,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) =>
                          Image.asset("assets/images/profileBlankImage.png"),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          const SizedBox(width: 16),
          // IconButton(
          //   icon: Icon(
          //     Icons.attach_file_outlined,
          //     color: AppColors.secondaryColor,
          //   ),
          //   onPressed: () {},
          // ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color:
                        Colors.grey.shade400, // border color when not focused
                    width: 1.2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Color(
                      0xffFF3951,
                    ).withOpacity(0.5), // border color when focused
                    width: 1.5,
                  ),
                ),
              ),
              onSubmitted: (_) => sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          // IconButton(
          //   icon: Icon(
          //     Icons.emoji_emotions_outlined,
          //     color: AppColors.secondaryColor,
          //   ),
          //   onPressed: () {},
          // ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: _isSending ? Colors.grey : const Color(0xFFFF4B5C),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon:
                  _isSending
                      ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                      : const Icon(Icons.send, color: Colors.white, size: 18),
              onPressed: _isSending ? null : sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  BackButton(color: Colors.black),
                  CircleAvatar(
                    radius: size.width * 0.06,
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        widget.userReceiverImageForChat != null
                            ? NetworkImage(widget.userReceiverImageForChat!)
                            : null,
                    child:
                        widget.userReceiverImageForChat == null
                            ? Image.asset("assets/images/profileBlankImage.png")
                            : null,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userReceiverNameForChat ?? 'User Name',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          if (isOnline)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          Text(
                            isOnline ? "Online" : "Last seen $lastSeen",
                            style: const TextStyle(
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
            ),

            // Messages List
            Expanded(
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _messages.isEmpty
                      ? const Center(
                        child: Text(
                          "No messages yet\nStart the conversation!",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          bool isNewSender = index == _messages.length - 1;
                          if (index < _messages.length - 1) {
                            final nextMessage = _messages[index + 1];
                            isNewSender =
                                message.isSentByMe != nextMessage.isSentByMe;
                          }
                          return _buildMessageBubble(
                            message,
                            isNewSender,
                            index,
                          );
                        },
                      ),
            ),

            // Input Field
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }
}
