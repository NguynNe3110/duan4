import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_review_request_entity.freezed.dart';

@freezed
sealed class CreateReviewRequestEntity with _$CreateReviewRequestEntity {
  const factory CreateReviewRequestEntity({
    required String productId,
    required String userId,
    required int rating,
    String? comment,
  }) = _CreateReviewRequestEntity;
}