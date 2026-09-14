import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState extends BaseBlocState with _$HomeState {
  const HomeState._(); // bat buoc de get set
  factory HomeState({
    @Default(LoadMoreOutput<ProductEntity>(data: <ProductEntity>[])) LoadMoreOutput<ProductEntity> products,
    @Default(<CategoryEntity>[]) List<CategoryEntity> categories,
    ProfileEntity? profile,
    @Default(<String>{}) Set<String> favoriteProductIds, // tối ưu hơn List O(1) - O(n)
    @Default(false) bool isShimmerLoading,
    AppException? loadException,
    String? bannerData, // ponytail: placeholder for SDUI banner, upgrade when SDUI implemented
  }) = _HomeState;

  List<ProductEntity> get featuredProducts =>
      products.data.where((p) => p.isFeatured).toList();

  List<ProductEntity> get saleProducts =>
      products.data.where((p) => p.hasDiscount).toList();
}
