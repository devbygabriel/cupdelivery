import 'package:flutter/material.dart';

class CustomBackButton extends StatefulWidget {
  final bool isWhitePage;
  const CustomBackButton({
    Key? key,
    this.isWhitePage = false,
  }) : super(key: key);

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: 10,
      child: SafeArea(
        child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: widget.isWhitePage ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
