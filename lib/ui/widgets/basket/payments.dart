import 'package:flutter/material.dart';

import '../../../controllers/intl.dart';
import '../../../main.dart';
import '../../themes/defaultTheme.dart';


class PaymentMethodSelector extends StatefulWidget {
  @override
  _PaymentMethodSelectorState createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  //String selectedMethod = 'cash'; // Изначально выбран наличный расчет

  void selectMethod(String method) {
    setState(() {
      orderController.order.value.paymentType = method;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectMethod("cash");
  }
  @override
  Widget build(BuildContext context) {
    double _width= MediaQuery.of(context).size.width ;
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
       // Первый вариант оплаты
        const SizedBox(
          width: 8,
        ),
        Expanded(child: GestureDetector(
          onTap: () => selectMethod('kaspi'),
          child: Container(
            alignment: Alignment.center,
            width: 80, //
            height: 110,// Ширина контейнера
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: orderController.order.value.paymentType == 'kaspi' ? primaryColor : Colors.grey, // Цвет границы
                width: orderController.order.value.paymentType == 'kaspi' ?3:0.3, // Ширина границы
              ),
              borderRadius: BorderRadius.circular(16), // Радиус углов
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code_scanner, size: 35,color:orderController.order.value.paymentType == 'kaspi' ?primaryColor:Colors.white),
                SizedBox(height: 8),
                Text('Kaspi QR', style: TextStyle(color: orderController.order.value.paymentType == 'kaspi' ?primaryColor:Colors.white,fontSize: 12,fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        )),
        // Второй вариант оплаты
        const SizedBox(
          width: 8,
        ),
        Expanded(child:   GestureDetector(
          onTap: () => selectMethod('cash'),
          child: Container(
            width: 80,
            height: 110,// Ширина контейнера
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: orderController.order.value.paymentType == 'cash' ? primaryColor : Colors.grey, // Цвет границы
                width: orderController.order.value.paymentType == 'cash' ?3:0.3, // Ширина границы
              ),
              borderRadius: BorderRadius.circular(16), // Радиус углов
            ),
            child: Column(
              children: [
                Icon(Icons.payments_outlined, size: 35, color:orderController.order.value.paymentType == 'cash' ?primaryColor: Colors.white),
                SizedBox(height: _width>770?8:10),
                Obx((){
                  return  Text(localSettingsController.selectLanguage.value=="RU"?nameCashToCourierPaymentTypeInButton.first:localSettingsController.selectLanguage.value=="KZ"?nameCashToCourierPaymentTypeInButton[1]:nameCashToCourierPaymentTypeInButton[2], style: TextStyle(color: orderController.order.value.paymentType == 'cash' ?primaryColor:Colors.white,fontWeight: FontWeight.w700,fontSize: _width>770?12:10));
                })
              ],
            ),
          ),
        ),),
        // Третий вариант оплаты
        const SizedBox(
          width: 8,
        ),
       Expanded(child:  GestureDetector(
         onTap: () => selectMethod('cardToCourier'),
         child: Container(
           width: 80,
           height: 110,// Ширина контейнера
           padding: EdgeInsets.all(16),
           decoration: BoxDecoration(
             border: Border.all(
               color: orderController.order.value.paymentType == 'cardToCourier' ? primaryColor: Colors.grey, // Цвет границы
               width: orderController.order.value.paymentType == 'cardToCourier' ?3:0.3, // Ширина границы
             ),
             borderRadius: BorderRadius.circular(16), // Радиус углов
           ),
           child: Column(
             children: [
               Icon(Icons.add_card_outlined, size: 35, color: orderController.order.value.paymentType == 'cardToCourier' ?primaryColor:Colors.white),
               SizedBox(height: 8),
               Obx((){
                 return  Text(localSettingsController.selectLanguage.value=="RU"?nameCardToCourierPaymentTypeInButton.first:localSettingsController.selectLanguage.value=="KZ"?nameCardToCourierPaymentTypeInButton[1]:nameCardToCourierPaymentTypeInButton[2], style: TextStyle(color: orderController.order.value.paymentType == 'cardToCourier' ?primaryColor:Colors.white,fontWeight: FontWeight.w700,fontSize: _width>770?12:10),textAlign: TextAlign.center,);
               })             ],
           ),
         ),
       ),),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}