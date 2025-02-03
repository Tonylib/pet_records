import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/pet_records_app_bar.dart';
import '../controllers/test_results_controller.dart';
import '../widgets/test_status_filters.dart';
import '../widgets/test_results_list.dart';

class TestResultsPage extends GetView<TestResultsController> {
  static const String _title = 'Test Results';

  const TestResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PetRecordsAppBar(title: _title),
      body: Column(
        children: [
          TestStatusFilters(),
          Expanded(
            child: TestResultsList(),
          ),
        ],
      ),
    );
  }
}
