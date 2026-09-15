import 'dart:async';

import 'package:app/app.dart';
import 'package:app/ui/checkout/bloc/checkout.dart';
import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CheckoutBloc extends BaseBloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc(
    this._checkoutSelectedItemsUseCase,
    this._getMeUseCase,
  ) : super(const CheckoutState()) {
    on<CheckoutPageInitiated>(_onCheckoutPageInitiated, transformer: log());
    on<CheckoutSubmitted>(_onCheckoutSubmitted, transformer: log());
  }

  final CheckoutSelectedItemsUseCase _checkoutSelectedItemsUseCase;
  final GetMeUseCase _getMeUseCase;

  FutureOr<void> _onCheckoutPageInitiated(
    CheckoutPageInitiated event,
    Emitter<CheckoutState> emit,
  ) async {
    // State đã được set từ constructor args qua page
  }

  FutureOr<void> _onCheckoutSubmitted(
    CheckoutSubmitted event,
    Emitter<CheckoutState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        final user = await _getMeUseCase.execute(GetMeUseCaseInput());
        final userId = user.profile.id.toString();

        final productMap = {for (final p in state.products) p.id: p};

        final orderItemsData = state.selectedItems.map((item) {
          final product = productMap[item.productId]!;
          return <String, dynamic>{
            'product_id': item.productId,
            'variant_id': item.variantId,
            'quantity': item.quantity,
            'product_name_snapshot': product.name,
            'price_snapshot': product.effectivePrice,
          };
        }).toList();

        final orderData = CreateOrderRequestEntity(
          userId: userId,
          totalPrice: state.summary.total,
          addressLine: '', // TODO: lấy từ user input
        );

        await _checkoutSelectedItemsUseCase.execute(
          CheckoutSelectedItemsUseCaseInput(
            userId: userId,
            selectedCartItemIds: state.selectedItems.map((e) => e.id).toList(),
            orderData: orderData,
            orderItemsData: orderItemsData,
          ),
        );

        // TODO: navigate sang order success screen
        navigator.pop();
      },
    );
  }
}
