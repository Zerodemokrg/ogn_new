import 'package:get/get.dart';
import '../main.dart';
import '../models/models.dart';
import '../services/external/api.dart';


class MenuController extends GetxController {
  var menu = Menu(groups: [], products: []).obs;
  var recommendations=<Recommendation>[].obs;
  var selectedCategoryGuid=''.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var deliveriesProducts=["c7ae506d-cbee-46e9-a59f-69930ef526d4","ae3d69d9-47fc-4361-90fd-e7c98dcf85e2","4592308c-0d23-4b71-9880-999d88146bf9","e5d0a3df-b13b-47a9-b870-e7d64491725f","04963870-bcdf-46ef-94b7-985dd24639ab"].obs;
  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchData() async {
    try {
      menu.value=await API.getMenu();
      selectedCategoryGuid.value=menu.value.groups.where((element)=>element.enabled==true).first.guidId;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  String getGroupNameFilteredByLanguage(String guid){
    String result=menu.value.groups.firstWhere((element) => element.guidId==guid).name;
    print("name is${result}");
    if (localSettingsController.selectLanguage.value=="RU"){
      return result;
    }
    if (localSettingsController.selectLanguage.value=="KZ" && menu.value.groups.firstWhere((element) => element.guidId==guid).nameQaz !=null && menu.value.groups.firstWhere((element) => element.guidId==guid).nameQaz!="" && menu.value.groups.firstWhere((element) => element.guidId==guid).nameQaz!=" "){
      return menu.value.groups.firstWhere((element) => element.guidId==guid).nameQaz;
    }
    if (localSettingsController.selectLanguage.value=="EN" && menu.value.groups.firstWhere((element) => element.guidId==guid).nameEnglish!=null && menu.value.groups.firstWhere((element) => element.guidId==guid).nameEnglish!="" && menu.value.groups.firstWhere((element) => element.guidId==guid).nameEnglish!=" "){
      return menu.value.groups.firstWhere((element) => element.guidId==guid).nameEnglish;
    }
    return result;
  }
  String getProductNameFilteredByLanguage(String guid){
    String result=menu.value.products.firstWhere((element) => element.guidId==guid).name;
    if (localSettingsController.selectLanguage.value=="RU"){
      return result;
    }
    if (localSettingsController.selectLanguage.value=="KZ" && menu.value.products.firstWhere((element) => element.guidId==guid).nameQaz!=null && menu.value.products.firstWhere((element) => element.guidId==guid).nameQaz!="" && menu.value.products.firstWhere((element) => element.guidId==guid).nameQaz!=" "){
      return menu.value.products.firstWhere((element) => element.guidId==guid).nameQaz;
    }
    if (localSettingsController.selectLanguage.value=="EN" && menu.value.products.firstWhere((element) => element.guidId==guid).nameEnglish!=null && menu.value.products.firstWhere((element) => element.guidId==guid).nameEnglish!="" && menu.value.products.firstWhere((element) => element.guidId==guid).nameEnglish!=" "){
      return menu.value.products.firstWhere((element) => element.guidId==guid).nameEnglish;
    }
    return result;
  }
  String getProductDescriptionFilteredByLanguage(String guid){
    String result=menu.value.products.firstWhere((element) => element.guidId==guid).description;
    if (localSettingsController.selectLanguage.value=="RU"){
      return result;
    }
    if (localSettingsController.selectLanguage.value=="KZ" && menu.value.products.firstWhere((element) => element.guidId==guid).descriptionQaz!=null && menu.value.products.firstWhere((element) => element.guidId==guid).descriptionQaz!="" && menu.value.products.firstWhere((element) => element.guidId==guid).descriptionQaz!=" "){
      return menu.value.products.firstWhere((element) => element.guidId==guid).descriptionQaz;
    }
    if (localSettingsController.selectLanguage.value=="EN" && menu.value.products.firstWhere((element) => element.guidId==guid).descriptionEnglish!=null && menu.value.products.firstWhere((element) => element.guidId==guid).descriptionEnglish!="" && menu.value.products.firstWhere((element) => element.guidId==guid).descriptionEnglish!=" "){
      return menu.value.products.firstWhere((element) => element.guidId==guid).descriptionEnglish;
    }
    return result;
  }
}