import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogn/main.dart';
import 'package:ogn/ui/widgets/products/product_container.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogn/main.dart';
import 'package:ogn/ui/widgets/products/product_container.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dialogs.dart';
import '../widgets.dart';


class ProductTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width= MediaQuery.of(context).size.width ;
    return Container(
      width: 1280,
      margin: EdgeInsets.only(right: 60, left: 60,top: 10),
      child: Obx(() {
        // Получаем список продуктов для текущей выбранной категории
        var products = menuController.menu.value.products
            .where((element) => element.parentGuid == menuController.selectedCategoryGuid.value)
            .toList();
        return _width>770?GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Отключение прокрутки

          gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 330,
            crossAxisSpacing: 64,
            mainAxisSpacing: 20,
            childAspectRatio: 3/5,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                showResponsiveDialog(context,products[index]);
              },
              child:ProductContainer(product: products[index]),
            );
          },
        ):ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: products.length,
                        itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  showResponsiveDialog(context,products[index]);
                },
                child:Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: ProductContainer(product: products[index]),
                ),
              );
            });
      }),
    );
  }
}



// class ProductTable extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double _width= MediaQuery.of(context).size.width ;
//     return Container(
//       width: 1280,
//       margin: EdgeInsets.only(right: 60, left: 60,top: 10),
//       child: Obx(() {
//         // Получаем список продуктов для текущей выбранной категории
//         var products = menuController.menu.value.products
//             .where((element) => element.parentGuid == menuController.selectedCategoryGuid.value)
//             .toList();
//         return GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(), // Отключение прокрутки
//           gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: _width>770?330:450,
//             crossAxisSpacing: 64,
//             childAspectRatio: 3/5,
//           ),
//           itemCount: products.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: (){
//                 showResponsiveDialog(context,products[index]);
//               },
//               child:ProductContainer(product: products[index]),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
//
//
//
