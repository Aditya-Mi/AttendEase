import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final bool isVertical;
  final Color color;
  final double width;
  const CustomDivider(
      {super.key,
      this.isVertical = false,
      required this.color,
      this.width = 1});

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? Container(
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: color),
          )
        : Container(
            height: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: color),
          );
  }
}
