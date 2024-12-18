import 'dart:convert';

import 'package:get/get.dart';

import '../models/models.dart';
import '../services/external/api.dart';

class RecommendationsController extends GetxController {
  var recommendation = <Recommendation>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchData() async {
    try {
      print("loading is ${isLoading}");
      List<Recommendation> fetchedRecommendations = await API.getRecommendatios();
      recommendation.value = fetchedRecommendations;
      print("loading is ${isLoading}");
      print(jsonEncode(recommendation.first));
    } catch (e) {
      print(e);
      errorMessage.value = e.toString();
    } finally {
      print("loading is ${isLoading}");
      isLoading.value = false;
      print("loading is ${isLoading}");
    }
  }
}