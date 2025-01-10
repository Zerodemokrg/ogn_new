import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ogn/services/external/api.dart';
import 'package:ogn/ui/themes/defaultTheme.dart';
import '../../main.dart';

class SiteSliverAppBar extends StatefulWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  SiteSliverAppBar({
    required this.title,
    this.showBackButton = false,
    this.actions,
  });

  @override
  _SiteSliverAppBarState createState() => _SiteSliverAppBarState();
}

class _SiteSliverAppBarState extends State<SiteSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    print(_width);
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      toolbarHeight: 60,
      expandedHeight: 60.0, // Высота развернутого AppBar
      floating: false, // AppBar будет исчезать при прокрутке вниз и появляться при прокрутке вверх
      snap: false, // AppBar сразу появляется при остановке прокрутки
      pinned: false, // AppBar не закрепляется в верхней части экрана
      flexibleSpace: FlexibleSpaceBar(
        background: Center(
          child: Container(
            margin:  _width>770? const EdgeInsets.only(left: 60, right: 60,top: 8):const EdgeInsets.only(left: 15, right: 15,top: 8),
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Row(
              children: [
                GestureDetector(
                  onTap: ()=>orderController.order.value.orderType=='inside'?Get.back(): Get.toNamed('/main'),
                  child: Container(
                    child: Image.asset('assets/images/logo_for_dark.png'),
                  ),
                ),
                const SizedBox(width: 10),
                if(_width>560) Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Самое вкусное мясо!',
                      style: _width>700?themData.textTheme.displayMedium:themData.textTheme.displaySmall,
                      textAlign: TextAlign.start,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          if (_width>850) GestureDetector(
                            onTap: ()=>Get.toNamed('/departments'),
                            child: Container(
                              height: 20,
                              child: Text('Наши филиалы'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (_width>1000) GestureDetector(
                            onTap: ()=>Get.toNamed('/appeal'),
                            child: Container(
                              height: 20,
                              child: Text('Жалобы и предложения'),
                            ),
                          ),
                          if (_width>700) const SizedBox(width: 10),
                          Container(
                              height: 20,
                              child: Row(
                                children: [
                                  if(_width>700) Text(
                                    'Контакты:',
                                  ),
                                  Text(
                                    '${organizationController.organizations.first.callCenterPhone}',
                                  ),
                                  Text(
                                    '${organizationController.organizations.first.reserveCallCenterPhone}',
                                  ),
                                ],
                              )
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      width: _width < 700 ? 140 : 205,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: ()  {
                          // var res =await API.getAddressNames("Мангилик ел 53");
                          // print("result addressed is count ${jsonEncode(res.first)}");
                          Get.toNamed('/basket');
                        },
                        child: Row(
                          children: [
                            if (_width < 700) Icon(Icons.shopping_cart_rounded),
                            Expanded(
                              child: Obx(() {
                                return Text(
                                  _width < 700
                                      ? "${orderController.order.value.sumPrice} ₸"
                                      : "Корзина | ${orderController.order.value.sumPrice} ₸",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                  maxLines: 1,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: widget.actions, // Передача дополнительных виджетов действий в AppBar
    );
  }
}
// class SiteSliverAppBar extends StatelessWidget {
//   final String title;
//   final bool showBackButton;
//   final List<Widget>? actions;
//
//   SiteSliverAppBar({
//     required this.title,
//     this.showBackButton = false,
//     this.actions,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     double _width = MediaQuery.of(context).size.width;
//     return SliverAppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: Colors.transparent,
//       toolbarHeight: 60,
//       expandedHeight: 60.0, // Высота развернутого AppBar
//       floating: false, // AppBar будет исчезать при прокрутке вниз и появляться при прокрутке вверх
//       snap: false, // AppBar сразу появляется при остановке прокрутки
//       pinned: false, // AppBar не закрепляется в верхней части экрана
//       flexibleSpace: FlexibleSpaceBar(
//         background: Center(
//           child: Container(
//             margin: const EdgeInsets.only(left: 60, right: 60, top: 8),
//             constraints: const BoxConstraints(maxWidth: 1280),
//             child: Row(
//               children: [
//                 Image.asset('assets/images/logo_for_dark.png'),
//                 const SizedBox(width: 10),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Самое вкусное мясо!',
//                       style: themData.textTheme.displayMedium,
//                       textAlign: TextAlign.start,
//                     ),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 20,
//                             child: Text('Наши филиалы'),
//                           ),
//                           const SizedBox(width: 10),
//                           Container(
//                             height: 20,
//                             child: Text('Жалобы и предложения'),
//                           ),
//                           const SizedBox(width: 10),
//                           Container(
//                             height: 20,
//                             child: Text(
//                               'Контакты: ${organizationController.organizations.first.callCenterPhone}  ${organizationController.organizations.first.reserveCallCenterPhone}',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Container(
//                     width: _width<700?140: 205,
//                     height: 56,
//                     child:    Container(
//                       child: ElevatedButton(
//                           onPressed: ()=> Get.toNamed('/basket'),
//                           child: Row(
//                             children: [
//                               if (_width<700)Icon(Icons.shopping_cart_rounded),
//                               Expanded(
//                                   child:  Obx((){
//                                     return Text(
//                                       _width<700?"${orderController.order.value.sumPrice} ₸":"Корзина | ${orderController.order.value.sumPrice} ₸",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(fontSize: 18),
//                                     );
//                                   })
//                               ),
//                             ],
//                           )
//                       ),
//                     ),
//                   ),
//                 ))
//               ],
//             ),
//           ),
//         ),
//       ),
//       actions: actions, // Передача дополнительных виджетов действий в AppBar
//     );
//   }
// }
