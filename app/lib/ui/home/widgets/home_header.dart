import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:domain/domain.dart';
import '../../../app.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.profile,
    this.onSearchTap,
    this.onNotificationTap,
    super.key,
  });

  final ProfileEntity? profile;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.d20.responsive(),
        vertical: Dimens.d12.responsive(),
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CHÀO BUỔI SÁNG',
                  style: AppTextStyles.s14w400Secondary().copyWith(
                    fontSize: Dimens.d10.responsive(),
                    letterSpacing: 1.4,
                    color: const Color(0xFF6B6862),
                  ),
                ),
                Text(
                  profile?.fullName ?? 'Khách',
                  style: AppTextStyles.s14w400Primary().copyWith(
                    fontSize: Dimens.d22.responsive(),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                _buildIconButton(Icons.search_rounded, onSearchTap ?? () {}),
                SizedBox(width: Dimens.d8.responsive()),
                _buildIconButton(Icons.notifications_none_rounded, onNotificationTap ?? () {}, hasBadge: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap, {bool hasBadge = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Dimens.d40.responsive(),
        height: Dimens.d40.responsive(),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, size: Dimens.d24.responsive(), color: const Color(0xFF111110)),
            if (hasBadge)
              Positioned(
                top: Dimens.d10.responsive(),
                right: Dimens.d10.responsive(),
                child: Container(
                  width: Dimens.d6.responsive(),
                  height: Dimens.d6.responsive(),
                  decoration: const BoxDecoration(
                    color: Color(0xFFC2410C),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
