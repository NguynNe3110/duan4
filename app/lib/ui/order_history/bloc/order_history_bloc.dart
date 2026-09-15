import 'dart:async';

import 'package:app/app.dart';
import 'package:app/ui/order_history/bloc/order_history.dart';
import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class OrderHistoryBloc extends BaseBloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc() : super(const OrderHistoryState()) {
    on<OrderHistoryPageInitiated>(_onOrderHistoryPageInitiated, transformer: log());
    on<OrderHistoryLoadMore>(_onOrderHistoryLoadMore, transformer: log());
  }

  FutureOr<void> _onOrderHistoryPageInitiated(
    OrderHistoryPageInitiated event,
    Emitter<OrderHistoryState> emit,
  ) async {
    // TODO: get order history usecase
  }

  FutureOr<void> _onOrderHistoryLoadMore(
    OrderHistoryLoadMore event,
    Emitter<OrderHistoryState> emit,
  ) async {
    // TODO: pagination
  }
}
