import 'package:flutter/material.dart';
import 'package:wordrush/utils/constants.dart';

/// GreyText StatelessWidget is customized grey text with [FontWeight.bold],
/// two grey shades and [TextAlign.center] align
///
class GreyText extends StatelessWidget {
  const GreyText(this.text, {super.key, this.isDown = false, this.size = 28});

  /// Requires String text to display
  final String text;

  /// To changed the shades based on clicked state
  final bool isDown;

  /// Size of the text
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isDown ? Colors.grey.shade400 : kDarkShadowColor,
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
    );
  }
}
