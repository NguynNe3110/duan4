import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'app_route_info.freezed.dart';

/// page the intent
@freezed
class AppRouteInfo with _$AppRouteInfo {
  // factory có thể tự quyết định kiểu trả về của nó, ở đây trả về _Login và nó extend AppRouteInfo
  const factory AppRouteInfo.login() = _Login;

  const factory AppRouteInfo.favorite() = _Favorite;

  const factory AppRouteInfo.cart() = _Cart;

  // screen thì k cần tham số
  const factory AppRouteInfo.main() = _Main;

  // màn hình chi tiết thì phải truyền object
  const factory AppRouteInfo.itemDetail(User user) = _UserDetail;

  const factory AppRouteInfo.checkout({
    required List<CartItemEntity> selectedItems,
    required List<ProductEntity> products,
    required CartSummaryEntity summary,
  }) = _Checkout;
}
