import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app/app.dart';

part 'order_history_event.freezed.dart';

abstract class OrderHistoryEvent extends BaseBlocEvent {
  const OrderHistoryEvent();
}

@freezed
sealed class OrderHistoryPageInitiated extends OrderHistoryEvent with _$OrderHistoryPageInitiated {
  const OrderHistoryPageInitiated._();
  const factory OrderHistoryPageInitiated() = _OrderHistoryPageInitiated;
}

@freezed
sealed class OrderHistoryLoadMore extends OrderHistoryEvent with _$OrderHistoryLoadMore {
  const OrderHistoryLoadMore._();
  const factory OrderHistoryLoadMore() = _OrderHistoryLoadMore;
}
