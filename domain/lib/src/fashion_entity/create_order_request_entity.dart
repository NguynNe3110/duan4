import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order_request_entity.freezed.dart';

@freezed
sealed class CreateOrderRequestEntity with _$CreateOrderRequestEntity {
  const factory CreateOrderRequestEntity({
    required String userId,
    required double totalPrice,
    required String addressLine,
    String? paymentMethod,
    String? status,
    String? note,
  }) = _CreateOrderRequestEntity;
}