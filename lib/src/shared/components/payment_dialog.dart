import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:cupdelivery/src/config/custom_colors.dart';
import 'package:cupdelivery/src/models/order_model.dart';
import 'package:cupdelivery/src/services/utils_services.dart';
import 'package:cupdelivery/src/shared/components/custom_outline_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;
  PaymentDialog({
    Key? key,
    required this.order,
  }) : super(key: key);

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Conteúdo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Pagamento com PIX',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  // QR Code
                  QrImage(
                    data: order.qrCodeImage,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),

                  // Vencimento
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      'Vencimento: ${utilsServices.formatDateTime(DateTime.parse(order.due))}',
                      style: TextStyle(
                        fontSize: 16,
                        color: CustomColors.customSwatchColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Total
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      'Total do pedido: ${utilsServices.priceToCurrency(double.parse(order.total))}',
                      style: TextStyle(
                        fontSize: 16,
                        color: CustomColors.customSwatchColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Copiar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: CustomOutlineButton(
                      label: 'Copia e cola',
                      pressed: () {
                        FlutterClipboard.copy(order.copyAndPaste);
                        utilsServices.showToast(message: 'Código copiado');
                      },
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ));
  }
}
