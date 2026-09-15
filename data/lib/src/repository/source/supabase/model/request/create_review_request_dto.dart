import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_review_request_dto.freezed.dart';
part 'create_review_request_dto.g.dart';

@freezed
sealed class CreateReviewRequestDto with _$CreateReviewRequestDto {
  const factory CreateReviewRequestDto({
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'rating') required int rating,
    @JsonKey(name: 'comment') String? comment,
  }) = _CreateReviewRequestDto;

  factory CreateReviewRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewRequestDtoFromJson(json);
}
