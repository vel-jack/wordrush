import 'package:flutter/material.dart';
import 'package:wordrush/utils/constants.dart';

class GreyText extends StatelessWidget {
  const GreyText(this.text, {Key? key, this.isClicked = false, this.size = 28})
      : super(key: key);
  final String text;
  final bool isClicked;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: isClicked ? Colors.grey.shade400 : kDarkShadowColor,
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
    );
  }
}
