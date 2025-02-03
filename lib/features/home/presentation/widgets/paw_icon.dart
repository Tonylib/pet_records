import 'package:flutter/material.dart';

class PawIcon extends StatelessWidget {
  static const double defaultSize = 120;
  final double size;
  final Color? color;

  const PawIcon({
    super.key,
    this.size = defaultSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.pets,
      size: size,
      color: color ?? Theme.of(context).colorScheme.primary,
    );
  }
}
