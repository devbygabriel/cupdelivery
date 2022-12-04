import 'package:flutter/material.dart';
import 'package:cupdelivery/src/config/custom_colors.dart';

class AppNameWidget extends StatelessWidget {
  final Color? titleColor;
  final double textSize;

  const AppNameWidget({
    Key? key,
    this.titleColor,
    this.textSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: textSize,
        ),
        children: [
          TextSpan(
            text: 'Cup',
            style: TextStyle(
              color: CustomColors.customContrastColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Delivery',
            style: TextStyle(
              color: titleColor ?? CustomColors.customSwatchColor,
            ),
          ),
        ],
      ),
    );
  }
}
