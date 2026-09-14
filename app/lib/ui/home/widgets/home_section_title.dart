import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import '../../../app.dart';

class HomeSectionTitle extends StatelessWidget {
  const HomeSectionTitle({
    required this.title,
    this.eyebrow,
    this.onSeeAll,
    super.key,
  });

  final String title;
  final String? eyebrow;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(
        Dimens.d20.responsive(),
        Dimens.d20.responsive(),
        Dimens.d20.responsive(),
        Dimens.d12.responsive(),
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (eyebrow != null)
                  Text(
                    eyebrow!,
                    style: AppTextStyles.s14w400Secondary().copyWith(
                      fontSize: Dimens.d10.responsive(),
                      letterSpacing: 1.2,
                      color: const Color(0xFF6B6862),
                    ),
                  ),
                Text(
                  title,
                  style: AppTextStyles.s14w400Primary().copyWith(
                    fontSize: Dimens.d22.responsive(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (onSeeAll != null)
              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  'Tất cả',
                  style: AppTextStyles.s14w400Secondary().copyWith(
                    fontSize: Dimens.d12.responsive(),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
