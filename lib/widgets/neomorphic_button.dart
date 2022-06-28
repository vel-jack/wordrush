import 'package:flutter/material.dart';
import 'package:wordrush/utils/constants.dart';

class NeomorphicButton extends StatelessWidget {
  const NeomorphicButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.isClicked,
    this.height = 80.0,
    this.width = 80.0,
    this.radius = 50.0,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? radius;
  final bool isClicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
          border: isClicked
              ? Border.all(
                  color: Colors.grey.shade300,
                  width: 5,
                )
              : null,
          color: kLightBgColor,
          boxShadow: isClicked
              ? null
              : [
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-10, -10),
                    blurRadius: 10,
                    spreadRadius: -4,
                  ),
                  BoxShadow(
                    color: kDarkShadowColor,
                    offset: const Offset(4, 4),
                    blurRadius: 10,
                    spreadRadius: -4,
                  ),
                ],
        ),
        child: child,
      ),
    );
  }
}
