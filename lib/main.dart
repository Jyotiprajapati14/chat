import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/route/route_name.dart';
import 'package:chat_app/route/routes.dart';
import 'package:chat_app/app_services/app/app_services.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppServices.i.onStart();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.green1,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          toolbarHeight: 65,
          backgroundColor: AppColor.blue1,
          centerTitle: false,
          iconTheme: IconThemeData(color: AppColor.white, size: 24),
          titleTextStyle: TextStyle(
            color: AppColor.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          titleSpacing: 10,
        ),
      ),
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: RouteName.login,
    );
  }
}
