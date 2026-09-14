import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app/app.dart';

part 'cart_event.freezed.dart';

abstract class CartEvent extends BaseBlocEvent {
  const CartEvent();
}

@freezed
sealed class CartPageInitiated extends CartEvent with _$CartPageInitiated {
  const CartPageInitiated._();
  const factory CartPageInitiated() = _CartPageInitiated;
}

@freezed
sealed class CartItemQuantityChanged extends CartEvent with _$CartItemQuantityChanged {
  const CartItemQuantityChanged._();
  const factory CartItemQuantityChanged({
    required String cartItemId,
    required int delta,
  }) = _CartItemQuantityChanged;
}

@freezed
sealed class CartItemRemoved extends CartEvent with _$CartItemRemoved {
  const CartItemRemoved._();
  const factory CartItemRemoved({
    required String cartItemId,
  }) = _CartItemRemoved;
}

@freezed
sealed class CartItemSelectionToggled extends CartEvent with _$CartItemSelectionToggled {
  const CartItemSelectionToggled._();
  const factory CartItemSelectionToggled({
    required String cartItemId,
  }) = _CartItemSelectionToggled;
}

@freezed
sealed class CartAllItemsSelectionToggled extends CartEvent with _$CartAllItemsSelectionToggled {
  const CartAllItemsSelectionToggled._();
  const factory CartAllItemsSelectionToggled() = _CartAllItemsSelectionToggled;
}

@freezed
sealed class CartCheckOutPressed extends CartEvent with _$CartCheckOutPressed {
  const CartCheckOutPressed._();
  const factory CartCheckOutPressed() = _CartCheckOutPressed;
}

@freezed
sealed class CartSelectedItemsRemoved extends CartEvent with _$CartSelectedItemsRemoved {
  const CartSelectedItemsRemoved._();
  const factory CartSelectedItemsRemoved() = _CartSelectedItemsRemoved;
}
