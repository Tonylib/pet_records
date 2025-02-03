import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/test_results_controller.dart';
import 'test_result_card.dart';
import 'test_result_card_shimmer.dart';
import 'test_results_error.dart';

class TestResultsList extends GetView<TestResultsController> {
  const TestResultsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.testResultsData.loading.value) {
        return _buildLoadingShimmer();
      }

      if (controller.testResultsData.error.value.isNotEmpty) {
        return _buildErrorWidget();
      }

      return _buildTestResultsList();
    });
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return const TestResultCardShimmer();
      },
    );
  }

  Widget _buildErrorWidget() {
    return const TestResultsError();
  }

  Widget _buildTestResultsList() {
    final filteredTests = controller.testResultsData.filteredTests;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredTests.length,
      itemBuilder: (context, index) {
        final test = filteredTests[index];
        final pet = controller.testResultsData.petsCache[test.petId]!;
        return TestResultCard(test: test, pet: pet);
      },
    );
  }
}
