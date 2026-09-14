import 'package:flutter/material.dart';
import 'package:domain/domain.dart';
import 'product_card.dart';
import '../../../app.dart';

class HomeProductGrid extends StatelessWidget {
  const HomeProductGrid({
    required this.products,
    required this.favoriteProductIds,
    this.onFavoriteTap,
    this.onProductTap,
    super.key,
  });

  final List<ProductEntity> products;
  final Set<String> favoriteProductIds;
  final Function(ProductEntity, bool)? onFavoriteTap;
  final Function(ProductEntity)? onProductTap;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: Dimens.d24.responsive(),
          crossAxisSpacing: Dimens.d12.responsive(),
          childAspectRatio: 0.6,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];
            final isFavorited = favoriteProductIds.contains(product.id);
            return ProductCard(
              product: product,
              isFavorited: isFavorited,
              onTap: () => onProductTap?.call(product),
              onFavoriteTap: () => onFavoriteTap?.call(product, isFavorited),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
