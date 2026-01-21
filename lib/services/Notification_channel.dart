import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> createChannels(dynamic plugin) async {
  final android = plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  await android?.createNotificationChannel(
    const AndroidNotificationChannel(
      'chat_channel',
      'Chat Messages',
      importance: Importance.high,
    ),
  );

  await android?.createNotificationChannel(
    AndroidNotificationChannel(
      'mention_channel',
      'Mentions',
      importance: Importance.max,
      vibrationPattern: Int64List.fromList(const [0, 500, 200, 500]),
    ),
  );
}
