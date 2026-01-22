import 'package:chat_app/app/app_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMdl {
  String msg;
  String phone;
  bool isMe;
  String createdAt;
  ChatMdl({
    required this.msg,
    required this.phone,
    this.isMe = true,
    String? createdAt,
  }) : createdAt =
           createdAt ?? Timestamp.now().toDate().toUtc().toIso8601String();

  factory ChatMdl.fromJson(Map<String, dynamic> json) {
    return ChatMdl(
      msg: json['message'] ?? '',
      phone: json['phone'] ?? '',
      isMe: json['phone'] == AppData.inst.userMdl.phone,
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': msg, 'phone': phone, 'createdAt': createdAt};
  }
}
