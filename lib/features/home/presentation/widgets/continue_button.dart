import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/test_results_page.dart';
import '../bindings/test_results_binding.dart';

class ContinueButton extends StatelessWidget {
  static const String defaultLabel = 'Continue';
  static const double width = 32;
  static const double height = 16;
  static const int fadeOutDuration = 500;

  final VoidCallback? onPressed;
  final String label;
  final EdgeInsetsGeometry? padding;

  const ContinueButton({
    super.key,
    this.onPressed,
    this.label = defaultLabel,
    this.padding = const EdgeInsets.symmetric(
      horizontal: width,
      vertical: height,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? _defaultOnPressed,
      icon: const Icon(Icons.arrow_forward),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: padding,
      ),
    );
  }

  void _defaultOnPressed() {
    Get.to(
      () => const TestResultsPage(),
      binding: TestResultsBinding(),
      transition: Transition.fade,
      duration: const Duration(milliseconds: fadeOutDuration),
    );
  }
}
