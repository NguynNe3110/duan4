import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'home.dart';

@Injectable()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(
      this._getProductsUseCase,
      this._getCategoriesUseCase,
      this._getProfileUseCase,
      this._getFavoritesUseCase,
      this._toggleFavoriteUseCase,
      this._getMeUseCase,

      ) : super(HomeState()) {
    on<HomePageInitiated>(
      _onHomePageInitiated,
      transformer: log(),
    );

    on<HomePageRefreshed>(
      _onHomePageRefreshed,
      transformer: log(),
    );

    on<HomeLoadMoreProducts>(
      _onHomeLoadMoreProducts,
      transformer: log(),
    );

    on<HomeToggleFavorite>(
      _onHomeToggleFavorite,
      transformer: log(),
    );
  }

  final GetProductsUseCase _getProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final GetFavoritesUseCase _getFavoritesUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final GetMeUseCase _getMeUseCase;

  FutureOr<void> _onHomePageInitiated(
      HomePageInitiated event,
      Emitter<HomeState> emit,
      ) async {
    await _loadHomeData(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async =>
          emit(state.copyWith(isShimmerLoading: false)),
    );
  }

  FutureOr<void> _onHomePageRefreshed(
      HomePageRefreshed event,
      Emitter<HomeState> emit,
      ) async {
    await _loadHomeData(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async {
        emit(state.copyWith(isShimmerLoading: false));
        if (!event.completer.isCompleted) {
          event.completer.complete();
        }
      },
    );
  }

  FutureOr<void> _onHomeLoadMoreProducts(
      HomeLoadMoreProducts event,
      Emitter<HomeState> emit,
      ) async {
    await _loadHomeData(
      emit: emit,
      isInitialLoad: false,
    );
  }

  FutureOr<void> _onHomeToggleFavorite(
      HomeToggleFavorite event,
      Emitter<HomeState> emit,
      ) async {
    return runBlocCatching(
      action: () async {
        final user = await _getMeUseCase.execute(GetMeUseCaseInput());
        final userId = user.profile.id.toString();

        final updatedFavs = Set<String>.from(state.favoriteProductIds);
        if (event.isFavorited) {
        updatedFavs.remove(event.productId);
        } else {
        updatedFavs.add(event.productId);
        }
        // Optimistic update
        emit(state.copyWith(favoriteProductIds: updatedFavs));

        await _toggleFavoriteUseCase.execute(ToggleFavoriteUseCaseInput(
        userId: userId,
        productId: event.productId,
        isFavorited: event.isFavorited,
        ));
      },
      doOnError: (e) async {
        // Revert optimistic update
        final revertedFavs = Set<String>.from(state.favoriteProductIds);
        if (event.isFavorited) {
          revertedFavs.add(event.productId);
        } else {
          revertedFavs.remove(event.productId);
        }
        emit(state.copyWith(favoriteProductIds: revertedFavs));
      },
      handleLoading: false,
    );
  }

  Future<void> _loadHomeData({
    required Emitter<HomeState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
  }) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(loadException: null));

        final user = await _getMeUseCase.execute(GetMeUseCaseInput());
        final userId = user.profile.id.toString();

        final currentData = isInitialLoad
            ? <ProductEntity>[]
            : List<ProductEntity>.from(state.products.data);
        final offset = isInitialLoad ? 0 : currentData.length;

        final results = await Future.wait([
          _getProductsUseCase.execute(
            GetProductsInput(offset: offset),
          ),
          if (isInitialLoad) ...[
            _getCategoriesUseCase.execute(const GetCategoriesUseCaseInput()),
            _getProfileUseCase.execute(GetProfileUseCaseInput(userId: userId)),
            _getFavoritesUseCase.execute(
              GetFavoritesUseCaseInput(userId: userId),
            ),
          ],
        ]);

        final productsOutput = results[0] as GetProductsOutput;
        final newProducts = [...currentData, ...productsOutput.products];
        // ponytail: manual paging via offset, upgrade to BaseLoadMoreUseCase when GetProductsUseCase supports it
        final loadMoreOutput = LoadMoreOutput<ProductEntity>(
          data: newProducts,
          page: state.products.page + 1,
          offset: newProducts.length,
          isLastPage: productsOutput.products.isEmpty,
        );

        if (isInitialLoad) {
          final categoriesOutput = results[1] as GetCategoriesUseCaseOutput;
          final profileOutput = results[2] as GetProfileUseCaseOutput;
          final favoritesOutput = results[3] as GetFavoritesUseCaseOutput;
          final favoriteIds =
          favoritesOutput.favorites.map((f) => f.productId).toSet();

          emit(state.copyWith(
            products: loadMoreOutput,
            categories: categoriesOutput.categories,
            profile: profileOutput.profile,
            favoriteProductIds: favoriteIds,
          ));
        } else {
          emit(state.copyWith(products: loadMoreOutput));
        }
      },
      doOnError: (e) async {
        emit(state.copyWith(loadException: e));
      },
      doOnSubscribe: doOnSubscribe,
      doOnSuccessOrError: doOnSuccessOrError,
      handleLoading: false,
      maxRetries: 3,
    );
  }
}
