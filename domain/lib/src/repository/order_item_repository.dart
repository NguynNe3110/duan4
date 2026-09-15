import 'package:domain/domain.dart';

abstract class OrderItemRepository {
  Future<List<OrderItemEntity>> getOrderItems({required String orderId});
  Future<OrderItemEntity> getOrderItemById({required String id});
  Future<void> createOrderItems({required List<OrderItemEntity> data});
}
