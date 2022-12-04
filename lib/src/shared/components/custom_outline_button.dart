import 'package:flutter/material.dart';
import 'package:cupdelivery/src/config/custom_colors.dart';

class CustomOutlineButton extends StatefulWidget {
  final String label;
  final Function() pressed;

  const CustomOutlineButton({
    Key? key,
    required this.label,
    required this.pressed,
  }) : super(key: key);

  @override
  State<CustomOutlineButton> createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          side: BorderSide(
            width: 2,
            color: CustomColors.customSwatchColor,
          ),
        ),
        onPressed: widget.pressed,
        child: Text(
          widget.label,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
