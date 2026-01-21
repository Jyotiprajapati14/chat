import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String text;
  final String type;
  final String senderId;

  MessageModel({
    required this.text,
    required this.type,
    required this.senderId,
  });

  factory MessageModel.fromDoc(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();

    return MessageModel(
      text: data['text'] ?? '',
      type: data['type'] ?? 'text',
      senderId: data['senderId'] ?? '',
    );
  }
}
