import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'get_cart_items_use_case.freezed.dart';

@Injectable()
class GetCartItemsUseCase extends BaseFutureUseCase<GetCartItemsUseCaseInput, GetCartItemsUseCaseOutput> {
  final CartItemRepository _cartItemRepository;
  final ProductRepository _productRepository;

  GetCartItemsUseCase(this._cartItemRepository, this._productRepository);

  @protected
  @override
  Future<GetCartItemsUseCaseOutput> buildUseCase(GetCartItemsUseCaseInput input) async {
    final cartItems = await _cartItemRepository.getCartItems(userId: input.userId);

    // lấy product theo từng productId trong cart
    final productIds = cartItems.map((e) => e.productId).toSet(); // k biet  có nen viet ơ bloc k
    final products = await Future.wait(
      productIds.map((id) => _productRepository.getProductById(id: id)),
    );

    final summary = CartSummaryEntity.calculateTotalPrice(
      cartItems: cartItems,
      // products: products.whereType<ProductEntity>().toList(), // có thể viet nhu nay de handle nullable
      products: products,
    );

    return GetCartItemsUseCaseOutput(cartItems: cartItems, products: products, summary: summary);
  }
}

@freezed
sealed class GetCartItemsUseCaseInput extends BaseInput with _$GetCartItemsUseCaseInput {
  const GetCartItemsUseCaseInput._();
  const factory GetCartItemsUseCaseInput({
    required String userId,
  }) = _GetCartItemsUseCaseInput;
}

@freezed
sealed class GetCartItemsUseCaseOutput extends BaseOutput with _$GetCartItemsUseCaseOutput {
  const GetCartItemsUseCaseOutput._();
  const factory GetCartItemsUseCaseOutput({
    required List<CartItemEntity> cartItems,
    required List<ProductEntity> products,
    required CartSummaryEntity summary,
  }) = _GetCartItemsUseCaseOutput;
}
