import 'dart:convert';

import 'package:get/get.dart';

import '../models/models.dart';
import '../services/external/api.dart';

class OrganizationController extends GetxController {
  var organizations = <Organization>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchData() async {
    try {
    List<Organization> fetchedOrganizations = await API.getOrganizations();
      organizations.value = fetchedOrganizations;
      print(jsonEncode(organizations.first));
    } catch (e) {
      print(e);
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}