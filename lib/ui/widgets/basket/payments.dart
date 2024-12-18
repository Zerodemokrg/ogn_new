import 'package:flutter/material.dart';

import '../../../controllers/intl.dart';
import '../../../main.dart';
import '../../themes/defaultTheme.dart';


class PaymentMethodSelector extends StatefulWidget {
  @override
  _PaymentMethodSelectorState createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  String selectedMethod = 'cash'; // Изначально выбран наличный расчет

  void selectMethod(String method) {
    setState(() {
      selectedMethod = method;
    });
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
          onTap: () => selectMethod('kaspi_qr'),
          child: Container(
            alignment: Alignment.center,
            width: 80, //
            height: 110,// Ширина контейнера
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedMethod == 'kaspi_qr' ? primaryColor : Colors.grey, // Цвет границы
                width: selectedMethod == 'kaspi_qr' ?3:0.3, // Ширина границы
              ),
              borderRadius: BorderRadius.circular(16), // Радиус углов
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code_scanner, size: 35,color:selectedMethod == 'kaspi_qr' ?primaryColor:Colors.white),
                SizedBox(height: 8),
                Text('Kaspi QR', style: TextStyle(color: selectedMethod == 'kaspi_qr' ?primaryColor:Colors.white,fontSize: 12,fontWeight: FontWeight.w700)),
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
                color: selectedMethod == 'cash' ? primaryColor : Colors.grey, // Цвет границы
                width: selectedMethod == 'cash' ?3:0.3, // Ширина границы
              ),
              borderRadius: BorderRadius.circular(16), // Радиус углов
            ),
            child: Column(
              children: [
                Icon(Icons.payments_outlined, size: 35, color:selectedMethod == 'cash' ?primaryColor: Colors.white),
                SizedBox(height: _width>770?8:10),
                Obx((){
                  return  Text(localSettingsController.selectLanguage.value=="RU"?nameCashToCourierPaymentTypeInButton.first:localSettingsController.selectLanguage.value=="KZ"?nameCashToCourierPaymentTypeInButton[1]:nameCashToCourierPaymentTypeInButton[2], style: TextStyle(color: selectedMethod == 'cash' ?primaryColor:Colors.white,fontWeight: FontWeight.w700,fontSize: _width>770?12:10));
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
         onTap: () => selectMethod('card'),
         child: Container(
           width: 80,
           height: 110,// Ширина контейнера
           padding: EdgeInsets.all(16),
           decoration: BoxDecoration(
             border: Border.all(
               color: selectedMethod == 'card' ? primaryColor: Colors.grey, // Цвет границы
               width: selectedMethod == 'card' ?3:0.3, // Ширина границы
             ),
             borderRadius: BorderRadius.circular(16), // Радиус углов
           ),
           child: Column(
             children: [
               Icon(Icons.add_card_outlined, size: 35, color: selectedMethod == 'card' ?primaryColor:Colors.white),
               SizedBox(height: 8),
               Obx((){
                 return  Text(localSettingsController.selectLanguage.value=="RU"?nameCardToCourierPaymentTypeInButton.first:localSettingsController.selectLanguage.value=="KZ"?nameCardToCourierPaymentTypeInButton[1]:nameCardToCourierPaymentTypeInButton[2], style: TextStyle(color: selectedMethod == 'card' ?primaryColor:Colors.white,fontWeight: FontWeight.w700,fontSize: _width>770?12:10),textAlign: TextAlign.center,);
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