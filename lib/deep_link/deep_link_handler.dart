import 'package:chat_app/router/app_router.dart';

class DeepLinkHandler {
  static void openChat(String chatId) {
    router.go('/chat/$chatId');
  }
}
