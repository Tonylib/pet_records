import 'package:flutter/material.dart';

class GreetingText extends StatelessWidget {
  static const String defaultText = 'Welcome to Pet Records';
  final String text;
  final TextStyle? style;

  const GreetingText({
    super.key,
    this.text = defaultText,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }
}
