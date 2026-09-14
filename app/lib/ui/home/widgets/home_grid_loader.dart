import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import '../../../app.dart';

class HomeGridLoader extends StatelessWidget {
  const HomeGridLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Dimens.d24.responsive(),
        crossAxisSpacing: Dimens.d12.responsive(),
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) => const _LoadingItem(),
    );
  }
}

class _LoadingItem extends StatelessWidget {
  const _LoadingItem();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: RoundedRectangleShimmer(
            width: double.infinity,
            height: double.infinity,
            borderRadius: Dimens.d12.responsive(),
          ),
        ),
        SizedBox(height: Dimens.d8.responsive()),
        RoundedRectangleShimmer(
          width: Dimens.d100.responsive(),
          height: Dimens.d14.responsive(),
        ),
        SizedBox(height: Dimens.d4.responsive()),
        RoundedRectangleShimmer(
          width: double.infinity,
          height: Dimens.d14.responsive(),
        ),
      ],
    );
  }
}
