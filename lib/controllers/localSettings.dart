import 'package:get/get.dart';


class LocalSettingsController extends GetxController {
  List<String> languages=["RU","KZ","EN"];
  var selectLanguage="".obs;
  List<String> orderTypes=["delivery","pickup","inside"];
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData(){
    selectLanguage.value=languages.first;
  }
  changeLanguage(String language){
    selectLanguage.value=language;
  }
}