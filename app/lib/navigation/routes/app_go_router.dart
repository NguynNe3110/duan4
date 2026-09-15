import 'package:domain/domain.dart';
import 'package:go_router/go_router.dart';

import '../../ui/home/home_page.dart';
import '../../ui/item_detail/item_detail_page.dart';
import '../../ui/login/login_page.dart';
import '../../ui/main/main_page.dart';
import '../../ui/my_page/my_page_page.dart';
import '../../ui/search/search_page.dart';
import '../base/base_go_router.dart';

abstract final class AppRoutePath {
  static const login = '/login';
  static const main = '/main';
  static const home = '/main/home';
  static const search = '/main/search';
  static const myPage = '/main/my-page';
  static const itemDetail = '/main/home/item-detail';
}

class AppGoRouter extends BaseGoRouter {
  AppGoRouter()
    : super(
        initialLocation: AppRoutePath.login,
        routes: [
          GoRoute(
            path: AppRoutePath.login,
            builder: (_, __) => const LoginPage(),
          ),
          GoRoute(
            path: AppRoutePath.main,
            builder: (_, __) => const MainPage(),
            routes: [
              GoRoute(
                path: 'home',
                builder: (_, __) => const HomePage(),
                routes: [
                  GoRoute(
                    path: 'item-detail',
                    builder: (_, state) =>
                        ItemDetailPage(product: state.extra! as ProductEntity),
                  ),
                ],
              ),
              GoRoute(path: 'search', builder: (_, __) => const SearchPage()),
              GoRoute(path: 'my-page', builder: (_, __) => const MyPagePage()),
            ],
          ),
        ],
      );
}
