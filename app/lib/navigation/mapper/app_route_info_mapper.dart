import 'package:app/navigation/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../app.dart';

@LazySingleton(as: BaseRouteInfoMapper)
class AppRouteInfoMapper extends BaseRouteInfoMapper {
  @override
  PageRouteInfo map(AppRouteInfo appRouteInfo) {
    return appRouteInfo.when(
      login: () => const LoginRoute(),      // Map định danh 'login' sang trang Login
      main: () => const MainRoute(),
      favorite: () => const FavoriteRoute(),
      cart: () => const CartRoute(),
      itemDetail: (product) => ItemDetailRoute(product: product),
      checkout: (selectedItems, products, summary) => CheckoutRoute(
        selectedItems: selectedItems,
        products: products,
        summary: summary,
      ),
      orderHistory: () => const OrderHistoryRoute(),
      search: () => const SearchRoute(),
      notification: () => const NotificationRoute(),
    );
  }
}
