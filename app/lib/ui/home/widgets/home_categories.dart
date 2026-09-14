import 'package:flutter/material.dart';
import 'package:domain/domain.dart';
import 'package:shared/shared.dart';
import '../../../app.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    required this.categories,
    this.onSeeAll,
    this.onCategoryTap,
    super.key,
  });

  final List<CategoryEntity> categories;
  final VoidCallback? onSeeAll;
  final Function(CategoryEntity)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _buildSectionTitle(
            context,
            title: 'Danh mục',
            onSeeAll: onSeeAll,
          ),
          SizedBox(
            height: Dimens.d100.responsive(),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: EdgeInsets.only(right: Dimens.d16.responsive()),
                  child: GestureDetector(
                    onTap: () => onCategoryTap?.call(category),
                    child: Column(
                      children: [
                        Container(
                          width: Dimens.d68.responsive(),
                          height: Dimens.d68.responsive(),
                          decoration: BoxDecoration(
                            color: _getCategoryTone(index),
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: category.imageUrl != null
                                ? Image.network(category.imageUrl!, fit: BoxFit.cover)
                                : null,
                          ),
                        ),
                        SizedBox(height: Dimens.d6.responsive()),
                        Text(
                          category.name,
                          style: AppTextStyles.s14w400Primary().copyWith(
                            fontSize: Dimens.d11.responsive(),
                            color: const Color(0xFF3C3B38),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: Dimens.d24.responsive()),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    BuildContext context, {
    required String title,
    VoidCallback? onSeeAll,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Dimens.d20.responsive(),
        Dimens.d20.responsive(),
        Dimens.d20.responsive(),
        Dimens.d12.responsive(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: AppTextStyles.s14w400Primary().copyWith(
              fontSize: Dimens.d22.responsive(),
              fontWeight: FontWeight.w500,
            ),
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
    );
  }

  Color _getCategoryTone(int index) {
    final tones = [
      const Color(0xFFD9CFBE),
      const Color(0xFFE8CBB8),
      const Color(0xFFE4DDD0),
      const Color(0xFFC9BFA9),
      const Color(0xFFB8AE99),
    ];
    return tones[index % tones.length];
  }
}
