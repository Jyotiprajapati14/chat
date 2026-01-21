import 'package:chat_app/deep_link/deep_link_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AndroidNotificationService {
  static final plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const settings = AndroidInitializationSettings('@mipmap/ic_launcher');

    await plugin.initialize(
      const InitializationSettings(android: settings),
      onDidReceiveNotificationResponse: (res) {
        if (res.payload != null) {
          DeepLinkHandler.openChat(res.payload!);
        }
      },
    );

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
  }
}
