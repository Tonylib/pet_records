import 'package:get/get.dart';

/// Base data class for managing state with loading, data, and error states
class BaseData<T> {
  Rx<T?> data;
  RxBool loading;
  RxString error;

  BaseData({
    T? initialData,
    bool initialLoading = true,
    String initialError = '',
  })  : data = Rx<T?>(initialData),
        loading = initialLoading.obs,
        error = initialError.obs;
}
