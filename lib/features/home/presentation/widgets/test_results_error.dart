import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/test_results_controller.dart';

class TestResultsError extends GetView<TestResultsController> {
  const TestResultsError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildErrorIcon(),
          const SizedBox(height: 16),
          _buildErrorTitle(context),
          const SizedBox(height: 8),
          _buildErrorMessage(context),
          const SizedBox(height: 16),
          _buildRetryButton(),
        ],
      ),
    );
  }

  Widget _buildErrorIcon() {
    return const Icon(
      Icons.error_outline,
      size: 48,
      color: Colors.red,
    );
  }

  Widget _buildErrorTitle(BuildContext context) {
    return Text(
      'Error loading data',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _buildErrorMessage(BuildContext context) {
    return Text(
      controller.testResultsData.error.value,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildRetryButton() {
    return ElevatedButton.icon(
      onPressed: () => controller.loadData(),
      icon: const Icon(Icons.refresh),
      label: const Text('Retry'),
    );
  }
}
