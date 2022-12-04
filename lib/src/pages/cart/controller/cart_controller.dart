import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cupdelivery/src/models/cart_item_model.dart';
import 'package:cupdelivery/src/models/item_model.dart';
import 'package:cupdelivery/src/models/order_model.dart';
import 'package:cupdelivery/src/pages/auth/controller/auth_controller.dart';
import 'package:cupdelivery/src/pages/cart/repository/cart_repository.dart';
import 'package:cupdelivery/src/pages/cart/result/cart_result.dart';
import 'package:cupdelivery/src/services/utils_services.dart';
import 'package:cupdelivery/src/shared/components/payment_dialog.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  List<CartItemModel> cartItems = [];

  bool isCheckoutLoading = false;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;

    for (var item in cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  int getCartTotalItems() {
    return cartItems.isEmpty
        ? 0
        : cartItems.map((e) => e.quantity).reduce((a, b) => a + b);
  }

  void setCheckoutLoading(bool value) {
    isCheckoutLoading = value;
    update();
  }

  Future<void> checkoutCart() async {
    setCheckoutLoading(true);

    CartResult<OrderModel> result = await cartRepository.checkoutCart(
      userId: authController.user.id!,
      total: cartTotalPrice(),
    );

    setCheckoutLoading(false);

    result.when(success: (order) {
      cartItems.clear();
      update();

      showDialog(
        context: Get.context!,
        builder: (_) {
          return PaymentDialog(
            order: order,
          );
        },
      );
    }, error: (message) {
      utilsServices.showToast(
        message: message,
      );
    });
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      userId: authController.user.id!,
    );

    result.when(success: (data) {
      cartItems = data;
      update();
    }, error: (message) {
      utilsServices.showToast(
        message: message,
        isError: true,
      );
    });
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.changeItemQuantity(
      id: item.id,
      quantity: quantity,
    );

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }

      update();
    } else {
      utilsServices.showToast(
        message: 'Ocorreu um erro ao atualizar o item do carrinho',
        isError: true,
      );
    }

    return result;
  }

  int getItemIndex(searchItemId) {
    return cartItems
        .indexWhere((itemInList) => itemInList.item == searchItemId);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item.id);

    if (itemIndex >= 0) {
      // Existe na listagem
      final product = cartItems[itemIndex];
      await changeItemQuantity(
        item: product,
        quantity: (product.quantity + quantity),
      );
    } else {
      // Não existe na listagem
      final CartResult<int> result = await cartRepository.addItemToCart(
        userId: authController.user.id!,
        quantity: quantity,
        productId: item.id,
      );

      result.when(
        success: (cartItemId) {
          cartItems.add(
            CartItemModel(
              id: cartItemId,
              quantity: quantity,
              item: item.id,
              title: item.title,
              description: item.description,
              price: item.price,
              unit: item.unit,
              picture: item.picture,
            ),
          );
          update();
        },
        error: (message) {
          utilsServices.showToast(
            message: message,
            isError: true,
          );
        },
      );
    }
  }
}
