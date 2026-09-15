import 'package:domain/domain.dart';

abstract class CartItemRepository {
  Future<List<CartItemEntity>> getCartItems({required String userId});

  Future<CartItemEntity> getCartItemById({required String id});

  Future<CartItemEntity> updateCartItemQuantity({required String id, required int quantity});

  Future<void> deleteCartItem({required String id});
  Future<void> addCartItem({required CartItemEntity cartItem});
}
