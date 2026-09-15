import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app/app.dart';

part 'item_detail_state.freezed.dart';

@freezed
sealed class ItemDetailState extends BaseBlocState with _$ItemDetailState {
  const ItemDetailState._();

  const factory ItemDetailState({
    @Default(false) bool isShimmerLoading,
    @Default(false) bool isAddingToCart,
  }) = _ItemDetailState;
}
