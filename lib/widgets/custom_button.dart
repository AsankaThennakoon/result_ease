import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onClick;
  final String label;
  final Color color;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomButton({
    Key? key,
    required this.onClick,
    required this.label,
    required this.color,
    this.width = 125,
    this.height = 50,
    this.borderRadius = 25.0,
    this.margin,
    this.padding,
    this.fontSize = 20.0,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ElevatedButton(
        onPressed: onClick,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              padding ?? const EdgeInsets.all(10.0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
