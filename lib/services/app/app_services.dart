import 'package:chat_app/services/firebase_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class AppServices {
  static AppServices i = AppServices();
  Future<void> onStart() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);
    _permission();
  }

  void _permission() async {
    await AppFirebase.initialize();
    await Permission.notification.request();
    AppFirebase.fcmToken();
  }

  Future<void> onLogout() async {
    // Navigator.pushNamedAndRemoveUntil(
    //   navigatorKey.currentContext!,
    //   RouteName.login,
    //   (route) => route.isCurrent,
    // );
  }

  void onLogin() {}
}
