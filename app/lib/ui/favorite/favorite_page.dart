import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../home/widgets/product_card.dart';
import 'bloc/favorite.dart';

@RoutePage()
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FavoritePageState();
  }
}

class _FavoritePageState extends BasePageState<FavoritePage, FavoriteBloc> {
  late final _pagingController = CommonPagingController<ProductEntity>()..disposeBy(disposeBag);

  @override
  void initState() {
    super.initState();
    bloc.add(const FavoritePageInitiated());
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FavoriteBloc, FavoriteState>(
          listenWhen: (previous, current) => previous.products != current.products,
          listener: (context, state) {
            _pagingController.appendLoadMoreOutput(state.products);
          },
        ),
        BlocListener<FavoriteBloc, FavoriteState>(
          listenWhen: (previous, current) => previous.loadException != current.loadException,
          listener: (context, state) {
            _pagingController.error = state.loadException;
          },
        ),
      ],
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      backgroundColor: const Color(0xFFFAFAF7),
      appBar: CommonAppBar(
        text: 'Yêu thích',
        titleTextStyle: AppTextStyles.s14w400Primary().copyWith(
          fontSize: Dimens.d20.responsive(),
          fontWeight: FontWeight.w500,
          fontFamily: 'Instrument Serif', // Matches the design's serif font
          fontStyle: FontStyle.italic,
        ),
        centerTitle: true,
        leadingIcon: LeadingIcon.none,
        actions: [
          IconButton(
            onPressed: () => navigator.push(AppRouteInfo.search()),
            icon: Icon(Icons.search_rounded, size: Dimens.d24.responsive()),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSubHeader(),
            Expanded(
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                buildWhen: (previous, current) =>
                    previous.products != current.products ||
                    previous.isShimmerLoading != current.isShimmerLoading,
                builder: (context, state) {
                  if (state.isShimmerLoading && state.products.data.isEmpty) {
                    return _buildLoader();
                  }

                  if (state.products.data.isEmpty) {
                    return _buildEmptyState();
                  }

                  return CommonPagedGridView<ProductEntity>(
                    pagingController: _pagingController,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.d20.responsive(),
                      vertical: Dimens.d16.responsive(),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: Dimens.d24.responsive(),
                      crossAxisSpacing: Dimens.d12.responsive(),
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, product, index) {
                      return ProductCard(
                        product: product,
                        isFavorited: true, // It's the favorite screen
                        onFavoriteTap: () {
                          bloc.add(FavoriteToggleFavorite(
                            productId: product.id,
                            isFavorited: true,
                          ));
                        },
                        onTap: () {
                          // Navigate to detail
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubHeader() {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      buildWhen: (previous, current) => previous.products.data.length != current.products.data.length,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.d20.responsive(),
            vertical: Dimens.d12.responsive(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${state.products.data.length} sản phẩm',
                style: AppTextStyles.s14w400Secondary().copyWith(
                  fontSize: Dimens.d12.responsive(),
                  color: const Color(0xFF6B6862),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO(nals): Implement Sort
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimens.d12.responsive(),
                    vertical: Dimens.d6.responsive(),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFDDD8CE)),
                    borderRadius: BorderRadius.circular(Dimens.d20.responsive()),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.sort_rounded, size: Dimens.d14.responsive(), color: const Color(0xFF111110)),
                      SizedBox(width: Dimens.d6.responsive()),
                      Text(
                        'Đã thêm gần nhất',
                        style: AppTextStyles.s14w400Primary().copyWith(
                          fontSize: Dimens.d12.responsive(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: Dimens.d60.responsive(),
            color: const Color(0xFFA5A199),
          ),
          SizedBox(height: Dimens.d16.responsive()),
          Text(
            'Chưa có sản phẩm yêu thích',
            style: AppTextStyles.s14w400Primary().copyWith(
              fontSize: Dimens.d18.responsive(),
              color: const Color(0xFF111110),
            ),
          ),
          SizedBox(height: Dimens.d8.responsive()),
          Text(
            'Lưu sản phẩm bạn thích để xem lại sau.',
            style: AppTextStyles.s14w400Secondary().copyWith(
              fontSize: Dimens.d14.responsive(),
              color: const Color(0xFF6B6862),
            ),
          ),
          SizedBox(height: Dimens.d24.responsive()),
          ElevatedButton(
            onPressed: () => navigator.popUntilRootOfCurrentBottomTab(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF111110),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.d24.responsive(),
                vertical: Dimens.d12.responsive(),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.d30.responsive()),
              ),
            ),
            child: const Text('Bắt đầu mua sắm'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoader() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.d20.responsive(),
        vertical: Dimens.d16.responsive(),
      ),
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
