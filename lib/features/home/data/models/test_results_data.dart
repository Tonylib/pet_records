import 'package:get/get.dart';
import '../../../../core/data/base_data.dart';
import '../../domain/models/test_result.dart';
import '../../domain/models/pet.dart';

class TestResultsData extends BaseData<List<TestResult>> {
  final RxMap<String, Pet> petsCache = <String, Pet>{}.obs;
  final Rxn<TestStatusType> selectedStatus = Rxn<TestStatusType>();

  TestResultsData() : super(initialData: []);

  List<TestResult> get filteredTests {
    if (data.value == null) return [];
    if (selectedStatus.value == null) return data.value!;
    return data.value!
        .where((test) => test.currentStatus?.type == selectedStatus.value)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
}
