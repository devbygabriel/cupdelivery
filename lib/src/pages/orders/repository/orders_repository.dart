import 'package:cupdelivery/src/constants/endpoints.dart';
import 'package:cupdelivery/src/models/cart_item_model.dart';
import 'package:cupdelivery/src/models/order_model.dart';
import 'package:cupdelivery/src/pages/orders/result/orders_result.dart';
import 'package:cupdelivery/src/services/http_manager.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<CartItemModel>>> getOrderItems(
      {required int orderId}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getOrderItems + orderId.toString(),
      method: HttpMethods.get,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (result['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromMap)
              .toList();

      return OrdersResult<List<CartItemModel>>.success(items);
    } else {
      return OrdersResult.erro(
          'Não foi possível recuperar os produtos do pedido');
    }
  }

  Future<OrdersResult<List<OrderModel>>> getAllOrders(
      {required int userId}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllOrders + userId.toString(),
      method: HttpMethods.get,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromMap)
              .toList();

      return OrdersResult<List<OrderModel>>.success(orders);
    } else {
      return OrdersResult.erro('Não foi possível recuperar os pedidos');
    }
  }
}
