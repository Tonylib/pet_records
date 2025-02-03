import 'package:flutter/material.dart';
import 'paw_icon.dart';
import 'greeting_text.dart';
import 'continue_button.dart';
import '../../../../core/constants/spacing.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PawIcon(),
        SizedBox(height: Spacing.sm),
        GreetingText(),
        SizedBox(height: Spacing.lg),
        ContinueButton(),
      ],
    );
  }
}
