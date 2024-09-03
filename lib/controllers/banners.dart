import 'package:get/get.dart';
import '../models/models.dart';
import '../services/external/api.dart';


class BannersController extends GetxController {
  var banners = <BannerSite>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchData() async {
    try {
      banners.value=await API.getBanners();
      banners.value=banners.where((element)=>element.workSite==true).toList();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}