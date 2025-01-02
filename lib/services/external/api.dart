import 'dart:convert';
import 'dart:io';

import '../../configs/urls.dart';
import '../../models/models.dart';
import 'package:http/http.dart' as http;

class API{
  static Future<dynamic> postAppeal(Appeal request, String restUrl) async {
    final response = await http.post(
      Uri.parse(restUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data is int && data > 0) {
        return true;
      } else {
        return data;
      }
    } else {
      throw Exception('Failed to post appeal');
    }
  }

  static Future<List<AddressItem>>getAddressNames(String s) async{

    http.Response response = await http.get(
        Uri.parse(MainConfig().getAddressNames+Uri.encodeComponent(s)), //url
        headers: {"Accept": "application/json"});
    print("status code is ${response.statusCode}");
    print( jsonEncode(response.body));
    if (response.statusCode == 200) {

      List<AddressItem>? request;
      request = (json.decode(response.body) as List)
          .map((i) => AddressItem.fromJson(i)).toList();
      return  request;
    } else {
      throw Exception('Failed to load AddressItems');
    }
  }

  static Future<int> postCalculateDistance(CalculateDistanceRequest request, String restUrl) async {
    final response = await http.post(
      Uri.parse(restUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      int data = json.decode(response.body);

      return data;
    } else {
      return -1;
    }
  }

  static Future<Menu>getMenu() async{
    http.Response response = await http.get(
        Uri.parse(MainConfig().getMenuUrl), //url
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      Menu request;
      request = Menu.fromJson((json.decode(response.body)));
      print(request);
      return  request;
    } else {
      throw Exception('Failed to load MENU');
    }
  }
  static Future<List<Recommendation>>getRecommendatios() async{
    http.Response response = await http.get(
        Uri.parse(MainConfig().getRecommendationsUrl), //url
        headers: {"Accept": "application/json"});

    print("response status:${response.statusCode}");
    if (response.statusCode == 200) {
      List<Recommendation> request=[];
      if (json.decode(response.body) !=null){
        request = (json.decode(response.body) as List)
            .map((i) => Recommendation.fromJson(i)).toList();
      }
      return  request;
    } else {
      throw Exception('Failed to load Banners');
    }
  }

  static Future<List<BannerSite>>getBanners() async{
    http.Response response = await http.get(
        Uri.parse(MainConfig().getBannersUrl), //url
        headers: {"Accept": "application/json"});

    print("response status:${response.statusCode}");
    if (response.statusCode == 200) {
      List<BannerSite> request=[];
      if (json.decode(response.body) !=null){
        request = (json.decode(response.body) as List)
            .map((i) => BannerSite.fromJson(i)).toList();
      }
      return  request;
    } else {
      throw Exception('Failed to load Banners');
    }
  }
  static Future<List<Sticker>>getStickers() async{
    http.Response response = await http.get(
        Uri.parse(MainConfig().getStickersUrl), //url
        headers: {"Accept": "application/json"});

    print("response status:${response.statusCode}");
    if (response.statusCode == 200) {
      List<Sticker> request=[];
      if (json.decode(response.body) !=null){
        request = (json.decode(response.body) as List)
            .map((i) => Sticker.fromJson(i)).toList();
      }
      return  request;
    } else {
      throw Exception('Failed to load Stickers');
    }
  }
  static Future<List<IconSite>>getIcons() async{
    http.Response response = await http.get(
        Uri.parse(MainConfig().getIconsUrl), //url
        headers: {"Accept": "application/json"});

    print("response status:${response.statusCode}");
    if (response.statusCode == 200) {
      List<IconSite> request=[];
      if (json.decode(response.body) !=null){
        request = (json.decode(response.body) as List)
            .map((i) => IconSite.fromJson(i)).toList();
      }
      return  request;
    } else {
      throw Exception('Failed to load Icons');
    }
  }
  static Future<List<Department>>getDepartments() async{
    http.Response response = await http.get(
        Uri.parse(MainConfig().getDepartmentsUrl), //url
        headers: {"Accept": "application/json"});

    print("response status:${response.statusCode}");
    if (response.statusCode == 200) {
      List<Department> request=[];
      if (json.decode(response.body) !=null){
        request = (json.decode(response.body) as List)
            .map((i) => Department.fromJson(i)).toList();
      }
      return  request;
    } else {
      throw Exception('Failed to load getDepartments');
    }
  }
  static Future<List<Organization>> getOrganizations() async {
    http.Response response = await http.get(
        Uri.parse(MainConfig().getOrganizationsUrl), //url
        headers: {"Accept": "application/json"});

    print("response status:${response.statusCode}");
    if (response.statusCode == 200) {
      List<Organization> request=[];
      if (json.decode(response.body) !=null){
        request = (json.decode(response.body) as List)
            .map((i) => Organization.fromJson(i)).toList();
      }
      return  request;
    } else {
      throw Exception('Failed to load Banners');
    }
  }
  static Future<List<Schedule>>getSchedules() async{
    http.Response response = await http.get(
        Uri.parse(MainConfig().getScheduleUrl), //url
        headers: {"Accept": "application/json"});

    print("response status:${response.statusCode}");
    if (response.statusCode == 200) {
      List<Schedule> request=[];
      if (json.decode(response.body) !=null){
        request = (json.decode(response.body) as List)
            .map((i) => Schedule.fromJson(i)).toList();
      }
      return  request;
    } else {
      throw Exception('Failed to load Schedules');
    }
  }


  static Future<DeliveryCreateResponse> postDeliveryOrder(Order request, String restUrl) async {
    final response = await http.post(
      Uri.parse(restUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      // Декодируем JSON-ответ в Map
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Преобразуем Map в объект DeliveryCreateResponse
      return DeliveryCreateResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to post appeal');
    }
  }
  static Future<KaspiDataJson> postOrderToServerWithKaspiPay(Order request, String restUrl) async {
    final response = await http.post(
      Uri.parse(restUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      KaspiDataJson data = KaspiDataJson.fromJson(responseData);
      return data;
    } else {
      return KaspiDataJson(PaymentLink: '',ExpireDate: '',PaymentId: BigInt.from(0));
    }
  }

  static Future<OrderStatusResponse> getOrderStatus(String id) async{
    OrderStatusRequest request =new OrderStatusRequest(paymentId: 1,paymentTransactionId: id);
    final response = await http.post(
      Uri.parse(MainConfig().getOrderStatusUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()
      ),
    );
    var data= json.decode(response.body);

    OrderStatusResponse statusInfo =OrderStatusResponse.fromJson(data);
    return statusInfo;
  }
}