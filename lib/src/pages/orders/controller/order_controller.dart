import 'package:get/get.dart';
import 'package:cupdelivery/src/models/cart_item_model.dart';
import 'package:cupdelivery/src/models/order_model.dart';
import 'package:cupdelivery/src/pages/auth/controller/auth_controller.dart';
import 'package:cupdelivery/src/pages/orders/repository/orders_repository.dart';
import 'package:cupdelivery/src/pages/orders/result/orders_result.dart';
import 'package:cupdelivery/src/services/utils_services.dart';

class OrderController extends GetxController {
  OrderModel order;
  OrderController(this.order);

  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);

    final OrdersResult<List<CartItemModel>> result =
        await ordersRepository.getOrderItems(orderId: order.id);

    setLoading(false);

    result.when(success: (items) {
      order.items = items;
      update();
    }, erro: (message) {
      utilsServices.showToast(
        message: message,
        isError: true,
      );
    });
  }
}
