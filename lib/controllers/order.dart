import 'package:get/get.dart';
import '../main.dart';
import '../models/models.dart';
import '../services/external/api.dart';


class OrderController extends GetxController {
  var order = Order(positions: [], deliverySum: 0, sumPrice: 0).obs;
  var sum=0.obs;
  @override
  void onInit() {
    super.onInit();
    changeOrderType("delivery");
  }
  void changeOrderType(String orderType){
    order.value.orderType=orderType;
  }
  void changeOrder() {
    // Создаем новый объект Order с обновленными данными
    var updatedOrder = order.value.copyWith(
      sumPrice: 0,
      positions: order.value.positions,  // Используем текущие позиции
    );
    // Обновляем сумму цены
    for (var item in updatedOrder.positions) {
      updatedOrder.sumPrice += menuController.menu.value.products
          .firstWhere((element) => element.guidId == item.productId)
          .sizePrice
          .first
          .price
          .currentPrice
          .toInt() *
          item.count!;
      for (var mod in item.positionItems!) {
        updatedOrder.sumPrice += (menuController.menu.value.products
            .firstWhere((element) => element.guidId == mod.modifierId!)
            .sizePrice
            .first
            .price
            .currentPrice *
            mod.count!)
            .toInt() *
            item.count!;
      }
    }

    // Присваиваем новое значение Observable переменной
    order.value = updatedOrder;
  }
  void addPosition(Position position){

  }
  void changeSum(){

  }
}