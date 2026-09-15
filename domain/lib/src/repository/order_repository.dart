import 'package:domain/domain.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getOrders({required String userId});
  Future<OrderEntity> getOrderById({required String id});

  Future<List<OrderEntity>> getOrderHistory({required String userId, int page = 0, int limit = 20});

  Future<void> createOrder({
    required CreateOrderRequestEntity orderData,
    required List<OrderItemEntity> orderItems,
  });
}
