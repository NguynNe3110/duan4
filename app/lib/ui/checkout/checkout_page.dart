import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';
import 'bloc/checkout.dart';

@RoutePage()
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    super.key,
    required this.selectedItems,
    required this.products,
    required this.summary,
  });

  final List<CartItemEntity> selectedItems;
  final List<ProductEntity> products;
  final CartSummaryEntity summary;

  @override
  State<StatefulWidget> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends BasePageState<CheckoutPage, CheckoutBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const CheckoutPageInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sản phẩm đã chọn: ${state.selectedItems.length}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.selectedItems.length,
                    itemBuilder: (context, index) {
                      final item = state.selectedItems[index];
                      final product = state.products.firstWhere((p) => p.id == item.productId);
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text('Số lượng: ${item.quantity}'),
                        trailing: Text('Giá: ${product.effectivePrice * item.quantity}'),
                      );
                    },
                  ),
                ),
                Divider(),
                Text('Tổng tiền: ${state.summary.total}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    bloc.add(const CheckoutSubmitted());
                  },
                  child: Center(child: Text('Xác nhận đặt hàng')),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
