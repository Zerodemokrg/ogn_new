import 'package:flutter/material.dart';
import 'package:ogn/ui/pages/appeal_page.dart';
import 'package:ogn/ui/pages/basket_page.dart';
import 'package:ogn/ui/pages/choose_department_page.dart';
import 'package:ogn/ui/pages/choose_order_type_page.dart';
import 'package:ogn/ui/pages/department_page.dart';
import 'package:ogn/ui/pages/loading_page.dart';
import 'package:ogn/ui/pages/loading_screen.dart';
import 'package:ogn/ui/pages/main_page.dart';
import 'package:ogn/ui/themes/defaultTheme.dart';
import 'package:url_strategy/url_strategy.dart';
import 'controllers/controllers.dart' as myControllers;
import 'package:get/get.dart';


export 'package:get/get.dart';

late myControllers.OrganizationController organizationController;
late myControllers.LocalSettingsController localSettingsController;
late myControllers.OrderController orderController;
late myControllers.DepartmentsController departmentsController;
late myControllers.BannersController bannersController;
late myControllers.IconsController iconsController;
late myControllers.MenuController menuController;
late myControllers.StickersController stickersController;
late myControllers.RecommendationsController recommendationController;

void main() async  {
  setPathUrlStrategy();
  Get.put(myControllers.OrganizationController());
  organizationController=Get.find();

  Get.put(myControllers.LocalSettingsController());
  localSettingsController=Get.find();
  //localSettingsController.selectLanguage.value="RU";
  Get.put(myControllers.OrderController());
  orderController=Get.find();

  Get.put(myControllers.DepartmentsController());
  departmentsController=Get.find();

  Get.put(myControllers.BannersController());
  bannersController=Get.find();

  Get.put(myControllers.IconsController());
  iconsController=Get.find();

  Get.put(myControllers.MenuController());
  menuController=Get.find();

  Get.put(myControllers.StickersController());
  stickersController=Get.find();

  Get.put(myControllers.RecommendationsController());
  recommendationController=Get.find();

  // await Future.wait([
  //   organizationController.fetchData(),
  //   departmentsController.fetchData(),
  //   bannersController.fetchData(),
  //   iconsController.fetchData(),
  //   menuController.fetchData(),
  //   stickersController.fetchData(),
  //   recommendationController.fetchData(),
  //   // Добавьте другие контроллеры здесь
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Огонек',
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/basket',
          page: () => MainScaffold(
            body: BasketPage(),
            title: 'Basket',
            showAppBar: true,
          ),
        ),
        GetPage(
          name: '/departments',
          page: () => MainScaffold(
            body: DepartmentsPage(),
            title: 'Basket',
            showAppBar: true,
          ),
        ),
        GetPage(
          name: '/loading',
          page: () => MainScaffold(
            body: LoadingPage(),
            title: 'Loading',
            showAppBar: false,
          ),
        ),
        GetPage(
          name: '/chooseDepartments',
          page: () => MainScaffold(
            body: ChooseDepartmentPage(),
            title: 'chooseDepartments',
            showAppBar: false,
          ),
        ),
        GetPage(
          name: '/appeal',
          page: () => MainScaffold(
            body: AppealPage(),
            title: 'Appeal',
            showAppBar: true,
          ),
        ),
        GetPage(
          name: '/',
          page: () => MainScaffold(
            body: MainPage(),
            title: 'mainPage',
            showAppBar: true,
          ),
        ),
      ],
      theme: themData,
    );
  }
}

class MainScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final bool showAppBar;

  const MainScaffold({
    Key? key,
    required this.body,
    required this.title,
    this.showAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // print(screenWidth);
    return Scaffold(
      body: FutureBuilder(
          future:Future.wait([
                organizationController.fetchData(),
                departmentsController.fetchData(),
                bannersController.fetchData(),
                iconsController.fetchData(),
                menuController.fetchData(),
                stickersController.fetchData(),
                recommendationController.fetchData(),
          Future.delayed(const Duration(seconds: 1)),
          // Добавьте другие контроллеры здесь
          ]),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Пока данные загружаются, показываем индикатор загрузки
              return const Center(
                child: LoadingScreen(),
              );
            } else if (snapshot.hasError) {
              // Если произошла ошибка при загрузке
              return Center(
                child: Text(
                  'Произошла ошибка: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            } else {
              // Данные загружены, переходим на главный экран
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset("assets/images/background.png",fit: BoxFit.fill),
                  ),
                  Center(child: Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(left: 15,right: 15),
                    constraints: BoxConstraints(maxWidth: 1280),
                    child: body ,
                  ),)

                ],
              );
            }

          }
      )
    );
  }
}


// class MainScaffold extends StatelessWidget {
//   final Widget body;
//   final String title;
//   final bool showAppBar;
//
//   const MainScaffold({
//     Key? key,
//     required this.body,
//     required this.title,
//     this.showAppBar = true,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // double screenWidth = MediaQuery.of(context).size.width;
//     // print(screenWidth);
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset("assets/images/background.png",fit: BoxFit.fill),
//           ),
//           Center(child: Container(
//             alignment: Alignment.topCenter,
//             margin: EdgeInsets.only(left: 15,right: 15),
//             constraints: BoxConstraints(maxWidth: 1280),
//             child: body ,
//           ),)
//
//         ],
//       ),
//     );
//   }
// }