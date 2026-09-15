import 'dart:async';

import 'package:app/app.dart';
import 'package:app/ui/item_detail/bloc/item_detail.dart';
import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<T> throttle<T>(Duration duration) {
  return (events, mapper) => events.throttleTime(duration).flatMap(mapper);
}

@Injectable()
class ItemDetailBloc extends BaseBloc<ItemDetailEvent, ItemDetailState> {
  ItemDetailBloc(
    this._getMeUseCase,
    this._addToCartUseCase,
  ) : super(const ItemDetailState()) {
    on<ItemDetailPageInitiated>(
      _onItemDetailPageInitiated,
      transformer: log(),
    );
    // Dùng throttle 500ms chặn spam click Add To Cart
    on<ItemDetailAddToCartPressed>(
      _onItemDetailAddToCartPressed,
      transformer: throttle(const Duration(milliseconds: 500)),
    );
  }

  final GetMeUseCase _getMeUseCase;
  final AddToCartUseCase _addToCartUseCase;

  FutureOr<void> _onItemDetailPageInitiated(
    ItemDetailPageInitiated event,
    Emitter<ItemDetailState> emit,
  ) async {
    // Logic fetch item detail
  }

  FutureOr<void> _onItemDetailAddToCartPressed(
    ItemDetailAddToCartPressed event,
    Emitter<ItemDetailState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        final user = await _getMeUseCase.execute(GetMeUseCaseInput());
        final userId = user.profile.id.toString();

        await _addToCartUseCase.execute(AddToCartInput(
          productId: event.productId,
          variantId: event.variantId,
          quantity: event.quantity,
          userId: userId,
        ));
        
        // Gọi thẳng AppNavigator để show snackbar thành công
        navigator.showSuccessSnackBar('Thêm vào giỏ hàng thành công');
      },
      doOnSubscribe: () async => emit(state.copyWith(isAddingToCart: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isAddingToCart: false)),
      handleLoading: false, // Tắt loading toàn màn hình, dùng isAddingToCart ở UI
    );
  }
}
