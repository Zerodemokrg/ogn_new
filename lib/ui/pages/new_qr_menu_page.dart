import 'dart:convert';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ogn/ui/ui.dart';
import 'package:ogn/ui/widgets/categories/short_categories.dart';
import '../../configs/urls.dart';
import '../../controllers/intl.dart';
import '../../main.dart';
import '../../models/models.dart';
import '../../services/external/api.dart';
import '../themes/defaultTheme.dart';
import '../widgets/appBar.dart';
import '../widgets/banners/banner_container.dart';
import '../widgets/banners/banners.dart';
import '../widgets/dialogs.dart';
import '../widgets/products/products_table.dart';
import 'loading_screen.dart';

class NewQrMenuPage extends StatefulWidget{
  @override
  _NewQrMenuPageState createState()=>new _NewQrMenuPageState();
}

class _NewQrMenuPageState extends State<NewQrMenuPage> {
  bool isBlocked=false;
  bool isLoaded = true;
  bool _topSafe = false;
  ScrollController custContr = ScrollController();
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();  // Инициализируем контроллер

  getData() async {
    setState(() {
    });

  }
  void _onScroll() {
    if (!_topSafe && custContr.position.pixels > 300) {
      setState(() {
        _topSafe = true;
      });
    }
    if (_topSafe && custContr.position.pixels < 300) {
      setState(() {
        _topSafe = false;
        _carouselController.jumpToPage(_currentIndex);
      });
    }
  }
  Future<void> _showResultDialog(DeliveryCreateResponse response) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MessageFromServerWidget(data: response,);
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    custContr.addListener(_onScroll);
    getData();

  }
  @override
  Widget build(BuildContext context) {
    double _width= MediaQuery.of(context).size.width;
    print(_topSafe);
    return CustomScrollView(
      controller: custContr,
      slivers: [
        SliverToBoxAdapter(
          child:  GestureDetector(
            onTap: ()=>null,
            child: Container(
              height: 60,
              child: Image.asset('assets/images/logo_for_dark.png'),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16,),
        ),
        SliverToBoxAdapter(
          child: RepaintBoundary(
            child: Container(
              constraints: BoxConstraints(maxWidth: 1280, maxHeight: 200),
              child: CarouselSlider.builder(
                itemCount: bannersController.banners.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    //width: 500,
                    height: 200,
                    child: GestureDetector(
                      onTap: () {
                        showBannersResponsiveDialog(context, index);
                        // Добавьте логику для обработки нажатий
                      },
                      child: AnimatedGradientBorderContainer(
                        borderRadius: 12,
                        borderWidth: 8,
                        backgroundImage: NetworkImage(
                          bannersController.banners[index].imageLinkPreview!,
                        ),
                        child: Container(
                          // margin: EdgeInsets.all(5),
                          // alignment: Alignment.bottomCenter,
                          // child: Text(
                          //   bannersController.banners[index].name,
                          //   style: _width>700?themData.textTheme.headlineLarge:themData.textTheme.headlineSmall,
                          //   textAlign: TextAlign.center,
                          // ),
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  viewportFraction: 0.6,
                ),
              ),
            ),
          ),
        ),
        SliverAppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          pinned: true,
          expandedHeight: 200,
          backgroundColor: _topSafe?Colors.black.withOpacity(0.7):Colors.transparent,
          flexibleSpace:RepaintBoundary(
            child: Container(
             // margin: const EdgeInsets.only(right: 10, left: 10),
              constraints: const BoxConstraints(
                maxWidth: 1280,
                maxHeight: 290,
              ),
              child: CarouselSlider.builder(
                carouselController: _carouselController,  // Передаем контроллер
                itemCount: menuController.menu.value.groups.where((element)=>element.enabled==true).length,
                itemBuilder: (context, index, realIndex) {
                  bool isSelected = index == _currentIndex;
                  return GestureDetector(
                    onTap: () {
                      _carouselController.animateToPage(index);  // Используем контроллер для переключения страницы
                      menuController.selectedCategoryGuid.value=menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].guidId;
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 5,right: 5),
                      //margin: const EdgeInsets.only(right: 16),
                      width: _width*0.8,
                      child: Stack(
                        children: [
                          if(_topSafe==false) Container(
                            margin: EdgeInsets.only(bottom: 45),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.transparent),
                            ),
                            width:  _width*0.9,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4), // Совпадает с borderRadius контейнера
                              child: Image.network(
                                menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].imageLinkFromExternalSystem,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return CircularProgressIndicator();
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].imageLinkFromExternalSystem,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return CircularProgressIndicator();
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/logo_for_dark.png',
                                        width: 170,
                                      );
                                    },
                                  );
                                },
                                fit: BoxFit.fitWidth,
                                color: isSelected ? null : Colors.black.withOpacity(0.5),
                                colorBlendMode: isSelected ? null : BlendMode.darken,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom:_topSafe?10: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,

                              // decoration: _topSafe?BoxDecoration(
                              //   gradient: LinearGradient(
                              //     colors: <Color>[
                              //       Color.fromRGBO(220, 53, 42, 1),  // rgba(220, 53, 42, 1)
                              //       Color.fromRGBO(255, 214, 10, 1), // rgba(255, 214, 10, 1)
                              //     ],
                              //     begin: Alignment.topLeft,
                              //     end: Alignment.bottomRight,
                              //   ),
                              //   borderRadius: BorderRadius.circular(16),
                              // ):BoxDecoration(),
                              child: isSelected
                                  ? (_topSafe==false?Container(
                                child:GradientText(
                                menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].name,
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    Color.fromRGBO(220, 53, 42, 1),  // rgba(220, 53, 42, 1)
                                    Color.fromRGBO(255, 214, 10, 1), // rgba(255, 214, 10, 1)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                sizeFont: 14,
                              ),):GradientBorderContainer(child: GradientText(
                                menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].name,
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    Color.fromRGBO(220, 53, 42, 1),  // rgba(220, 53, 42, 1)
                                    Color.fromRGBO(255, 214, 10, 1), // rgba(255, 214, 10, 1)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                sizeFont: 14,
                              ), backendColor: Colors.black))
                                  : Container(
                                height: 40,
                                alignment:Alignment.center,
                                padding: EdgeInsets.all(5),
                                decoration:_topSafe?BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white, // Белый цвет границы
                                    width: 2.0, // Ширина границы
                                  ),
                                    borderRadius: BorderRadius.circular(12),
                                ):BoxDecoration(),
                                child: Text(
                                  menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].name,
                                  style: themData.textTheme.labelSmall,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 200,
                  enlargeFactor: _topSafe?0.1:0.2,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  aspectRatio: 16 / 9,
                  viewportFraction:_topSafe?0.4: 0.5,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                    menuController.selectedCategoryGuid.value=menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].guidId;
                  },
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ProductTable(),
        )
      ],
    );
  }
}