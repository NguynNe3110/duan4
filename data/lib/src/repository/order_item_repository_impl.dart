import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../data.dart';

@LazySingleton(as: OrderItemRepository)
class OrderItemRepositoryImpl extends OrderItemRepository {
  final OrderItemSupabaseService _orderItemSupabaseService;
  final OrderItemMapper _orderItemMapper;
  final OrderMapper _orderMapper;

  OrderItemRepositoryImpl(this._orderItemMapper, this._orderItemSupabaseService, this._orderMapper);

  @override
  Future<List<OrderItemEntity>> getOrderItems({required String orderId}) async {
    final dtos = await _orderItemSupabaseService.getOrderItems(orderId: orderId);
    return _orderItemMapper.mapToListEntity(dtos);
  }

  @override
  Future<OrderItemEntity> getOrderItemById({required String id}) async {
    final dto = await _orderItemSupabaseService.getOrderItemById(id: id);
    return _orderItemMapper.mapToEntity(dto);
  }

  @override
  Future<void> createOrderItems({required List<OrderItemEntity> data}) async {
    final dtos = data.map((e) => _orderMapper.mapOrderItemToDto(e).toJson()).toList();
    await _orderItemSupabaseService.createOrderItems(data: dtos);
  }
}