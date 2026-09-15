import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order_item_request_dto.freezed.dart';
part 'create_order_item_request_dto.g.dart';

@freezed
sealed class CreateOrderItemRequestDto with _$CreateOrderItemRequestDto {
  const factory CreateOrderItemRequestDto({
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'product_id') String? productId,
    @JsonKey(name: 'variant_id') String? variantId,
    @JsonKey(name: 'product_name_snapshot') required String productNameSnapshot,
    @JsonKey(name: 'variant_snapshot') Map<String, dynamic>? variantSnapshot,
    @JsonKey(name: 'price_snapshot') required double priceSnapshot,
    @JsonKey(name: 'quantity') required int quantity,
    @JsonKey(name: 'image_url_snapshot') String? imageUrlSnapshot,
  }) = _CreateOrderItemRequestDto;

  factory CreateOrderItemRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderItemRequestDtoFromJson(json);
}
