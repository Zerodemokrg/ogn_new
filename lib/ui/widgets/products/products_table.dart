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
    return Container(
      width: 1280,
      margin: EdgeInsets.only(right: 60, left: 60),
      child: Obx(() {
        // Получаем список продуктов для текущей выбранной категории
        var products = menuController.menu.value.products
            .where((element) => element.parentGuid == menuController.selectedCategoryGuid.value)
            .toList();

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Отключение прокрутки
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 320,
            crossAxisSpacing: 64,
            childAspectRatio: 3/5
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
        );
      }),
    );
  }
}



// class ProductTable extends StatefulWidget{
//   @override
//   _ProductTableState createState()=>new _ProductTableState();
// }
//
// class _ProductTableState extends State<ProductTable>{
//   bool isLoaded=true;
//   getData()async{
//
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getData();
//   }
//
//   @override
//   Widget build(BuildContext context){
//     return Container(
//       width: 1280,
//       margin: EdgeInsets.only(right: 60,left: 60),
//       child:  GridView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(), // Отключение прокрутки
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 300,
//             crossAxisSpacing: 64,
//           ),
//           itemCount: menuController.menu.value.products.where((elenent)=>elenent.parentGuid==menuController.selectedCategoryGuid.value).toList().length,
//           itemBuilder: (context,index){
//             return ProductContainer(product: menuController.menu.value.products.where((elenent)=>elenent.parentGuid==menuController.selectedCategoryGuid.value).toList()[index]);
//             // return menuController.menu.value.products.where((elenent)=>elenent.parentGuid==menuController.selectedCategoryGuid.value)
//           }
//       ),
//     );
//   }
// }