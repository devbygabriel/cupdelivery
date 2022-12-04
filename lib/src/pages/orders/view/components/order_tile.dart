import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cupdelivery/src/config/custom_colors.dart';
import 'package:cupdelivery/src/models/cart_item_model.dart';
import 'package:cupdelivery/src/models/order_model.dart';
import 'package:cupdelivery/src/pages/orders/controller/order_controller.dart';
import 'package:cupdelivery/src/pages/orders/view/components/order_status_widget.dart';
import 'package:cupdelivery/src/services/utils_services.dart';
import 'package:cupdelivery/src/shared/components/custom_elevated_button.dart';
import 'package:cupdelivery/src/shared/components/payment_dialog.dart';

class OrderTail extends StatelessWidget {
  final OrderModel order;
  OrderTail({
    Key? key,
    required this.order,
  }) : super(key: key);

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: GetBuilder<OrderController>(
        init: OrderController(order),
        global: false,
        builder: (controller) {
          return ExpansionTile(
            onExpansionChanged: (value) {
              controller.getOrderItems();
            },
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pedido: ${order.id}'),
              ],
            ),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: controller.isLoading
                ? [
                    Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  ]
                : [
                    SizedBox(
                      height: 200,
                      // Lista de produtos
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: controller.order.items == null
                                ? Column()
                                : ListView(
                                    children: controller.order.items!
                                        .map((orderItem) {
                                      return _OrderItemWidget(
                                        utilsServices: utilsServices,
                                        orderItem: orderItem,
                                      );
                                    }).toList(),
                                  ),
                          ),

                          // Divisão
                          VerticalDivider(
                            color: Colors.grey.shade300,
                            thickness: 2,
                            width: 8,
                          ),

                          // Status do pedido
                          Expanded(
                            flex: 2,
                            child: OrderStatusWidget(
                              status: order.status,
                              isOverdue: DateTime.parse(order.due)
                                  .isBefore(DateTime.now()),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Total
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Total do pedido',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            utilsServices
                                .priceToCurrency(double.parse(order.total)),
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.customSwatchColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Botão de pagamento
                    Visibility(
                      visible:
                          order.status == 'pending_payment' && !order.isOverDue,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: CustomElevatedButton(
                          label: 'Ver QR Code PIX',
                          pressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return PaymentDialog(
                                  order: order,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
          );
        },
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilsServices,
    required this.orderItem,
  }) : super(key: key);

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Image.network(
            orderItem.picture,
            height: 32,
            width: 32,
          ),
          Expanded(
            child: Text(
              '${orderItem.title} ',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${orderItem.quantity} ${orderItem.unit}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 8,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3),
            child: Text(
              utilsServices.priceToCurrency(
                orderItem.totalPrice(),
              ),
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
