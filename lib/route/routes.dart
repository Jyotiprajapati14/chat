import 'package:adept_log/view/adept_log.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productapp/features/login/cubit/login_cubit.dart';
import 'package:productapp/features/login/view/login_view.dart';
import 'package:productapp/features/product_details.dart/cubit/product_details_cubit.dart';
import 'package:productapp/features/product_details.dart/view/product_details_view.dart';
import 'package:productapp/features/product_list/cubit/product_list_cubit.dart';
import 'package:productapp/features/product_list/model/product_mdl.dart';
import 'package:productapp/features/product_list/view/product_list_view.dart';
import 'package:productapp/features/splash/repo/splash_repo.dart';
import 'package:productapp/features/splash/view/splash_view.dart';
import 'package:productapp/route/route_name.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    AdeptLog.i(
      'Route: ${settings.name}'
      '${settings.arguments != null ? ' | Args: ${settings.arguments}' : ''}',
      tag: 'Route',
    );
    switch (settings.name) {
      case RouteName.splash:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              RepositoryProvider(
                create: (context) => SplashRepo(context),
                child: SplashView(),
              ),
        );
      case RouteName.login:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              RepositoryProvider(
                create: (context) => LoginCubit(context),
                child: LoginView(),
              ),
        );
      case RouteName.productList:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              RepositoryProvider(
                create: (context) => ProductListCubit(context),
                child: ProductListView(),
              ),
        );
      case RouteName.productDetail:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
            create: (context) => ProductDetailsCubit(
              context: context,
              productMdl: settings.arguments as ProductMdl,
            ),
            child: ProductDetailsView(),
          ),
        );
    }
    return null;
  }
}
