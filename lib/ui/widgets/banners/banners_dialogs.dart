import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ogn/ui/themes/defaultTheme.dart';

import '../../../main.dart';
import 'banner_container.dart';
class BannersDialogWidget extends StatefulWidget {
  final int indexBanner;
  BannersDialogWidget({required this.indexBanner});
  @override
  _BannersDialogWidgetState createState() => _BannersDialogWidgetState();
}

class _BannersDialogWidgetState extends State<BannersDialogWidget> {
  @override
  Widget build(BuildContext context) {
    double _width= MediaQuery.of(context).size.width ;
    return _width>770?LayoutBuilder(
      builder: (context, constraints) {
        // Определяем максимальные размеры
        double maxWidth = 1280.0;
        // Определяем фактические размеры с учетом максимальных ограничений
        double width = constraints.maxWidth * 0.6;
        double height = constraints.maxHeight;
        if (width > maxWidth) width = maxWidth;

        return Dialog(
          backgroundColor: Colors.transparent, // Установка фона диалога как прозрачный
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: height*0.9,
            // constraints: BoxConstraints(maxWidth: 1280, maxHeight: 200),

            child: CarouselSlider.builder(
              itemCount: bannersController.banners.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  color: Colors.black,
                  margin: EdgeInsets.all(10),
                  child: AnimatedGradientBorderContainer(
                    borderRadius: 16, borderWidth: 5,
                    backgroundImage:  NetworkImage(
                        ""
                    ),
                    child: Container(
                      color: Colors.black,
                      child: Image.network(
                        bannersController.banners[index].imageLink!,fit: BoxFit.contain,
                      ),
                    )
                  ),
                );
                // return Container(
                //   height: height*0.9,
                //   width: width*0.5,
                //   margin: EdgeInsets.all(10),
                //
                //   child: GestureDetector(
                //     onTap: () {
                //       // Логика для обработки нажатий
                //     },
                //     child: Image.network(
                //       bannersController.banners[index].imageLink!,fit: BoxFit.fill,
                //     ),
                //   ),
                // );
              },
              options: CarouselOptions(
                aspectRatio:1/3,
                initialPage: widget.indexBanner,
                enlargeCenterPage:true,
                height: height*0.9,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                viewportFraction: 0.6,
              ),
            ),
          ),
        );
      },
    ):LayoutBuilder(
      builder: (context, constraints) {
        // Определяем максимальные размеры
        // Определяем фактические размеры с учетом максимальных ограничений
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        return Container(
          // backgroundColor: Colors.transparent, // Установка фона диалога как прозрачный
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
          child: Container(
            height: height,
            // constraints: BoxConstraints(maxWidth: 1280, maxHeight: 200),

            child: Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: bannersController.banners.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(

                      child: AnimatedGradientBorderContainer(
                        borderRadius: 0, borderWidth: 5,
                        backgroundImage:  NetworkImage(
                            ""
                        ), child: ClipRRect(
                        //borderRadius: BorderRadius.circular(16),
                        child: Container(
                          color:Colors.black,
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Image.network( bannersController.banners[index].imageLink!,fit: BoxFit.contain,),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                alignment: Alignment.bottomCenter,
                                child: Text(bannersController.banners[index].name,style: themData.textTheme.bodyLarge,),
                              ),
                            ],
                          )
                        )
                      ),
                      ),
                    );
                    // return Container(
                    //   height: height*0.9,
                    //   width: width*0.5,
                    //   margin: EdgeInsets.all(10),
                    //
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       // Логика для обработки нажатий
                    //     },
                    //     child: Image.network(
                    //       bannersController.banners[index].imageLink!,fit: BoxFit.fill,
                    //     ),
                    //   ),
                    // );
                  },
                  options: CarouselOptions(
                    scrollDirection: _width<770?Axis.vertical:Axis.horizontal,
                    initialPage: widget.indexBanner,
                    enlargeCenterPage:true,
                    height: height,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 4),
                    viewportFraction: 1,
                  ),
                ),

                if(_width<770)Positioned(
                  left: 15,top: 15, child: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.close,color: Colors.white,)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
