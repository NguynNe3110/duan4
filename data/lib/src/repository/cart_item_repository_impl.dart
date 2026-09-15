import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../data.dart';

@LazySingleton(as: CartItemRepository)
class CartItemRepositoryImpl extends CartItemRepository {
  final CartItemSupabaseService _cartItemSupabaseService;
  final CartItemMapper _cartItemMapper;

  CartItemRepositoryImpl(this._cartItemMapper, this._cartItemSupabaseService);

  @override
  Future<List<CartItemEntity>> getCartItems({required String userId}) async {
    final dtos = await _cartItemSupabaseService.getCartItems(userId: userId);
    return _cartItemMapper.mapToListEntity(dtos);
  }

  @override
  Future<CartItemEntity> getCartItemById({required String id}) async {
    final dto = await _cartItemSupabaseService.getCartItemById(id: id);
    return _cartItemMapper.mapToEntity(dto);
  }

  @override
  Future<CartItemEntity> updateCartItemQuantity({required String id, required int quantity}) async {
    final dto = await _cartItemSupabaseService.updateCartItemQuantity(id: id, quantity: quantity);
    return _cartItemMapper.mapToEntity(dto);
  }

  @override
  Future<void> deleteCartItem({required String id}) async {
    await _cartItemSupabaseService.deleteCartItem(id: id);
  }

  @override
  Future<void> addCartItem({required CartItemEntity cartItem}) async {
    final dto = _cartItemMapper.mapToDto(cartItem);
    await _cartItemSupabaseService.addCartItem(data: dto.toJson());
  }
}
