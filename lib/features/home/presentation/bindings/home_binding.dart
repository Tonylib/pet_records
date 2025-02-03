import 'package:get/get.dart';
import '../../data/repositories/pet_records_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PetRecordsRepository());
  }
}
