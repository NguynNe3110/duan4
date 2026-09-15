import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../data.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl extends OrderRepository {
  final OrderSupabaseService _orderSupabaseService;
  final OrderItemSupabaseService _orderItemSupabaseService;
  final OrderMapper _orderMapper;

  OrderRepositoryImpl(this._orderMapper, this._orderSupabaseService, this._orderItemSupabaseService);

  @override
  Future<List<OrderEntity>> getOrders({required String userId}) async {
    final dtos = await _orderSupabaseService.getOrders(userId: userId);
    return _orderMapper.mapToListEntity(dtos);
  }

  @override
  Future<OrderEntity> getOrderById({required String id}) async {
    final dto = await _orderSupabaseService.getOrderById(id: id);
    return _orderMapper.mapToEntity(dto);
  }

  @override
  Future<List<OrderEntity>> getOrderHistory({required String userId, int page = 0, int limit = 20}) async {
    // ponytail: pagination not implemented, returns all. Add when needed.
    return getOrders(userId: userId);
  }

  @override
  Future<void> createOrder({
    required CreateOrderRequestEntity orderData,
    required List<OrderItemEntity> orderItems,
  }) async {
    final orderDto = _orderMapper.mapToDto(orderData);
    final responseDto = await _orderSupabaseService.createOrder(data: orderDto.toJson());
    final orderId = responseDto.id;

    final orderItemDtos = orderItems.map((item) {
      final dto = _orderMapper.mapOrderItemToDto(item);
      return dto.copyWith(orderId: orderId).toJson();
    }).toList();

    await _orderItemSupabaseService.createOrderItems(data: orderItemDtos);
  }
}