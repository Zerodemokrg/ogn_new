import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ogn/main.dart';
import 'package:ogn/ui/themes/defaultTheme.dart';

import '../../../models/models.dart';


class ProductContainer extends StatefulWidget{
  final Product product;
  ProductContainer({ required this.product,});
  @override
  _ProductContainerState createState()=>new _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer>{
  bool isLoaded=true;
  getData()async{
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context){
    return LayoutBuilder(builder: (context,constraints){
      double _width= MediaQuery.of(context).size.width ;
      return Container(
        height: 425,
       // color: themData.scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: 250,
              child: Stack(
                children: [
                  Container(
                      alignment: Alignment.topCenter,

                      child:  ClipRRect(
                        borderRadius: BorderRadius.circular(16), // Для изображения

                        child: Image.network(
                          widget.product.imageLink,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return CircularProgressIndicator();
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              widget.product.imageLinkFromExternalSystem,
                              fit: BoxFit.fill,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return CircularProgressIndicator();
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/logo_for_dark.png',
                                );
                              },
                            );
                          },
                          fit: BoxFit.fill,
                        ),
                      )
                  ),
                  if(recommendationController.recommendation.where((element)=>element.guidProductId==widget.product.parentGuid).isNotEmpty)
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 70,
                          height: 50,
                          child: Image.asset('assets/images/hit.png'),
                        )
                    )

                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(widget.product.name,style: themData.textTheme.headlineSmall,),
            const SizedBox(
              height: 4,
            ),
            Text(widget.product.description,maxLines: 3,overflow: TextOverflow.ellipsis,style: themData.textTheme.bodySmall),
            const SizedBox(
              height: 4,
            ),
            GradientText(
              "${widget.product.sizePrice.first.price.currentPrice} ₸",
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
            //Text("${widget.product.sizePrice.first.price.currentPrice} ₸",style: themData.textTheme.headlineSmall,)
          ],
        )
      );
    });
  }
}



/*
Container(
        height: 425,
       // color: themData.scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 250,
              child: Stack(
                children: [
                  Image.network(
                    widget.product.imageLink,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        widget.product.imageLinkFromExternalSystem,
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
                  ),
                  if(recommendationController.recommendation.where((element)=>element.guidProductId==widget.product.parentGuid).isNotEmpty)
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                            width: 70,
                            height: 50,
                            child: Image.asset('assets/images/hit.png'),
                        )
                    )

                ],
              )
            ),
            Text(widget.product.name,style: themData.textTheme.headlineSmall,),
            const SizedBox(
              height: 4,
            ),
            Text(widget.product.description,maxLines: 3,overflow: TextOverflow.ellipsis,style: themData.textTheme.bodySmall),
            const SizedBox(
              height: 4,
            ),
            GradientText(
              "${widget.product.sizePrice.first.price.currentPrice} ₸",
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
            //Text("${widget.product.sizePrice.first.price.currentPrice} ₸",style: themData.textTheme.headlineSmall,)
          ],
        )
      );
 */