import 'package:flutter/material.dart';
import 'package:ogn/ui/ui.dart';
import 'package:ogn/ui/widgets/products/products_table.dart';

import '../widgets/banners/banner_container.dart';
import '../widgets/banners/banners.dart';
import '../widgets/categories/categories.dart';

import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SiteSliverAppBar(title: '',),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              Container(
                height: 200,
                child: BannersWidget(),
              ), // Ваш виджет с баннерами
              const SizedBox(
                height: 32,
              ),
              CategoriesWidget(),
              const SizedBox(
                height: 32,
              ),
              ProductTable(),

            ],
          ),
        )

      ],
    );
  }
}
// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => new _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   bool isLoaded = true;
//
//   getData() async {
//     // Здесь загрузите данные для баннеров
//     // Пример:
//     // await bannersController.loadBanners();
//     setState(() {
//       isLoaded = true; // Данные загружены
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Center(
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 32,
//           ),
//           Container(
//             height: 200,
//             child: BannersWidget(),
//           ),// Ваш виджет с баннерами
//           const SizedBox(
//             height: 32,
//           ),
//           CategoriesWidget(),
//         ],
//       ),
//     );
//   }
// }



// AnimatedGradientBorderContainer(
// borderRadius: 12,
// borderWidth: 8,
// backgroundImage: NetworkImage('https://i.ibb.co.com/pQjDH1H/FGXKl4sh-Zty-Fuh4-Cgb-Qqm-ACb-Uk-Ur0p-GZUUmjfv-TL.jpg'),
// child: Center(
// child: Icon(
// Icons.image,
// size: 100,
// color: Colors.amber,
// ),
// ),
// ),