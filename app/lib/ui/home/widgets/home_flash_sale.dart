import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import '../../../app.dart';

class HomeFlashSale extends StatelessWidget {
  const HomeFlashSale({
    this.onBuyNowTap,
    super.key,
  });

  final VoidCallback? onBuyNowTap;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: Dimens.d180.responsive(),
          padding: EdgeInsets.all(Dimens.d20.responsive()),
          decoration: BoxDecoration(
            color: const Color(0xFF111110),
            borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -Dimens.d20.responsive(),
                top: -Dimens.d10.responsive(),
                child: Container(
                  width: Dimens.d140.responsive(),
                  height: Dimens.d140.responsive(),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8CBB8).withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FLASH SALE · 24H',
                    style: AppTextStyles.s14w400Secondary().copyWith(
                      fontSize: Dimens.d10.responsive(),
                      letterSpacing: 1.2,
                      color: const Color(0xFFF3F1EC),
                    ),
                  ),
                  SizedBox(height: Dimens.d6.responsive()),
                  Text(
                    'Giảm đến 50%',
                    style: AppTextStyles.s14w400Primary().copyWith(
                      fontSize: Dimens.d30.responsive(),
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: Dimens.d12.responsive()),
                  Row(
                    children: ['12', '48', '05']
                        .map((t) => Container(
                              margin: EdgeInsets.only(right: Dimens.d6.responsive()),
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimens.d10.responsive(),
                                vertical: Dimens.d4.responsive(),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(Dimens.d6.responsive()),
                              ),
                              child: Text(
                                t,
                                style: AppTextStyles.s14w400Primary().copyWith(
                                  fontSize: Dimens.d13.responsive(),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: Dimens.d14.responsive()),
                  GestureDetector(
                    onTap: onBuyNowTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimens.d18.responsive(),
                        vertical: Dimens.d10.responsive(),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Dimens.d30.responsive()),
                      ),
                      child: Text(
                        'Mua ngay →',
                        style: AppTextStyles.s14w400Primary().copyWith(
                          fontSize: Dimens.d12.responsive(),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF111110),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
