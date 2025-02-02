import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/models/test_result.dart';
import '../pages/test_graph_page.dart';

class TestResultCard extends StatelessWidget {
  final TestResult testResult;

  const TestResultCard({
    super.key,
    required this.testResult,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => Get.to(() => TestGraphPage(testResult: testResult)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    testResult.testName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    testResult.date.toString().split(' ')[0],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${testResult.value} ${testResult.unit}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    testResult.result,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: _getResultColor(testResult.result),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Range: ${testResult.minRange} - ${testResult.maxRange} ${testResult.unit}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Veterinarian: ${testResult.veterinarian}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (testResult.currentStatus != null) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Chip(
                      label: Text(
                        testResult.currentStatus!.type.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: testResult.currentStatus!.type.color,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getResultColor(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return Colors.green;
      case 'high':
        return Colors.orange;
      case 'low':
        return Colors.orange;
      case 'dangerous':
        return Colors.red;
      case 'negative':
        return Colors.green;
      case 'positive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
