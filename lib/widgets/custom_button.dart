import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double fontSize;
  final EdgeInsets padding;
  final ShapeBorder shape;
  final bool isLoading;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.padding = const EdgeInsets.all(12.0),
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isLoading ? null : onPressed,
      color: color,
      textColor: textColor,
      padding: padding,
      shape: shape,
      disabledColor: color.withOpacity(0.5),
      child: isLoading
          ? SizedBox(
              width: 24.0,
              height: 24.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(textColor),
                strokeWidth: 2.0,
              ),
            )
          : Text(
              text,
              style: TextStyle(fontSize: fontSize),
            ),
    );
  }
}
