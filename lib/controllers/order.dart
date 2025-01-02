import 'package:get/get.dart';
import '../main.dart';
import '../models/models.dart';
import '../services/external/api.dart';


class OrderController extends GetxController {
  var order = Order(positions: [], deliverySum: 0, sumPrice: 0,orderType: "delivery",paymentType: "cash").obs;
  var deliveryInfo=DeliveryInfo(range: 0).obs;
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
      positions: order.value.positions,
      tableNumber: order.value.tableNumber,
      departmentId: order.value.departmentId,
      orderType: order.value.orderType,// Используем текущие позиции
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

    if (updatedOrder.orderType=="delivery"){
      if (updatedOrder.sumPrice>=10000){
        updatedOrder.positions.removeWhere((element) => element.productId=="c7ae506d-cbee-46e9-a59f-69930ef526d4" || element.productId=="ae3d69d9-47fc-4361-90fd-e7c98dcf85e2" || element.productId=="4592308c-0d23-4b71-9880-999d88146bf9" || element.productId=="04963870-bcdf-46ef-94b7-985dd24639ab" || element.productId=="e5d0a3df-b13b-47a9-b870-e7d64491725f" );
        if (updatedOrder.sumPrice>=10000){
          if (orderController.deliveryInfo.value.range<=10000){
            updatedOrder.positions.add(Position(productId: "e5d0a3df-b13b-47a9-b870-e7d64491725f",positionPrice: menuController.menu.value.products.firstWhere((element) => element.guidId=="e5d0a3df-b13b-47a9-b870-e7d64491725f").sizePrice.first.price.currentPrice.toInt(),positionItems: [],count: 1));
          }
          if (orderController.deliveryInfo.value.range>10000 && orderController.deliveryInfo.value.range<=12000){
            updatedOrder.positions.add(Position(productId: "c7ae506d-cbee-46e9-a59f-69930ef526d4",positionPrice: menuController.menu.value.products.firstWhere((element) => element.guidId=="c7ae506d-cbee-46e9-a59f-69930ef526d4").sizePrice.first.price.currentPrice.toInt(),positionItems: [],count: 1));
          }
          if (orderController.deliveryInfo.value.range>12000 && orderController.deliveryInfo.value.range<=15000){
            updatedOrder.positions.add(Position(productId: "04963870-bcdf-46ef-94b7-985dd24639ab",positionPrice: menuController.menu.value.products.firstWhere((element) => element.guidId=="04963870-bcdf-46ef-94b7-985dd24639ab").sizePrice.first.price.currentPrice.toInt(),positionItems: [],count: 1));
          }
          if (orderController.deliveryInfo.value.range>15000){
            updatedOrder.positions.add(Position(productId: "4592308c-0d23-4b71-9880-999d88146bf9",positionPrice: menuController.menu.value.products.firstWhere((element) => element.guidId=="4592308c-0d23-4b71-9880-999d88146bf9").sizePrice.first.price.currentPrice.toInt(),positionItems: [],count: 1));
          }
        }
        // else {
        //      if (range>8999){
        //        order.positions.add(Position(productId: "72a7d4e3-f667-4323-a288-75458e887f98",positionPrice: MENU.products!.firstWhere((element) => element.guid=="72a7d4e3-f667-4323-a288-75458e887f98").price,positionItems: [],count: 1));
        //      } else {
        //        order.positions.add(Position(productId: "4ce8b9b3-c8dc-47d2-ada0-f6ce59626d3a",positionPrice: MENU.products!.firstWhere((element) => element.guid=="4ce8b9b3-c8dc-47d2-ada0-f6ce59626d3a").price,positionItems: [],count: 1));
        //      }
        // }
      }
      if (updatedOrder.sumPrice<10000){
        updatedOrder.positions.removeWhere((element) => element.productId=="c7ae506d-cbee-46e9-a59f-69930ef526d4" || element.productId=="ae3d69d9-47fc-4361-90fd-e7c98dcf85e2" || element.productId=="4592308c-0d23-4b71-9880-999d88146bf9" || element.productId=="04963870-bcdf-46ef-94b7-985dd24639ab" || element.productId=="e5d0a3df-b13b-47a9-b870-e7d64491725f" );
        if (orderController.deliveryInfo.value.range<=10000){
          updatedOrder.positions.add(Position(productId: "ae3d69d9-47fc-4361-90fd-e7c98dcf85e2",positionPrice: menuController.menu.value.products.firstWhere((element) => element.guidId=="ae3d69d9-47fc-4361-90fd-e7c98dcf85e2").sizePrice.first.price.currentPrice.toInt(),positionItems: [],count: 1));
        }
        if (orderController.deliveryInfo.value.range>10000 && orderController.deliveryInfo.value.range<=12000){
          updatedOrder.positions.add(Position(productId: "c7ae506d-cbee-46e9-a59f-69930ef526d4",positionPrice: menuController.menu.value.products.firstWhere((element) => element.guidId=="c7ae506d-cbee-46e9-a59f-69930ef526d4").sizePrice.first.price.currentPrice.toInt(),positionItems: [],count: 1));
        }
        if (orderController.deliveryInfo.value.range>12000 && orderController.deliveryInfo.value.range<=15000){
          updatedOrder.positions.add(Position(productId: "04963870-bcdf-46ef-94b7-985dd24639ab",positionPrice: menuController.menu.value.products.firstWhere((element) => element.guidId=="04963870-bcdf-46ef-94b7-985dd24639ab").sizePrice.first.price.currentPrice.toInt(),positionItems: [],count: 1));
        }
        if (orderController.deliveryInfo.value.range>15000){
          updatedOrder.positions.add(Position(productId: "4592308c-0d23-4b71-9880-999d88146bf9",positionPrice: menuController.menu.value.products.firstWhere((element) => element.guidId=="4592308c-0d23-4b71-9880-999d88146bf9").sizePrice.first.price.currentPrice.toInt(),positionItems: [],count: 1));
        }
      }
    }

