import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/app.dart';

part 'item_detail_event.freezed.dart';

abstract class ItemDetailEvent extends BaseBlocEvent {
  const ItemDetailEvent();
}

@freezed
sealed class ItemDetailPageInitiated extends ItemDetailEvent with _$ItemDetailPageInitiated {
  const ItemDetailPageInitiated._();
  const factory ItemDetailPageInitiated() = _ItemDetailPageInitiated;
}

@freezed
sealed class ItemDetailAddToCartPressed extends ItemDetailEvent with _$ItemDetailAddToCartPressed {
  const ItemDetailAddToCartPressed._();
  const factory ItemDetailAddToCartPressed({
    required String productId,
    required String variantId,
    required int quantity,
  }) = _ItemDetailAddToCartPressed;
}
