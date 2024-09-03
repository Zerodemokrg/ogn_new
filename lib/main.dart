import 'package:flutter/material.dart';
import 'package:ogn/ui/pages/appeal_page.dart';
import 'package:ogn/ui/pages/basket_page.dart';
import 'package:ogn/ui/pages/choose_department_page.dart';
import 'package:ogn/ui/pages/choose_order_type_page.dart';
import 'package:ogn/ui/pages/department_page.dart';
import 'package:ogn/ui/pages/loading_page.dart';
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

  await Future.wait([
    organizationController.fetchData(),
    departmentsController.fetchData(),
    bannersController.fetchData(),
    iconsController.fetchData(),
    menuController.fetchData(),
    stickersController.fetchData(),
    // Добавьте другие контроллеры здесь
  ]);
  print("ppspspspsps:${bannersController.banners.length}");
  print(menuController.menu.value.groups.length);
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
          name: '/',
          page: () =>  MainScaffold(
            title: '', body: ChooseOrderTypePage(),showAppBar: false,
          ),
        ),
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
          name: '/main',
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
      body: Stack(
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
      ),
    );
  }
}