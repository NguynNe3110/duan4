import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../app.dart';

// ignore_for_file:prefer-single-widget-per-file
@AutoRouterConfig(
  replaceInRouteName: 'Page,Route', // tự động thay thế nameclass
)
@LazySingleton()
class AppRouter extends RootStackRouter { // có thể hiểu là khai báo router
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),

        AutoRoute(page: MainRoute.page, children: [ // nếu lồng thì lồng bằng children
          AutoRoute(
            page: HomeTab.page,
            maintainState: true,
            children: [
              AutoRoute(page: HomeRoute.page, initial: true),
              AutoRoute(
                page: ItemDetailRoute.page,
                guards: [RouteGuard(GetIt.instance.get<IsLoggedInUseCase>())],
              ),
            ],
          ),
          AutoRoute(
            page: FavoriteTab.page,
            maintainState: true,
            children: [
              AutoRoute(page: FavoriteRoute.page, initial: true),
            ],
          ),
          AutoRoute(
            page: CartTab.page,
            maintainState: true,
            children: [
              AutoRoute(page: CartRoute.page, initial: true),
            ],
          ),
          AutoRoute(
            page: MyPageTab.page,
            maintainState: true,
            children: [
              AutoRoute(page: MyPageRoute.page, initial: true),
            ],
          ),
        ]),
      ];
}

@RoutePage(name: 'HomeTab')
class HomeTabPage extends AutoRouter {
  const HomeTabPage({super.key});
}

@RoutePage(name: 'FavoriteTab')
class FavoriteTabPage extends AutoRouter {
  const FavoriteTabPage({super.key});
}

@RoutePage(name: 'CartTab')
class CartTabPage extends AutoRouter {
  const CartTabPage({super.key});
}

@RoutePage(name: 'MyPageTab')
class MyPageTabPage extends AutoRouter {
  const MyPageTabPage({super.key});
}