    //расчитываем доставку
    updatedOrder.sumPrice=0;
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


    if (updatedOrder.positions.length==1 && menuController.deliveriesProducts.contains(updatedOrder.positions.first.productId)){
      updatedOrder.positions=[];
      updatedOrder.sumPrice=0;
    }
    // Присваиваем новое значение Observable переменной
    order.value = updatedOrder;
  }
  void addPosition(Position position){
  }

  void preparationOrder(){
    orderController.order.value.departmentId=orderController.deliveryInfo.value.selectedDepartmentId;
    orderController.order.value.coordinate=orderController.deliveryInfo.value.selectedAddress?.point;
    orderController.order.value.orderAddress=orderController.deliveryInfo.value.selectedAddress?.address_name;
    orderController.order.value.clientStreet=orderController.deliveryInfo.value.selectedAddress?.address_name.split(",").first;
    orderController.order.value.clientHouse=orderController.deliveryInfo.value.selectedAddress?.address_name.split(",").toList().sublist(1).join(',').trim();
    orderController.order.value.comment=orderController.deliveryInfo.value.controllerComment.text;
    orderController.order.value.clientPhone=orderController.deliveryInfo.value.controllerPhone.text;
    orderController.order.value.clientName=orderController.deliveryInfo.value.controllerName.text;
    orderController.order.value.clientFlat=orderController.deliveryInfo.value.controllerFlat.text;
    orderController.order.value.clientFloor=orderController.deliveryInfo.value.controllerFloor.text;
    orderController.order.value.clientDoorphone=orderController.deliveryInfo.value.controllerDoorPhone.text;
    orderController.order.value.clientEntrance=orderController.deliveryInfo.value.controllerEntrance.text;
  }
  void changeSum(){

  }
}