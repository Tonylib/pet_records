import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/models/test_result.dart';
import '../../domain/models/pet.dart';
import '../controllers/test_results_controller.dart';
import '../pages/test_graph_page.dart';

class TestResultCard extends GetView<TestResultsController> {
  final TestResult test;
  final Pet pet;

  const TestResultCard({
    super.key,
    required this.test,
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: _buildResultCard(context),
    );
  }

  Widget _buildResultCard(BuildContext context) {
    return InkWell(
      onTap: test.hasHistoricalData
          ? () => Get.to(() => TestGraphPage(testResult: test))
          : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPetInfo(context),
            const SizedBox(height: 12),
            _buildTestInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPetInfo(BuildContext context) {
    return Row(
      children: [
        _buildPetIcon(),
        const SizedBox(width: 8),
        Expanded(
          child: _buildPetDetails(context),
        ),
        _buildTestResult(),
      ],
    );
  }

  Widget _buildPetIcon() {
    return const Icon(Icons.pets, size: 24);
  }

  Widget _buildPetDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pet.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          '${pet.species} • ${pet.breed}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildTestResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            if (test.hasHistoricalData) _buildGraphIcon(),
            _buildStatus(),
          ],
        ),
      ],
    );
  }

  Widget _buildGraphIcon() {
    return const Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: Icon(Icons.show_chart, color: Colors.blue),
    );
  }

  Widget _buildStatus() {
    return Text(
      test.currentStatus?.type == TestStatusType.processing
          ? 'Pending'
          : test.result,
      style: TextStyle(
        color: test.currentStatus?.type == TestStatusType.processing
            ? Colors.orange
            : controller.getResultColor(test.result),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTestInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildTestDetails(context),
        ),
        if (test.currentStatus != null) _buildStatusChip(),
      ],
    );
  }

  Widget _buildTestDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTestName(context),
        const SizedBox(height: 4),
        _buildTestMetadata(context),
      ],
    );
  }

  Widget _buildTestName(BuildContext context) {
    return Text(
      test.testName,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 20,
          ),
    );
  }

  Widget _buildTestMetadata(BuildContext context) {
    return Text(
      '${test.value} ${test.unit} • ${test.date.toString().split(' ')[0]}',
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildStatusChip() {
    return Transform.scale(
      scale: 0.85,
      child: Chip(
        label: Text(
          test.currentStatus!.type.name.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        backgroundColor: test.currentStatus!.type.color,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
