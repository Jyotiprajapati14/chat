import 'dart:async';
import 'package:chat_app/api/api_service.dart';
import 'package:chat_app/app_services/firebase/firestore_services.dart';
import 'package:chat_app/features/chat/model/chat_mdl.dart';
import 'package:chat_app/features/login/model/user_mdl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final UserMdl fromUser;
  final UserMdl toUser;
  ChatProvider({required this.fromUser, required this.toUser});

  List<ChatMdl> messages = [];
  StreamSubscription<QuerySnapshot>? _chatSubscription;
  final TextEditingController msgCtrl = TextEditingController();
  final ScrollController scrollCtrl = ScrollController();

  void listenMessages() {
    final chatId = _chatId(fromUser.phone, toUser.phone);
    _chatSubscription = FirestoreService.inst.db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .listen((snapshot) {
          messages = snapshot.docs
              .map((e) => ChatMdl.fromJson(e.data()))
              .toList();
          notifyListeners();
        });
  }

  Future<void> sendMessage() async {
    String msg = msgCtrl.text.trim();
    if (msg.trim().isEmpty) return;
    final chatId = _chatId(fromUser.phone, toUser.phone);
    final chat = ChatMdl(msg: msg, phone: fromUser.phone);
    await FirestoreService.inst.db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(chat.toJson());
    ApiService.inst.sendPushNotification(
      fcm: toUser.fcm,
      title: '${fromUser.name}\n${fromUser.phone}',
      body: msg,
    );
    msgCtrl.clear();
  }

  String _chatId(String phone1, String phone2) {
    return phone1.compareTo(phone2) < 0
        ? '${phone1}_$phone2'
        : '${phone2}_$phone1';
  }

  @override
  void dispose() {
    _chatSubscription?.cancel();
    msgCtrl.dispose();
    scrollCtrl.dispose();
    super.dispose();
  }
}
