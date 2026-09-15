import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app/app.dart';
import 'package:domain/domain.dart';

part 'order_history_state.freezed.dart';

@freezed
sealed class OrderHistoryState extends BaseBlocState with _$OrderHistoryState {
  const OrderHistoryState._();

  const factory OrderHistoryState({
    @Default([]) List<OrderEntity> orders,
    @Default(false) bool isShimmerLoading,
    @Default(false) bool hasReachedMax,
  }) = _OrderHistoryState;
}
