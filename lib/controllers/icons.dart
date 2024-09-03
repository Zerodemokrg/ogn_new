import 'package:get/get.dart';
import '../models/models.dart';
import '../services/external/api.dart';


class IconsController extends GetxController {
  var icons = <IconSite>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchData() async {
    try {
      icons.value=await API.getIcons();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}