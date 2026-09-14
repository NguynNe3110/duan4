import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'favorite.dart';

@Injectable()
class FavoriteBloc extends BaseBloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc(
    this._getFavoritesUseCase,
    this._toggleFavoriteUseCase,
    this._getProductByIdUseCase,
    this._getMeUseCase,
  ) : super(FavoriteState()) {
    on<FavoritePageInitiated>(
      _onFavoritePageInitiated,
      transformer: log(),
    );

    on<FavoriteToggleFavorite>(
      _onFavoriteToggleFavorite,
      transformer: log(),
    );
  }

  final GetFavoritesUseCase _getFavoritesUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final GetProductByIdUseCase _getProductByIdUseCase;
  final GetMeUseCase _getMeUseCase;

  FutureOr<void> _onFavoritePageInitiated(
    FavoritePageInitiated event,
    Emitter<FavoriteState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        final user = await _getMeUseCase.execute(GetMeUseCaseInput());
        final userId = user.profile.id.toString();

        final favoritesOutput = await _getFavoritesUseCase.execute(
          GetFavoritesUseCaseInput(userId: userId),
        );

        final favoriteProductIds = favoritesOutput.favorites.map((f) => f.productId).toList();
        
        // Fetch detailed product info for each favorite
        // In a real app, you'd want a GetProductsByIdsUseCase
        final productFutures = favoriteProductIds.map(
          (id) => _getProductByIdUseCase.execute(GetProductByIdInput(id: id)),
        );

        final productsResults = await Future.wait(productFutures);
        final products = productsResults.map((output) => output.product).toList();

        emit(state.copyWith(
          products: LoadMoreOutput<ProductEntity>(
            data: products,
            isLastPage: true, // Favorites usually loaded all at once or handle paging later
          ),
        ));
      },
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isShimmerLoading: false)),
      handleLoading: false,
    );
  }

  FutureOr<void> _onFavoriteToggleFavorite(
    FavoriteToggleFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        final user = await _getMeUseCase.execute(GetMeUseCaseInput());
        final userId = user.profile.id.toString();

        // Optimistic UI update: remove from list if it's currently favorited
        if (event.isFavorited) {
          final updatedData = List<ProductEntity>.from(state.products.data)
            ..removeWhere((p) => p.id == event.productId);
          
          emit(state.copyWith(
            products: state.products.copyWith(data: updatedData),
          ));
        }

        await _toggleFavoriteUseCase.execute(ToggleFavoriteUseCaseInput(
          userId: userId,
          productId: event.productId,
          isFavorited: event.isFavorited,
        ));
      },
      doOnError: (e) async {
        // In case of error, re-initiate to fetch the correct state from server
        add(const FavoritePageInitiated());
      },
      handleLoading: false,
    );
  }
}
