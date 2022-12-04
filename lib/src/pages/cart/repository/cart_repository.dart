import 'package:cupdelivery/src/constants/endpoints.dart';
import 'package:cupdelivery/src/models/cart_item_model.dart';
import 'package:cupdelivery/src/models/order_model.dart';
import 'package:cupdelivery/src/pages/cart/result/cart_result.dart';
import 'package:cupdelivery/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems(
      {required int userId}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItems + userId.toString(),
      method: HttpMethods.get,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromMap)
              .toList();

      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult.error(
          'Ocorreu um erro ao recuperar os itens do carrinho');
    }
  }

  Future<CartResult<OrderModel>> checkoutCart({
    required int userId,
    required double total,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.checkout,
        method: HttpMethods.post,
        headers: {
          'Authorization': 'Bearer $token'
        },
        body: {
          'customer_id': userId,
          'total': total,
        });

    if (result['id'] != null) {
      final order = OrderModel.fromMap(result.cast());
      return CartResult<OrderModel>.success(order);
    } else {
      return CartResult.error('Não foi possível realizar o pedido');
    }
  }

  Future<CartResult<int>> addItemToCart({
    required int userId,
    required int quantity,
    required int productId,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.addItemToCart,
        method: HttpMethods.post,
        headers: {
          'Authorization': 'Bearer $token'
        },
        body: {
          'quantity': quantity,
          'item': productId,
          'customer_id': userId,
        });

    if (result['id'] != null) {
      return CartResult<int>.success(result['id']);
    } else {
      return CartResult.error('Erro ao adicionar produto no carrinho');
    }
  }

  Future<bool> changeItemQuantity({
    required int id,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.changeItemQuantity,
        method: HttpMethods.put,
        headers: {
          'Authorization': 'Bearer $token'
        },
        body: {
          'id': id,
          'quantity': quantity,
        });

    if (result['message'] != null) {
      return true;
    } else {
      return false;
    }
  }
}
