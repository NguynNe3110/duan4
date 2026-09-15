import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';
import 'bloc/order_history.dart';

@RoutePage()
class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends BasePageState<OrderHistoryPage, OrderHistoryBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const OrderHistoryPageInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
        builder: (context, state) {
          if (state.isShimmerLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.orders.isEmpty) {
            return const Center(child: Text('Chưa có đơn hàng nào'));
          }

          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              final order = state.orders[index];
              return ListTile(
                title: Text('Mã đơn hàng: ${order.id}'),
                subtitle: Text('Tổng tiền: ${order.totalPrice}'),
              );
            },
          );
        },
      ),
    );
  }
}
