import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../data.dart';

@LazySingleton(as: ReviewRepository)
class ReviewRepositoryImpl extends ReviewRepository {
  final ReviewSupabaseService _reviewSupabaseService;
  final ReviewMapper _reviewMapper;

  ReviewRepositoryImpl(this._reviewMapper, this._reviewSupabaseService);

  @override
  Future<List<ReviewEntity>> getReviews({required String productId}) async {
    final dtos = await _reviewSupabaseService.getReviews(productId: productId);
    return _reviewMapper.mapToListEntity(dtos);
  }

  @override
  Future<List<ReviewEntity>> getReviewsByUser({required String userId}) async {
    final dtos = await _reviewSupabaseService.getReviewsByUser(userId: userId);
    return _reviewMapper.mapToListEntity(dtos);
  }

  @override
  Future<ReviewEntity> createReview({required CreateReviewRequestEntity data}) async {
    final dto = _reviewMapper.mapToDto(data);
    final responseDto = await _reviewSupabaseService.createReview(data: dto.toJson());
    return _reviewMapper.mapToEntity(responseDto);
  }

  @override
  Future<void> deleteReview({required String id}) async {
    await _reviewSupabaseService.deleteReview(id: id);
  }
}
