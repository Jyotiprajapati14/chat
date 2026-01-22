import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/common/widget/user_hearder_widget.dart';
import 'package:chat_app/features/chat/model/chat_mdl.dart';
import 'package:chat_app/features/chat/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final ChatProvider provider = context.read<ChatProvider>();

  @override
  void initState() {
    super.initState();
    provider.listenMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeef1ff),
      appBar: AppBar(
        toolbarHeight: 68,
        backgroundColor: AppColor.blue1,
        titleSpacing: 0,
        leadingWidth: 48,
        iconTheme: const IconThemeData(color: Colors.white),
        title: UserHeaderWidget(user: provider.toUser),
      ),
      body: Column(
        children: [
          Expanded(child: messages()),
          textField(),
        ],
      ),
    );
  }

  Widget messages() {
    return Selector<ChatProvider, List<ChatMdl>>(
      selector: (c, p) => p.messages,
      builder: (context, messages, _) {
        return ListView.builder(
          controller: provider.scrollCtrl,
          padding: const EdgeInsets.all(12),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final msg = messages[index];
            final isMe = msg.isMe;
            final time = _formatTime(msg.createdAt);
            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isMe ? AppColor.blue1 : AppColor.grey2,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: Radius.circular(isMe ? 12 : 0),
                    bottomRight: Radius.circular(isMe ? 0 : 12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: isMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      msg.msg,
                      style: TextStyle(
                        color: isMe ? AppColor.white : AppColor.black1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 10,
                        color: (isMe ? AppColor.white : AppColor.black1)
                            .withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatTime(String timeStr) {
    try {
      final dateTime = DateTime.parse(timeStr).toLocal();
      return DateFormat('hh:mm a').format(dateTime); // e.g., 03:45 PM
    } catch (e) {
      return '';
    }
  }

  Widget textField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: provider.msgCtrl,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColor.blue1,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: provider.sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
