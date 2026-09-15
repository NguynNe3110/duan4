import 'package:app/app.dart';
import 'package:app/ui/cart/bloc/cart.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends BasePageState<CartPage, CartBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const CartPageInitiated());
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return BlocListener<CartBloc, CartState>(
      listenWhen: (pre, cur) => pre.loadException != cur.loadException,
      listener: (context, state) {
        // TODO: handle error display
      },
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.isShimmerLoading) {
          return const SizedBox.shrink(); // TODO: shimmer widget
        }
        // TODO: render state.items
        return const SizedBox.shrink();
      },
    );
  }
}
