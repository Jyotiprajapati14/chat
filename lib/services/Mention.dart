import 'package:chat_app/services/NotificationService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> mention(RemoteMessage message) async {
  await AndroidNotificationService.plugin.show(
    message.hashCode,
    'You were mentioned',
    message.notification?.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        'mention_channel',
        'Mentions',
        importance: Importance.max,
        color: Colors.red,
      ),
    ),
    payload: message.data['chatId'],
  );
}
