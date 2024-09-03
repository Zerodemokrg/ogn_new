import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ogn/ui/widgets/borderGradientContainer.dart';
import 'package:ogn/ui/widgets/products/productModifierWidget.dart';
import '../../../main.dart';
import '../../../models/models.dart';
import '../../themes/defaultTheme.dart';
import '../widgets.dart';

class ResponsiveDialogWidget extends StatefulWidget {
  final Product product;
  ResponsiveDialogWidget({required this.product});
  @override
  _ResponsiveDialogWidgetState createState() => _ResponsiveDialogWidgetState();
}

class _ResponsiveDialogWidgetState extends State<ResponsiveDialogWidget> {
  String namePrice="Стоимость";
  String nameAdditional="Дополнительно";
  String nameRecommendation="Рекомендации";
  String nameAddToCart="Добавить в корзину";
  Position position=Position(count: 1, positionItems: []);
  bool isLoaded=true;
  List<String> posRecs=[];
  calculatePositionSum(){
    position.positionPrice=widget.product.sizePrice.first.price.currentPrice.toInt();
    for (var item in position.positionItems){
      position.positionPrice=(position.positionPrice! + menuController.menu.value.products.firstWhere((element)=>element.guidId==item.modifierId).sizePrice.first.price.currentPrice.toInt()*item.count!);
    }
    setState(() {
      position.positionPrice=position.positionPrice!*position.count!;
    });
  }
  bool isLock (String guid){
    for (var item in widget.product.modifiers!){
      if (item.guid==guid && (item.required==true||item.minAmount==1)){
        return true;
      }
    }
    return false;
  }
  removePositionItem(String guid){
    setState(() {
      if(position.positionItems!.firstWhere((element) => element.modifierId==guid).count!>1){
        position.positionItems!.firstWhere((element) => element.modifierId==guid).count=position.positionItems!.firstWhere((element) => element.modifierId==guid).count!-1;
      } else {
        position.positionItems!.removeWhere((element) => element.modifierId==guid);
      }

    });
    calculatePositionSum();
  }
  bool canDeletedModifier(String guid){
    for (var item in widget.product.modifiers!){
      if (item.guid==guid&& (item.minAmount>=position.positionItems!.firstWhere((element) => element.modifierId==guid).count!)){
        return false;
      }
    }
    for (var gr in widget.product.groupModifier!){
      if (gr.guid==position.positionItems?.firstWhere((element) => element.modifierId==guid).groupId){
        if(gr.minAmount>=position.positionItems!.where((element) => element.groupId==gr.guid).length){
          return false;
        }
      }
    }

    return true;
  }
  checkRequriedGroupModifierInPosition(String guid){
    int min=0;
    if (position.positionItems!.where((element) => element.groupId==guid).length<widget.product.groupModifier!.firstWhere((element) => element.guid==guid).minAmount){
      min=widget.product.groupModifier!.firstWhere((element) => element.guid==guid).minAmount-position.positionItems!.where((element) => element.groupId==guid).length;
      if (min>0){
        for (var groupMod in widget.product.groupModifier!.firstWhere((element) => element.guid==guid).childModifiers){
          if (position.positionItems!.where((element) => element.groupId==guid).length<min){
            setState(() {
              PositionItem pos=PositionItem(modifierId: groupMod.guid,groupId: widget.product.groupModifier!.firstWhere((element) => element.guid==guid).guid,count: 1);
              position.positionItems?.add(pos);
            });
          }
        }
      }
    }
  }
  checkRequriedModifierInPosition(String guid){
    int min=0;
    min=widget.product.modifiers!.firstWhere((element) => element.guid==guid).minAmount;
    if (position.positionItems!.where((element) => element.modifierId==guid).length<min)
    {
      PositionItem pos=PositionItem(modifierId: guid,groupId: "",count: 1);
      position.positionItems?.add(pos);
    }
  }
  bool checkModifierInPositions(String guid){
    for (var item in position.positionItems!){
      if (item.modifierId==guid){
        return true;
      }
    }
    return false;
  }
  getData()async {
    setState(() {
      widget.product.modifiers ??= [];

      widget.product.groupModifier ??= [];

      position.productId= widget.product.guidId;

      position.count=1;


      position.positionItems=[];

      for (var g in  widget.product.groupModifier!){
        checkRequriedGroupModifierInPosition(g.guid);
      }

      for (var g in  widget.product.modifiers!){
        checkRequriedModifierInPosition(g.guid);
      }

      calculatePositionSum();
      print("count mods:${widget.product.modifiers?.length}");
      isLoaded=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    print(_width);
    return LayoutBuilder(
      builder: (context, constraints) {
        // Определяем максимальные размеры
        double maxWidth = 1200.0;
        //double maxHeight = 400.0;
        // Определяем фактические размеры с учетом максимальных ограничений
        double width = constraints.maxWidth * 0.8;
        double height = constraints.maxHeight * 0.8;
        if (width > maxWidth) width = maxWidth;
        // if (height > maxHeight) height = maxHeight;
        return Dialog(
          backgroundColor: themData.scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(5.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                             width: double.infinity,
                             height: height*0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(
                              //   color: Colors.black, // Цвет рамки
                              //   width: 2.0, // Ширина рамки
                              // ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:widget.product.videoLinkPreview==""?CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.product.imageLink,
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) {
                                  return CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:  widget.product.imageLinkFromExternalSystem,
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Image.asset('assets/images/logo_for_dark.png',width: 170,),
                                  );
                                },
                              ): YouTubeVideoPlayer(videoId: widget.product.videoLinkPreview),
                            ),
                          ),
                          Text(
                            widget.product.name,
                            style: TextStyle(fontSize: 28,),
                            maxLines: 2,overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 20),
                          Text(
                            widget.product.description,
                            style: TextStyle(fontSize: 16,),
                            maxLines: 2,overflow: TextOverflow.ellipsis,
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     Navigator.of(context).pop();
                          //   },
                          //   child: Text('Close'),
                          // ),
                        ],
                      ),),
                    if (widget.product.modifiers?.isNotEmpty==true||widget.product.groupModifier?.isNotEmpty==true)
                      Expanded(
                          flex: 2,
                          child: CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child:Column(
                                  children: [
                                    if(widget.product.groupModifier?.isNotEmpty==true)
                                      for(var grmod in widget.product.groupModifier!)
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(menuController.getGroupNameFilteredByLanguage(menuController.menu.value.groups.firstWhere((element) => element.guidId==grmod.guid).guidId),textAlign: TextAlign.left,),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                height:240,
                                                width: width*0.6,
                                                child:
                                                ScrollConfiguration(behavior: MyCustomScrollBehavior(),
                                                  child:  ListView(

                                                    scrollDirection: Axis.horizontal,
                                                    shrinkWrap: true,
                                                    // spacing: 22,
                                                    // runSpacing: 30,
                                                    // alignment: WrapAlignment.center,
                                                    children: [
                                                      for (var mod in grmod.childModifiers)
                                                        Container(
                                                          margin: EdgeInsets.only(right: 10),
                                                          width: 150,
                                                          height: 212,
                                                          child: GestureDetector(
                                                              onTap: (){
                                                                if(position.positionItems!.where((element) => element.modifierId==mod.guid).length==0){
                                                                  if (position.positionItems!.where((element) => element.groupId==grmod.guid).length>=grmod.maxAmount) {
                                                                    removePositionItem(position.positionItems!.firstWhere((element) => element.groupId==grmod.guid).modifierId!);
                                                                  }
                                                                  if (position.positionItems!.where((element) => element.groupId==grmod.guid).length<grmod.maxAmount){
                                                                    setState(() {
                                                                      PositionItem pos=PositionItem(modifierId: mod.guid,groupId: grmod.guid,count: 1);
                                                                      position.positionItems?.add(pos);
                                                                      calculatePositionSum();
                                                                    });
                                                                  }
                                                                } else {
                                                                  if (canDeletedModifier(mod.guid)==true){
                                                                    removePositionItem(mod.guid);
                                                                    calculatePositionSum();
                                                                  }

                                                                }
                                                              },
                                                              child: GradientBorderContainer(
                                                                  gradient:LinearGradient(
                                                                    colors: [
                                                                      Color.fromRGBO(220, 53, 42, 1),  // Красный цвет
                                                                      Color.fromRGBO(255, 214, 10, 1), // Желтый цвет
                                                                    ],
                                                                    begin: Alignment.topLeft,
                                                                    end: Alignment.bottomRight,
                                                                  ),
                                                                  borderWidth: 4.0,
                                                                  child: Column(
                                                                    children: [
                                                                      Stack(
                                                                        children: [
                                                                          Container(
                                                                            margin: EdgeInsets.only(top: 16),
                                                                            height: 120,
                                                                            width: 120,
                                                                            decoration: BoxDecoration(
                                                                              color: Color.fromRGBO(240, 240, 240, 1),
                                                                              shape: BoxShape.rectangle,
                                                                              //   border: Border.all(width: checkModifierInPositions(mod.guid)?3:2,color: checkModifierInPositions(mod.guid)?primaryColor:Colors.grey),
                                                                              borderRadius: BorderRadius.circular(16),
                                                                              //  image: MENU.products!.firstWhere((element) => element.guid==mod.guid).image !=null && MENU.products!.firstWhere((element) => element.guid==mod.guid).image !=''?DecorationImage(image: MemoryImage(base64Decode(MENU.products!.firstWhere((element) => element.guid==mod.guid).image!)),fit: BoxFit.contain):DecorationImage(image: NetworkImage(MENU.products!.firstWhere((element) => element.guid==mod.guid).imageLink),fit: BoxFit.contain),
                                                                            ),
                                                                            child: ProductModifierWidget( mod: mod),
                                                                            // child: Image.memory(base64Decode(menu.products!.firstWhere((element) => element.guid==gr.guid).image!)),
                                                                          ),
                                                                          // checkModifierInPositions(mod.guid)?Positioned(
                                                                          //     top: 0,
                                                                          //     right: 0,
                                                                          //     child: Container(
                                                                          //       decoration: BoxDecoration(
                                                                          //         color: primaryColor,
                                                                          //         borderRadius: BorderRadius.only(
                                                                          //           bottomLeft:  Radius.circular(12),
                                                                          //           topRight: Radius.circular(12),
                                                                          //         ),
                                                                          //         shape: BoxShape.rectangle,
                                                                          //
                                                                          //       ),
                                                                          //       width: 30,
                                                                          //       height: 30,
                                                                          //       child: Icon(Icons.check,color: Colors.white,),
                                                                          //     )
                                                                          // ):Container(),
                                                                        ],
                                                                      ),
                                                                      Text(menuController.getProductNameFilteredByLanguage(menuController.menu.value.products.firstWhere((element) => element.guidId==mod.guid).guidId),maxLines: 1,textAlign: TextAlign.center,style: themData.textTheme.displayMedium,),
                                                                      Text("+${menuController.menu.value.products.firstWhere((element) => element.guidId==mod.guid).sizePrice.first.price.currentPrice} ₸",textAlign: TextAlign.center,style: themData.textTheme.displayMedium,)
                                                                    ],
                                                                  ))
                                                          ),
                                                        ),

                                                    ],
                                                  ),)
                                            )
                                          ],
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child:  Container(
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(child: Container(
                            margin: EdgeInsets.only(right: 15),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    alignment: Alignment.center,
                                    child: GestureDetector(

                                      child: Container(
                                        height: 50,
                                        width: 50,


                                        child: Icon(Icons.remove,color:Colors.white),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (position.count!>1){
                                            position.count=position.count!-1;

                                            calculatePositionSum();
                                          }
                                        });
                                        // setState(() {
                                        //   if (position.count!>1){
                                        //     position.count=position.count!-1;
                                        //     calculatePositionSum();
                                        //   }
                                        // });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text("${position.count}",style: themData.textTheme.labelLarge)
                                  ),),
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    width: 70,
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromRGBO(220, 53, 42, 1),  // Красный цвет
                                              Color.fromRGBO(255, 214, 10, 1), // Желтый цвет
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: Icon(Icons.add),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          position.count = position.count! + 1;
                                          calculatePositionSum();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                //Expanded(child: child)
                              ],
                            ),
                          )),
                          Expanded(
                            flex: 2,
                            child:  ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  orderController.order.value.positions.add(position);
                                  orderController.changeOrder();
                                  // if (menuConfigs.where((element) => element.guidIdProduct==position.productId).length>0){
                                  //   if (order.positions.where((element) => element.productId==menuConfigs.firstWhere((element) => element.guidIdProduct==position.productId).additionalDishesId).length>0){
                                  //     order.positions.firstWhere((element) => element.productId==menuConfigs.firstWhere((element) => element.guidIdProduct==position.productId).additionalDishesId).count=(order.positions.firstWhere((element) => element.productId==menuConfigs.firstWhere((element) => element.guidIdProduct==position.productId).additionalDishesId).count!+menuConfigs.firstWhere((element) => element.guidIdProduct==position.productId).countDishes!*position.count!);
                                  //     order.positions.firstWhere((element) => element.productId==menuConfigs.firstWhere((element) => element.guidIdProduct==position.productId).additionalDishesId).positionPrice=order.positions.firstWhere((element) => element.productId==menuConfigs.firstWhere((element) => element.guidIdProduct==position.productId).additionalDishesId).positionPrice!+MENU.products!.firstWhere((element) => element.guid==menuConfigs.firstWhere((element) => element.guidIdProduct==position.productId).additionalDishesId).price*menuConfigs.firstWhere((element) => element.guidIdProduct==position.productId).countDishes!*position.count!;
                                  //   } else {
                                  //     Position dish=Position(productId: menuConfigs.firstWhere((element) => element.guidIdProduct==position.productId).additionalDishesId,positionItems: [],positionPrice: MENU.products!.firstWhere((element) => element.guid==menuConfigs.firstWhere((element) => element.guidIdProduct==position.productId).additionalDishesId).price*(menuConfigs.firstWhere((element) => element.guidIdProduct==position.productId).countDishes!*position.count!),count: menuConfigs.firstWhere((element) => element.guidIdProduct==position.productId).countDishes!*position.count!);
                                  //     order.positions.add(dish);
                                  //   }
                                  // }
                                });
                                // for (var p in posRecs){
                                //   setState(() {
                                //     Position pos=Position(productId: p,count: 1,positionItems: [],positionPrice: MENU.products!.firstWhere((element) => element.guid==p).price);
                                //     order.positions.add(pos);
                                //   });
                                // }
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                children: [
                                  Expanded(child: Text(nameAddToCart)),
                                  Expanded(child: Container(alignment:Alignment.centerRight,child: Text('${position.positionPrice} ₸'),))
                                ],
                              ),
                            ),)
                        ],
                      )
                  ),
                )
              ],
            )
          ),
        );
      },
    );
  }
}