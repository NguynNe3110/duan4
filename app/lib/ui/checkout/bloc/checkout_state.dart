import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app/app.dart';
import 'package:domain/domain.dart';

part 'checkout_state.freezed.dart';

@freezed
sealed class CheckoutState extends BaseBlocState with _$CheckoutState {
  const CheckoutState._();

  const factory CheckoutState({
    @Default([]) List<CartItemEntity> selectedItems,
    @Default([]) List<ProductEntity> products,
    @Default(CartSummaryEntity()) CartSummaryEntity summary,
  }) = _CheckoutState;
}
