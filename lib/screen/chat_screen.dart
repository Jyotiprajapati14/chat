import 'package:chat_app/common/model/message_model.dart';
import 'package:chat_app/screen/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;
  ChatScreen({super.key, required this.chatId});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: ChatService.messages(chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No messages"));
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, i) {
                    final msg = MessageModel.fromDoc(docs[i]);
                    return ListTile(
                      title: Text(msg.text),
                      subtitle: Text(msg.senderId),
                    );
                  },
                );
              },
            ),
          ),

          // Input area
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Type message...",
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (controller.text.trim().isEmpty) return;

                  ChatService.send(chatId, controller.text.trim());
                  controller.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
