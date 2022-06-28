import 'package:flutter/material.dart';
import 'package:wordrush/utils/constants.dart';

class NeomorphicProgress extends StatelessWidget {
  const NeomorphicProgress({Key? key, this.value = 0.0, this.size = 200})
      : super(key: key);
  final double value;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kLightBgColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(5, 5),
              color: kDarkShadowColor,
              blurRadius: 8,
              spreadRadius: -4,
            ),
            const BoxShadow(
              offset: Offset(-10, -10),
              color: Colors.white,
              blurRadius: 10,
            )
          ]),
      child: CircularProgressIndicator(
        value: value,
        color: kDarkShadowColor,
        backgroundColor: Colors.grey.shade100,
        strokeWidth: 8,
      ),
    );
  }
}
