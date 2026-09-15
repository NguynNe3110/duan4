import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order_request_dto.freezed.dart';
part 'create_order_request_dto.g.dart';

@freezed
sealed class CreateOrderRequestDto with _$CreateOrderRequestDto {
  const factory CreateOrderRequestDto({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'total_price') required double totalPrice,
    @JsonKey(name: 'address_line') required String addressLine,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'note') String? note,
  }) = _CreateOrderRequestDto;

  factory CreateOrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestDtoFromJson(json);
}
