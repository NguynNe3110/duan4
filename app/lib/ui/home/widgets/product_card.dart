import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.isFavorited,
    this.onTap,
    this.onFavoriteTap,
    super.key,
  });

  final ProductEntity product;
  final bool isFavorited;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F1EC),
                    borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
                    child: product.primaryImageUrl != null
                        ? Image.network(
                            product.primaryImageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (_, __, ___) => _buildPlaceholder(),
                          )
                        : _buildPlaceholder(),
                  ),
                ),
                if (product.hasDiscount)
                  Positioned(
                    top: Dimens.d8.responsive(),
                    left: Dimens.d8.responsive(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimens.d6.responsive(),
                        vertical: Dimens.d2.responsive(),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC2410C),
                        borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                      ),
                      child: Text(
                        '-${_calculateDiscount()}%',
                        style: AppTextStyles.s14w400Primary().copyWith(
                          color: Colors.white,
                          fontSize: Dimens.d10.responsive(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: Dimens.d8.responsive(),
                  right: Dimens.d8.responsive(),
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      width: Dimens.d32.responsive(),
                      height: Dimens.d32.responsive(),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        size: Dimens.d18.responsive(),
                        color: isFavorited ? const Color(0xFFC2410C) : const Color(0xFF111110),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimens.d8.responsive()),
          if (product.categoryName != null)
            Text(
              product.categoryName!.toUpperCase(),
              style: AppTextStyles.s14w400Secondary().copyWith(
                fontSize: Dimens.d10.responsive(),
                letterSpacing: 1.2,
                color: const Color(0xFF6B6862),
              ),
            ),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s14w400Primary().copyWith(
              fontSize: Dimens.d13.responsive(),
              color: const Color(0xFF111110),
            ),
          ),
          SizedBox(height: Dimens.d4.responsive()),
          Row(
            children: [
              if (product.hasDiscount) ...[
                Text(
                  NumberFormatUtils.formatYen(product.price.toDouble()),
                  style: AppTextStyles.s14w400Secondary().copyWith(
                    fontSize: Dimens.d13.responsive(),
                    decoration: TextDecoration.lineThrough,
                    color: const Color(0xFFA5A199),
                  ),
                ),
                SizedBox(width: Dimens.d6.responsive()),
              ],
              Text(
                NumberFormatUtils.formatYen(product.effectivePrice.toDouble()),
                style: AppTextStyles.s14w400Primary().copyWith(
                  fontSize: Dimens.d13.responsive(),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111110),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.image_outlined,
        color: const Color(0xFFA5A199),
        size: Dimens.d30.responsive(),
      ),
    );
  }

  int _calculateDiscount() {
    if (product.discountPrice == null || product.price == 0) return 0;
    return (((product.price - product.discountPrice!) / product.price) * 100).round();
  }
}
