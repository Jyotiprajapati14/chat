import 'package:chat_app/app/app_data.dart';
import 'package:chat_app/features/chat/provider/chat_provider.dart';
import 'package:chat_app/features/chat/view/chat_view.dart';
import 'package:chat_app/features/dash/provider/dash_provider.dart';
import 'package:chat_app/features/dash/view/dash_view.dart';
import 'package:chat_app/features/login/model/user_mdl.dart';
import 'package:chat_app/features/login/provider/login_provider.dart';
import 'package:chat_app/features/login/view/login_view.dart';
import 'package:chat_app/route/route_name.dart';
import 'package:chat_app/utils/msg.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Routes {
  static PageRouteBuilder rightToLeftSlide({
    required RouteSettings settings,
    required Widget builder,
  }) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => builder,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    logInfo('Route', msg: '${settings.name}');
    switch (settings.name) {
      case RouteName.login:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              ChangeNotifierProvider(
                lazy: false,
                create: (context) => LoginProvider(),
                child: const LoginView(),
              ),
        );

      case RouteName.dash:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              ChangeNotifierProvider(
                lazy: false,
                create: (context) => DashProvider(),
                child: const DashView(),
              ),
        );

      case RouteName.chat:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              ChangeNotifierProvider(
                lazy: false,
                create: (context) => ChatProvider(
                  fromUser: AppData.inst.userMdl,
                  toUser: settings.arguments as UserMdl,
                ),
                child: const ChatView(),
              ),
        );
    }
    return null;
  }
}
