import 'package:flutter/material.dart';
import 'package:wordrush/utils/constants.dart';

class NeomorphicButton extends StatelessWidget {
  const NeomorphicButton({
    super.key,
    required this.child,
    this.onPressed,
    this.size = 80.0,
    this.isClicked = false,
    this.radius = 100.0,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final double size;
  final bool isClicked;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        width: size,
        height: size,
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
