import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

part 'checkout_selected_items_use_case.freezed.dart';

@Injectable()
class CheckoutSelectedItemsUseCase extends BaseFutureUseCase<CheckoutSelectedItemsUseCaseInput, CheckoutSelectedItemsUseCaseOutput> {
  final CartItemRepository _cartItemRepository;
  final OrderRepository _orderRepository;

  CheckoutSelectedItemsUseCase(
    this._cartItemRepository,
    this._orderRepository,
  );

  @protected
  @override
  Future<CheckoutSelectedItemsUseCaseOutput> buildUseCase(CheckoutSelectedItemsUseCaseInput input) async {
    final allCartItems = await _cartItemRepository.getCartItems(userId: input.userId);

    final selectedItems = allCartItems.where((item) => input.selectedCartItemIds.contains(item.id)).toList();

    if (selectedItems.isEmpty) {
      throw const ValidationException(ValidationExceptionKind.noItemSelected);
    }

    final orderRequest = CreateOrderRequestEntity(
      userId: input.userId,
      totalPrice: input.totalPrice,
      addressLine: input.addressLine,
      paymentMethod: input.paymentMethod,
      status: input.status,
      note: input.note,
    );

    await _orderRepository.createOrder(
      orderData: orderRequest,
      orderItems: input.orderItems,
    );

    for (final item in selectedItems) {
      await _cartItemRepository.deleteCartItem(id: item.id);
    }

    return const CheckoutSelectedItemsUseCaseOutput();
  }
}

@freezed
sealed class CheckoutSelectedItemsUseCaseInput extends BaseInput with _$CheckoutSelectedItemsUseCaseInput {
  const CheckoutSelectedItemsUseCaseInput._();
  const factory CheckoutSelectedItemsUseCaseInput({
    required String userId,
    required List<String> selectedCartItemIds,
    required double totalPrice,
    required String addressLine,
    String? paymentMethod,
    String? status,
    String? note,
    required List<OrderItemEntity> orderItems,
  }) = _CheckoutSelectedItemsUseCaseInput;
}

@freezed
sealed class CheckoutSelectedItemsUseCaseOutput extends BaseOutput with _$CheckoutSelectedItemsUseCaseOutput {
  const CheckoutSelectedItemsUseCaseOutput._();
  const factory CheckoutSelectedItemsUseCaseOutput() = _CheckoutSelectedItemsUseCaseOutput;
}