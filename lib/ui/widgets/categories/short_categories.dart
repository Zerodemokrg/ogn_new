import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../main.dart';
import '../../themes/defaultTheme.dart';

class ShortCategoresWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _ShortCategoresWidgetState createState() => _ShortCategoresWidgetState();
}

class _ShortCategoresWidgetState extends State<ShortCategoresWidget> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();  // Инициализируем контроллер
  @override
  Widget build(BuildContext context) {
    double _width= MediaQuery.of(context).size.width ;
    return RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        constraints: const BoxConstraints(
          maxWidth: 1280,
          maxHeight: 290,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          //carouselController: _carouselController,  // Передаем контроллер
          itemCount: menuController.menu.value.groups.where((element)=>element.enabled==true).length,
          itemBuilder: (context, index) {
            bool isSelected = index == _currentIndex;
            return GestureDetector(
              onTap: () {
                menuController.selectedCategoryGuid.value=menuController.menu.value.groups.where((element)=>element.enabled==true).toList()[index].guidId;
              },
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                width: _width*0.8,
                child: Stack(
                  children: [
                    Container(
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}





