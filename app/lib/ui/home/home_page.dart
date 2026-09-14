import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'widgets/home_categories.dart';
import 'widgets/home_editorial_banner.dart';
import 'widgets/home_flash_sale.dart';
import 'widgets/home_grid_loader.dart';
import 'widgets/home_header.dart';
import 'widgets/home_product_grid.dart';
import 'widgets/home_section_title.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends BasePageState<HomePage, HomeBloc> {
  late final _pagingController = CommonPagingController<ProductEntity>()..disposeBy(disposeBag);

  @override
  void initState() { // khoi tao
    super.initState();
    bloc.add(const HomePageInitiated());
    _pagingController.listen(
      onLoadMore: () => bloc.add(const HomeLoadMoreProducts()),
    );
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    //dùng multiBLocListener để tách biệt việc sử lý side-effect
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) => previous.products != current.products,
          listener: (context, state) {
            _pagingController.appendLoadMoreOutput(state.products);
          },
        ),
        BlocListener<HomeBloc, HomeState>(
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
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.products != current.products ||
              previous.categories != current.categories ||
              previous.profile != current.profile ||
              previous.favoriteProductIds != current.favoriteProductIds ||
              previous.isShimmerLoading != current.isShimmerLoading,
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () {
                final completer = Completer<void>();
                bloc.add(HomePageRefreshed(completer: completer));
                return completer.future;
              },
              child: CustomScrollView(
                slivers: [
                  HomeHeader(
                    profile: state.profile,
                    onSearchTap: () {}, // TODO(nals): Implement search
                    onNotificationTap: () {}, // TODO(nals): Implement notifications
                  ),
                  const HomeFlashSale(),
                  HomeCategories(
                    categories: state.categories,
                    onSeeAll: () {}, // TODO(nals): Navigate to category list
                    onCategoryTap: (category) {}, // TODO(nals): Navigate to category detail
                  ),
                  const HomeSectionTitle(
                    title: 'Mới về',
                    eyebrow: 'TUẦN NÀY',
                  ),
                  HomeProductGrid(
                    products: state.products.data.take(2).toList(),
                    favoriteProductIds: state.favoriteProductIds,
                    onFavoriteTap: _onToggleFavorite,
                    onProductTap: _onProductTap,
                  ),
                  const HomeEditorialBanner(),
                  const HomeSectionTitle(
                    title: 'Bán chạy',
                  ),
                  HomeProductGrid(
                    products: state.products.data.skip(2).take(4).toList(),
                    favoriteProductIds: state.favoriteProductIds,
                    onFavoriteTap: _onToggleFavorite,
                    onProductTap: _onProductTap,
                  ),
                  // Grid loader for more products
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
                    sliver: SliverToBoxAdapter(
                      child: state.isShimmerLoading && state.products.data.isEmpty
                          ? const HomeGridLoader()
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onToggleFavorite(ProductEntity product, bool isFavorited) {
    bloc.add(HomeToggleFavorite(
      productId: product.id,
      isFavorited: isFavorited,
    ));
  }

  void _onProductTap(ProductEntity product) {
    // TODO(nals): Navigate to product detail
  }
}
