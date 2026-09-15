import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ReviewMapper extends BaseDataMapper<ReviewResponseDto, ReviewEntity> {
  @override
  ReviewEntity mapToEntity(ReviewResponseDto? data) {
    return ReviewEntity(
      id: data?.id ?? '',
      productId: data?.productId ?? '',
      userId: data?.userId ?? '',
      rating: data?.rating ?? 0,
      comment: data?.comment,
      imageUrls: const [], // Enrich từ review_images table sau
      createdAt: DateTime.tryParse(data?.createdAt ?? ''),
      updatedAt: DateTime.tryParse(data?.updatedAt ?? ''),
    );
  }

  CreateReviewRequestDto mapToDto(CreateReviewRequestEntity data) {
    return CreateReviewRequestDto(
      productId: data.productId,
      userId: data.userId,
      rating: data.rating,
      comment: data.comment,
    );
  }
}
