import 'package:get/get.dart';
import '../controllers/test_results_controller.dart';

class TestResultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TestResultsController());
  }
}
