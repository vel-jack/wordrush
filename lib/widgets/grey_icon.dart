import 'package:flutter/material.dart';

class GreyIcon extends StatelessWidget {
  const GreyIcon(this.icon,
      {super.key, this.size = 24.0, this.color = Colors.grey});
  final IconData icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size, color: color);
  }
}
