import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogn/configs/urls.dart';
import '../../main.dart';
import '../../models/models.dart';
import '../../services/external/api.dart';
import '../themes/defaultTheme.dart';
import '../widgets/appBar.dart';
import '../widgets/basket/deliveryForm.dart';
import '../widgets/basket/payments.dart';
import '../widgets/basket/positionContainer.dart';
import '../widgets/dialogs.dart';
import '../widgets/dialogs_windows/kaspiPayWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

import '../widgets/dialogs_windows/testDialog.dart';

class BasketPage extends StatefulWidget{
  @override
  _BasketPageState createState()=>new _BasketPageState();
}

class _BasketPageState extends State<BasketPage>{
 bool inProgress=false;
  List<String> nameBasket=["Ваша корзина","Сіздің себетіңіз","Your cart"];//Сіздің себетіңіз //Your cart
  List<String> nameMinSumForDelivery=["Минимальная сумма для доставка","Жеткізу үшін ең аз сома ","Minimum delivery cost"];//Жеткізу үшін ең аз сома //Minimum delivery cost
  List<String> nameSummarySum=["Общая сумма",",Жалпы сома","Total price"];
  //List<String> nameCustomerInfo="";

  List<String> nameChoosePaymentType=["Выберите способ оплаты","Төлем әдісін таңдаңыз","Select a Payment Method"];
  List<String> nameCashToCourierPaymentTypeInButton=["Наличными курьеру","Курьерге қолма-қол ақша" ,"Cash to courier"];
  List<String> nameCardToCourierPaymentTypeInButton=["Картой курьеру"," Курьерге картамен ","Card to courier"];
  List<String> nameToSendOrderButton=["Оформить заказ","Шығу" ,"Checkout"];
  List<String> orderTypeDelivery=["Доставка","Жеткізу","Delivery"];
  List<String> orderTypePickup=["Самовывоз","Алып кету","Pickup"];
  List<String> orderTypeInside=["В зале","Залда","Dine-in"];
  bool isLoaded=true;
  getData()async{

  }
  Future<void> _showResultDialog(DeliveryCreateResponse response) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MessageFromServerWidget(data: response,);
      },
    );
  }
  Future<void> _handleOrderSubmission() async {
    try {
      DeliveryCreateResponse res = await API.postDeliveryOrder(orderController.order.value,  MainConfig().sendDeliveryOrderToServerUrl);
      orderController.order.value = Order(positions: [], deliverySum: 0, sumPrice: 0,orderType: "delivery",paymentType: "cash");
      orderController.deliveryInfo.value=DeliveryInfo(range: 0);

      await _showResultDialog(res); // Вызов диалогового окна с результатами
    } catch (error) {
      print(error);
      // Обработка ошибки при отправке заказа
    }
  }
 Future<KaspiDataJson?> _handleOrderByKaspiQrPaymentSubmission() async{
    try {
     // KaspiDataJson paymentData=await API.postOrderToServerWithKaspiPay(orderController.order.value, MainConfig().sendDeliveryWithKaspiQRToServerUrl);
      return await API.postOrderToServerWithKaspiPay(orderController.order.value, MainConfig().sendDeliveryWithKaspiQRToServerUrl);
    } catch (error){
      DeliveryCreateResponse message=DeliveryCreateResponse(message: "Ошибка $error", orderNumber:"", error: true);
      await _showResultDialog(message);
      return null;
    }
  }
  void  checkOrderStatus(String idPay) async {
   print("Begin checking");
   String status="";
   // String number="";
   while (true) {
     print("status payment is:$status}");
     var res=await API.getOrderStatus(idPay);
     status=res.orderStatus??"";
     if (status == "Error") {
       setState(() {
         status = "Error";
         // loadData = false;
       });
       // loadData = false;

       _showResultDialog(DeliveryCreateResponse(message: localSettingsController.selectLanguage=="RU"? "Ошибка при создании заказа":(localSettingsController.selectLanguage=="KZ"?"Тапсырыс жасау кезіндегі қате":"Error in creating an order"), orderNumber: "", error: true));
       break;
     }
     if (status == "Success") {
       setState(() {
         status = "Success";
         //loadData = false;
       });
       _showResultDialog(DeliveryCreateResponse(message:  localSettingsController.selectLanguage=="RU"? "Заказ создан, ждите подтверждения оператора":( localSettingsController.selectLanguage=="KZ"?"Тапсырыс жасалды, оператордың растауын күтіңіз":"The order has been created, please wait for operator confirmation"), orderNumber: "", error: false));

       //loadData = false;
       //  _showResultDialog(DeliveryCreateResponse(message: language.shortName=="RU"? "Заказ создан, ждите подтверждения оператора":(language.shortName=="KZ"?"Тапсырыс жасалды, оператордың растауын күтіңіз":"The order has been created, please wait for operator confirmation"), orderNumber: "", error: false));
       break;
     }
     await Future.delayed(Duration(seconds: 3)); // Задержка 3 секунды перед следующей итерацией
   }
   print("End checking");
 }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print("departtmnent id ${orderController.order.value.departmentId}");
    print("table id ${orderController.order.value.tableNumber}");
    print("ordertype is ${orderController.order.value.orderType}");
  }
  @override
  Widget build(BuildContext context){
    double _width= MediaQuery.of(context).size.width ;
    return CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SiteSliverAppBar(title: '',),
          SliverToBoxAdapter(
            child:   Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(orderController.order.value.orderType == "inside" && orderController.order.value.tableNumber!=null )Container(
                  alignment: Alignment.center,
                  margin:EdgeInsets.only(top: 20),
                  child: GradientText(
                    "Стол № ${orderController.order.value.tableNumber}",
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Color.fromRGBO(220, 53, 42, 1),  // rgba(220, 53, 42, 1)
                        Color.fromRGBO(255, 214, 10, 1), // rgba(255, 214, 10, 1)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    sizeFont: 18,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin:EdgeInsets.only(top: 20),
                  child: GradientText(
                    "Оформление заказа",
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Color.fromRGBO(220, 53, 42, 1),  // rgba(220, 53, 42, 1)
                        Color.fromRGBO(255, 214, 10, 1), // rgba(255, 214, 10, 1)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    sizeFont: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 450,
                        // color: Colors.black,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx((){
                              return Text(localSettingsController.selectLanguage.value=="RU"?nameBasket.first:(localSettingsController.selectLanguage.value=="KZ"?nameBasket[1]:nameBasket[2]));
                            }),
                            SizedBox(
                              height:_width>770?16:0 ,
                            ),
                            PositionTableWidget(),
                          ],
                        ),
                      ),
                      if(_width>1030 )Container(
                        margin: EdgeInsets.only( left: 24), // Отступы слева и справа
                        height: 650, // Высота линии
                        width: 0.3, // Толщина линии
                        color: Color.fromRGBO(51, 51, 51, 1), // Цвет линии
                      ),
                      Container(
                        margin: EdgeInsets.only(top: _width>770?0:15),
                        alignment: Alignment.center,
                        width: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(orderController.order.value.orderType=="delivery")
                              Container(
                                alignment: Alignment.center,
                                child: Obx((){
                                  return Text(localSettingsController.selectLanguage.value=="RU"?orderTypeDelivery.first:(localSettingsController.selectLanguage.value=="KZ"?orderTypeDelivery[1]:orderTypeDelivery[2]));
                                }),
                              ),

                            if(orderController.order.value.orderType=="pickup")
                              Container(
                                margin: EdgeInsets.only(left: 25),
                                child:  Obx((){
                                  return Text(localSettingsController.selectLanguage.value=="RU"?orderTypePickup.first:(localSettingsController.selectLanguage.value=="KZ"?orderTypePickup[1]:orderTypePickup[2]));
                                }),
                              ),

                            if(orderController.order.value.orderType=="inside")
                              Container(
                                margin: EdgeInsets.only(left: 25),
                                child: Obx((){
                                  return Text(localSettingsController.selectLanguage.value=="RU"?orderTypeInside.first:(localSettingsController.selectLanguage.value=="KZ"?orderTypeInside[1]:orderTypeInside[2]));
                                }),
                              ),
                           const  SizedBox(
                              height:5,
                            ),
                            DeliveryForm(),
                            const SizedBox(
                              height:5 ,
                            ),
                            Container(
                              height: 54,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:Colors.white,// Color.fromRGBO(51, 51, 51, 1), // Цвет границы
                                  width: 0.3, // Ширина границы
                                ),
                                borderRadius: BorderRadius.circular(16), // Радиус углов
                              ),
                              child: Text(
                                localSettingsController.selectLanguage.value=="RU"?nameChoosePaymentType.first:(localSettingsController.selectLanguage.value=="KZ"?nameChoosePaymentType[1]:nameChoosePaymentType[2]),
                                style: themData.textTheme.displaySmall,
                              ),
                            ),

                            const SizedBox(
                              height:30 ,
                            ),
                            Container(
                              width: 500,

                              child: PaymentMethodSelector(),
                            ),
                            const SizedBox(
                              height:30 ,
                            ),
                            Container(
                              width: 500,
                              height: 55,
                              child:ElevatedButton(
                                  onPressed: (inProgress==true)?null:() async {
                                    print("selected address is ${jsonEncode(orderController.deliveryInfo.value.selectedAddress)}");
                                    print("range from controller is ${orderController.deliveryInfo.value.range}");
                                    print("department id from controller is ${orderController.deliveryInfo.value.selectedDepartmentId}");
                                    print("controller phone is ${orderController.deliveryInfo.value.controllerPhone.text}");

                                    orderController.preparationOrder();

                                    print("order is ${jsonEncode(orderController.order.value)}");
                                    setState(() {
                                      inProgress=true;
                                    });
                                    // DeliveryCreateResponse res = await API.postDeliveryOrder(orderController.order.value,  MainConfig().sendDeliveryOrderToServerUrl);
                                    // print("result is ${res.message}");

                                    if (orderController.deliveryInfo.value.controllerFlat.text.length>0&&orderController.deliveryInfo.value.controllerName.text.length>1&&orderController.deliveryInfo.value.controllerName.text.length>1&&orderController.order.value.sumPrice>5000&&orderController.deliveryInfo.value.selectedAddress!=null&&orderController.deliveryInfo.value.selectedDepartmentId!=null &&orderController.deliveryInfo.value.controllerPhone.text.length>=11)
                                      {
                                        if (orderController.order.value.paymentType=="kaspi"){
                                          KaspiDataJson? paymentData=await _handleOrderByKaspiQrPaymentSubmission();

                                          if (paymentData!=null){
                                            checkOrderStatus(paymentData.PaymentId.toString());
                                            // showDialog(
                                            //   builder: (context) {
                                            //     return KaspiPayWidget(kaspiUrl: paymentData.PaymentLink);
                                            //   }, context: context,
                                            //   //title: _ScheduleOptionWidget(id: schedules[_dataGridController.selectedIndex].id!, update: true),
                                            // );
                                            //html.window.open(paymentData.PaymentLink, '_blank');


                                            showDialog(
                                              context: context,
                                              builder: (context) => QRCodeDialog(
                                                url: paymentData.PaymentLink,
                                              ),
                                            );
                                          }

                                        } else {
                                           await _handleOrderSubmission();
                                        }

                                      } else {
                                       if (orderController.deliveryInfo.value.selectedAddress==null){
                                         setState(() {
                                           checkValid.address=false;
                                         });
                                       }
                                       if (orderController.deliveryInfo.value.controllerPhone.text.length<11){
                                         setState(() {
                                           checkValid.phone=false;
                                         });
                                       }
                                       if (orderController.deliveryInfo.value.controllerFlat.text.length<1){
                                         setState(() {
                                           checkValid.flat=false;
                                         });
                                       }
                                       if (orderController.deliveryInfo.value.controllerName.text.length<1){
                                         setState(() {
                                           checkValid.name=false;
                                         });
                                       }
                                    }
                                    setState(() {
                                      inProgress=false;
                                    });
                                  },
                                  child: Text("Оформить заказ")),
                            ),
                            const SizedBox(
                              height:30 ,
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                )
              ],

            )
          ),

          // SliverFillRemaining(
          //   hasScrollBody: false,
          //   child: FooterWidget(),
          // ),
        ]);
  }
}