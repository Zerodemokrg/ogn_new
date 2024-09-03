import 'package:get/get.dart';
import '../models/models.dart';
import '../services/external/api.dart';


class DepartmentsController extends GetxController {
  var departments = <Department>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var selectedIndex = (-1).obs; // Изначально ничего не выбрано

  void selectDepartment(int index) {
    selectedIndex.value = index;
  }
  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchData() async {
    try {
      departments.value=await API.getDepartments();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}