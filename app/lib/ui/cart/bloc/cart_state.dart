import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app/app.dart';
import 'package:domain/domain.dart';
import 'package:shared/shared.dart';

part 'cart_state.freezed.dart';

@freezed
sealed class CartState extends BaseBlocState with _$CartState {
  const CartState._();

  const factory CartState({
    @Default([]) List<CartItemEntity> items,
    @Default([]) List<ProductEntity> products,
    @Default([]) List<String> selectedItemIds,
    @Default(false) bool isShimmerLoading,
    AppException? loadException,
    @Default(CartSummaryEntity()) CartSummaryEntity summary,
  }) = _CartState;

  bool isItemSelected(String id) => selectedItemIds.contains(id);
  
  bool get isAllSelected => items.isNotEmpty && selectedItemIds.length == items.length;

  List<CartItemEntity> get selectedItems => items.where((item) => selectedItemIds.contains(item.id)).toList();
}
