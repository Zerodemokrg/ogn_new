import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../main.dart';
import '../../themes/defaultTheme.dart';
import '../dialogs.dart';
import 'banner_container.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BannersWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        constraints: BoxConstraints(maxWidth: 1280, maxHeight: 200),
        child: CarouselSlider.builder(
          itemCount: bannersController.banners.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: EdgeInsets.all(10),
              width: 350,
              height: 200,
              child: GestureDetector(
                onTap: () {
                  showBannersResponsiveDialog(context, index);
                  // Добавьте логику для обработки нажатий
                },
                child: AnimatedGradientBorderContainer(
                  borderRadius: 12,
                  borderWidth: 8,
                  backgroundImage: CachedNetworkImageProvider(
                    bannersController.banners[index].imageLinkPreview!,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      bannersController.banners[index].name,
                      style: themData.textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            viewportFraction: 0.3,
          ),
        ),
      ),
    );
  }
}
// class BannersWidget extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(maxWidth: 1280, maxHeight: 200),
//       child: CarouselSlider.builder(
//         itemCount: bannersController.banners.length,
//         itemBuilder: (context, index, realIndex) {
//           return Container(
//             margin: EdgeInsets.all(10),
//             width: 350,
//             height: 200,
//             child: GestureDetector(
//               onTap: () {
//                 // Добавьте логику для обработки нажатий
//               },
//               child: AnimatedGradientBorderContainer(
//                 borderRadius: 12,
//                 borderWidth: 8,
//                 backgroundImage:
//                 NetworkImage(bannersController.banners[index].imageLinkPreview!),
//                 child: Container(
//                   margin: EdgeInsets.all(5),
//                   alignment: Alignment.bottomCenter,
//                   child: Text(
//                     bannersController.banners[index].name,
//                     style: themData.textTheme.headlineLarge,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//         options: CarouselOptions(
//           height: 200,
//           autoPlay: true,
//           autoPlayInterval: Duration(seconds: 5),
//           //enlargeCenterPage: true,
//           viewportFraction: 0.3, // регулируйте, чтобы увеличить или уменьшить центральный элемент
//         ),
//       ),
//     );
//   }
// }