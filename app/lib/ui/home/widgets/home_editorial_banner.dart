import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import '../../../app.dart';

class HomeEditorialBanner extends StatelessWidget {
  const HomeEditorialBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.d20.responsive(),
        vertical: Dimens.d24.responsive(),
      ),
      sliver: SliverToBoxAdapter(
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFB8AE99),
              borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: Dimens.d16.responsive(),
                  left: Dimens.d16.responsive(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOOKBOOK',
                        style: AppTextStyles.s14w400Secondary().copyWith(
                          fontSize: Dimens.d10.responsive(),
                          letterSpacing: 1.2,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                      Text(
                        'Nord Autumn',
                        style: AppTextStyles.s14w400Primary().copyWith(
                          fontSize: Dimens.d22.responsive(),
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
