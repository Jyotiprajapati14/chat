import 'package:chat_app/screen/chat_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/chat/:chatId',
      builder: (_, state) =>
          ChatScreen(chatId: state.pathParameters['chatId']!),
    ),
  ],
);
