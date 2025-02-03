import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/models/test_result.dart';
import '../controllers/test_results_controller.dart';

class TestStatusFilters extends GetView<TestResultsController> {
  const TestStatusFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Obx(() => Row(
            children: [
              _buildAllFilterChip(),
              ..._buildStatusFilterChips(),
            ],
          )),
    );
  }

  Widget _buildAllFilterChip() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: const Text('ALL'),
        selected: controller.testResultsData.selectedStatus.value == null,
        onSelected: (selected) {
          controller.setSelectedStatus(null);
        },
      ),
    );
  }

  List<Widget> _buildStatusFilterChips() {
    return TestStatusType.values
        .map((status) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(
                  status.name.toUpperCase(),
                  style: TextStyle(
                    color: controller.testResultsData.selectedStatus.value ==
                            status
                        ? Colors.white
                        : null,
                  ),
                ),
                selected:
                    controller.testResultsData.selectedStatus.value == status,
                selectedColor: status.color,
                checkmarkColor: Colors.white,
                onSelected: (selected) {
                  controller.setSelectedStatus(selected ? status : null);
                },
              ),
            ))
        .toList();
  }
}
