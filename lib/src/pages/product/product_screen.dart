import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cupdelivery/src/pages/base/controller/navigation_controller.dart';
import 'package:cupdelivery/src/pages/cart/controller/cart_controller.dart';
import 'package:cupdelivery/src/shared/components/custom_back_button.dart';
import 'package:cupdelivery/src/shared/components/quantity_widget.dart';
import 'package:cupdelivery/src/config/custom_colors.dart';
import 'package:cupdelivery/src/models/item_model.dart';
import 'package:cupdelivery/src/services/utils_services.dart';

class ProductScreen extends StatefulWidget {
  final ItemModel item = Get.arguments;
  ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UtilsServices utilsServices = UtilsServices();

  int cartItemQuantity = 1;

  final cartController = Get.find<CartController>();
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          // Conteúdo do produto
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: widget.item.picture,
                  child: Image.network(widget.item.picture),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Nome / Quantidade
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.item.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          QuantityWidget(
                            value: cartItemQuantity,
                            result: (quantity) {
                              setState(() {
                                cartItemQuantity = quantity;
                              });
                            },
                          ),
                        ],
                      ),

                      // Preço / Medida
                      Row(
                        children: [
                          Text(
                            utilsServices.priceToCurrency(
                                double.parse(widget.item.price)),
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.customSwatchColor,
                            ),
                          ),
                          Text(
                            '/${widget.item.unit}',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),

                      // Descrição
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            child: Text(
                              widget.item.description,
                              style: const TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Botão adicionar
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: () {
                            // Fechar
                            Get.back();
                            // Adicionar
                            cartController.addItemToCart(
                                item: widget.item, quantity: cartItemQuantity);
                            // Carrinho
                            navigationController
                                .navigatePageView(NavigationTabs.cart);
                          },
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Adicionar',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Text(
                                utilsServices.priceToCurrency(
                                  double.parse(widget.item.price) *
                                      cartItemQuantity,
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Botão de voltar
          const CustomBackButton(isWhitePage: true),
        ],
      ),
    );
  }
}
