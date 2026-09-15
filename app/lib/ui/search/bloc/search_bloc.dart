import 'dart:async';

import 'package:app/app.dart';
import 'package:app/ui/search/bloc/search.dart';
import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SearchBloc extends BaseBloc<SearchEvent, SearchState> {
  SearchBloc(this._getProductsUseCase, this._addSearchHistoryUseCase) : super(const SearchState()) {
    on<SearchPageInitiated>(_onSearchPageInitiated, transformer: log());
    on<SearchKeywordChanged>(_onSearchKeywordChanged, transformer: log());
    on<SearchKeywordSubmitted>(_onSearchKeywordSubmitted, transformer: log());
    on<SearchProductClicked>(_onSearchProductClicked, transformer: log());
  }

  final GetProductsUseCase _getProductsUseCase;
  final AddSearchHistoryUseCase _addSearchHistoryUseCase;

  FutureOr<void> _onSearchPageInitiated(
    SearchPageInitiated event,
    Emitter<SearchState> emit,
  ) async {
    // load search history suggestions...
  }

  FutureOr<void> _onSearchKeywordChanged(
    SearchKeywordChanged event,
    Emitter<SearchState> emit,
  ) async {
    // Chỉ dùng để gợi ý local hoặc filter list suggestion, KHÔNG gọi API search ở đây.
  }

  FutureOr<void> _onSearchKeywordSubmitted(
    SearchKeywordSubmitted event,
    Emitter<SearchState> emit,
  ) async {
    if (event.keyword.trim().isEmpty) return;

    return runBlocCatching(
      action: () async {
        // Lưu lịch sử khi submit
        await _addSearchHistoryUseCase.execute(AddSearchHistoryInput(keyword: event.keyword));
        
        final output = await _getProductsUseCase.execute(GetProductsInput(offset: 0)); // TODO: truyền keyword
        emit(state.copyWith(searchResults: output.products));
      },
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isShimmerLoading: false)),
      handleLoading: false,
    );
  }

  FutureOr<void> _onSearchProductClicked(
    SearchProductClicked event,
    Emitter<SearchState> emit,
  ) async {
    // final product = state.searchResults.firstWhere((p) => p.id == event.productId);
    // await navigator.push(AppRouteInfo.itemDetail(product));
  }
}
