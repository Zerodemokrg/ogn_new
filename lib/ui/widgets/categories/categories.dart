import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../main.dart';
import '../../themes/defaultTheme.dart';

class CategoriesWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();  // Инициализируем контроллер
  @override
  Widget build(BuildContext context) {
    double _width= MediaQuery.of(context).size.width ;
    return _width>770?RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.only(right: 60, left: 60),
        constraints: const BoxConstraints(
          maxWidth: 1280,
          maxHeight: 284,
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
                margin: const EdgeInsets.only(right: 16),
                width: 240,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.transparent),
                      ),
                      width: 240,
                      height: 170,
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
                          fit: BoxFit.fill,
                          color: isSelected ? null : Colors.black.withOpacity(0.5),
                          colorBlendMode: isSelected ? null : BlendMode.darken,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: isSelected
                            ? GradientText(
                          menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].name,
                          gradient: const LinearGradient(
                            colors: <Color>[
                              Color.fromRGBO(220, 53, 42, 1),  // rgba(220, 53, 42, 1)
                              Color.fromRGBO(255, 214, 10, 1), // rgba(255, 214, 10, 1)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          sizeFont: 18,
                        )
                            : Text(
                          menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].name,
                          style: themData.textTheme.labelMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 240,
            enlargeFactor: 0.2,
            enlargeCenterPage: true,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 3),
            aspectRatio: 16 / 9,
            viewportFraction: _width>700?0.27:0.65,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
              menuController.selectedCategoryGuid.value=menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].guidId;
            },
          ),
        ),
      ),
    ):RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
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
                margin: const EdgeInsets.only(right: 16),
                width: _width*0.8,
                child: Stack(
                  children: [
                    Container(
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
                          fit: BoxFit.fitHeight,
                          color: isSelected ? null : Colors.black.withOpacity(0.5),
                          colorBlendMode: isSelected ? null : BlendMode.darken,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: isSelected
                            ? GradientText(
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
                        )
                            : Text(
                          menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].name,
                          style: themData.textTheme.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 200,
            enlargeFactor: 0.2,
            enlargeCenterPage: true,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 3),
            aspectRatio: 16 / 9,
            viewportFraction: 0.5,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
              menuController.selectedCategoryGuid.value=menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].guidId;
            },
          ),
        ),
      ),
    );
  }
}





