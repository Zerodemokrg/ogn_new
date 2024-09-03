import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../themes/defaultTheme.dart';
import '../widgets/appBar.dart';
import '../widgets/basket/deliveryForm.dart';
import '../widgets/basket/payments.dart';
import '../widgets/basket/positionContainer.dart';

class BasketPage extends StatefulWidget{
  @override
  _BasketPageState createState()=>new _BasketPageState();
}

class _BasketPageState extends State<BasketPage>{

  List<String> nameBasket=["Ваша корзина","Сіздің себетіңіз","Your cart"];//Сіздің себетіңіз //Your cart
  List<String> nameMinSumForDelivery=["Минимальная сумма для доставка","Жеткізу үшін ең аз сома ","Minimum delivery cost"];//Жеткізу үшін ең аз сома //Minimum delivery cost
  List<String> nameSummarySum=["Общая сумма",",Жалпы сома","Total price"];
  //List<String> nameCustomerInfo="";

  List<String> nameChoosePaymentType=["Выберите способ оплаты","Төлем әдісін таңдаңыз","Select a Payment Method"];
  List<String> nameCashToCourierPaymentTypeInButton=["Наличными курьеру","Курьерге қолма-қол ақша" ,"Cash to courier"];
  List<String> nameCardToCourierPaymentTypeInButton=["Картой курьеру"," Курьерге картамен ","Card to  courier"];
  List<String> nameToSendOrderButton=["Оформить заказ","Шығу" ,"Checkout"];
  List<String> orderTypeDelivery=["Доставка","Жеткізу","Delivery"];
  List<String> orderTypePickup=["Самовывоз","Алып кету","Pickup"];
  List<String> orderTypeInside=["В зале","Залда","Dine-in"];
  bool isLoaded=true;
  getData()async{

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                    children: [
                      Container(
                        width: 500,
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
                        width: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if(orderController.order.value.orderType=="delivery")
                              Container(
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
                            const SizedBox(
                              height:5 ,
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