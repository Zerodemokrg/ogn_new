import 'package:get/get.dart';
import '../models/models.dart';
import '../services/external/api.dart';


class StickersController extends GetxController {
  var stickers = <Sticker>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchData() async {
    try {
      stickers.value=await API.getStickers();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}