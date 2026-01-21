import 'package:chat_app/services/NotificationService.dart';
import 'package:chat_app/services/app/app_services.dart';
import 'package:chat_app/services/fcm_service.dart';
import 'package:chat_app/services/firebase/firebase_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'deep_link/deep_link_handler.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppServices.i.onStart();
  // FCMAndroid.init();
  // final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // if (initialMessage != null) {
    //   Future.microtask(() {
    //     DeepLinkHandler.openChat(initialMessage!.data['chatId']);
    //   });
    // }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
