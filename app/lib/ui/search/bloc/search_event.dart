import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/app.dart';

part 'search_event.freezed.dart';

abstract class SearchEvent extends BaseBlocEvent {
  const SearchEvent();
}

@freezed
sealed class SearchPageInitiated extends SearchEvent with _$SearchPageInitiated {
  const SearchPageInitiated._();
  const factory SearchPageInitiated() = _SearchPageInitiated;
}

@freezed
sealed class SearchKeywordChanged extends SearchEvent with _$SearchKeywordChanged {
  const SearchKeywordChanged._();
  const factory SearchKeywordChanged({required String keyword}) = _SearchKeywordChanged;
}

@freezed
sealed class SearchKeywordSubmitted extends SearchEvent with _$SearchKeywordSubmitted {
  const SearchKeywordSubmitted._();
  const factory SearchKeywordSubmitted({required String keyword}) = _SearchKeywordSubmitted;
}

@freezed
sealed class SearchProductClicked extends SearchEvent with _$SearchProductClicked {
  const SearchProductClicked._();
  const factory SearchProductClicked({required String productId}) = _SearchProductClicked;
}
