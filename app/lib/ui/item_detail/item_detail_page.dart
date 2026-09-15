import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../app.dart';
import 'bloc/item_detail.dart';

@RoutePage()
class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({super.key, required this.product});

  final ProductEntity product;

  @override
  State<StatefulWidget> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends BasePageState<ItemDetailPage, ItemDetailBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const ItemDetailPageInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: Center(
        child: Text('Chi tiết sản phẩm: ${widget.product.name} - Giá: ${widget.product.effectivePrice}'),
      ),
    );
  }
}
