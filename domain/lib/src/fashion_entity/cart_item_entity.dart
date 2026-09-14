import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_entity.dart';

part 'cart_item_entity.freezed.dart';

@freezed
class CartItemEntity with _$CartItemEntity {
  const factory CartItemEntity({
    required String id,
    required String userId,
    required String productId,
    required String variantId,
    required int quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CartItemEntity;
}

class CartSummaryEntity {
  const CartSummaryEntity({
    this.total = 0,
    this.discount = 0,
    this.shippingFee = 30000,
    this.subtotal = 0,
  });

  final double subtotal;
  final double? shippingFee;
  final double discount;
  final double total;

  CartSummaryEntity copyWith({
    double? subtotal,
    double? shippingFee,
    double? discount,
    double? total,
  }) {
    return CartSummaryEntity(
      subtotal: subtotal ?? this.subtotal,
      shippingFee: shippingFee ?? this.shippingFee,
      discount: discount ?? this.discount,
      total: total ?? this.total,
    );
  }

  static CartSummaryEntity calculateTotalPrice({
    required List<CartItemEntity> cartItems,
    required List<ProductEntity> products,
    double shippingFee = 30000,
    double discount = 0,
  }) {
    final productMap = {for (final p in products) p.id: p};

    double subtotal = 0;
    for (final item in cartItems) {
      final product = productMap[item.productId];
      if (product != null) {
        subtotal += product.effectivePrice * item.quantity;
      }
    }

    final total = subtotal + shippingFee - discount;
    return CartSummaryEntity(
      subtotal: subtotal,
      shippingFee: shippingFee,
      discount: discount,
      total: total > 0 ? total : 0,
    );
  }
}