import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/repositories/pet_records_repository.dart';
import '../../data/models/test_results_data.dart';
import '../../domain/models/test_result.dart';

class TestResultsController extends GetxController {
  final repository = Get.find<PetRecordsRepository>();
  final testResultsData = TestResultsData();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    testResultsData.loading.value = true;
    testResultsData.error.value = '';

    try {
      final results = await repository.getAllTestResults();
      // Load all pets data
      for (final test in results) {
        if (!testResultsData.petsCache.containsKey(test.petId)) {
          testResultsData.petsCache[test.petId] =
              await repository.getPetById(test.petId);
        }
      }
      testResultsData.data.value = results;
    } catch (e) {
      testResultsData.error.value = e.toString();
      if (!Get.testMode) {
        Get.snackbar(
          'Error',
          'Error loading data: ${e.toString()}',
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      }
    } finally {
      testResultsData.loading.value = false;
    }
  }

  void setSelectedStatus(TestStatusType? status) {
    testResultsData.selectedStatus.value = status;
  }

  Color getResultColor(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return Get.theme.colorScheme.primary;
      case 'high':
      case 'low':
        return Colors.orange;
      case 'dangerous':
        return Get.theme.colorScheme.error;
      case 'negative':
        return Get.theme.colorScheme.primary;
      case 'positive':
        return Get.theme.colorScheme.error;
      default:
        return Get.theme.colorScheme.outline;
    }
  }
}
