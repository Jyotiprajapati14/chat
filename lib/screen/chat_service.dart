import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔥 FIXED: Properly typed stream
  static Stream<QuerySnapshot<Map<String, dynamic>>> messages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots();
  }

  /// Send message
  static Future<void> send(String chatId, String text) async {
    await _firestore.collection('chats').doc(chatId).collection('messages').add(
      {
        'text': text,
        'type': 'text',
        'senderId': 'USER_1', // TODO: replace with auth uid
        'createdAt': FieldValue.serverTimestamp(),
      },
    );
  }
}
