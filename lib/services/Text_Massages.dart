import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'NotificationService.dart';

Future<void> text(RemoteMessage message) async {
  await AndroidNotificationService.plugin.show(
    message.hashCode,
    message.notification?.title ?? 'New Message',
    message.notification?.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        'chat_channel',
        'Chat Messages',
        groupKey: message.data['senderId'],
        importance: Importance.high,
      ),
    ),
    payload: message.data['chatId'],
  );
}
