import 'package:chat_app/services/NotificationService.dart';
import 'package:chat_app/deep_link/deep_link_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMAndroid {
  static void init() {
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      DeepLinkHandler.openChat(msg.data['chatId']);
    });
  }

  static void _onMessage(RemoteMessage msg) {
    AndroidNotificationService.plugin.show(
      msg.hashCode,
      msg.notification?.title ?? 'New Message',
      msg.notification?.body ?? '',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'chat_channel',
          'Chat Messages',
          importance: Importance.high,
        ),
      ),
      payload: msg.data['chatId'],
    );
  }
}
