
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../models/models.dart';
import '../../themes/defaultTheme.dart';

class PositionTableWidget extends StatefulWidget{

  @override
  _PositionTableWidgetState createState()=>new _PositionTableWidgetState();
}

class _PositionTableWidgetState extends State<PositionTableWidget>{
  bool isLoaded=true;
  getData()async{

  }
  int getPositionSum(Position pos){
    int result=0;
    result=menuController.menu.value.products.firstWhere((element) => element.guidId==pos.productId).sizePrice.first.price.currentPrice.toInt()*pos.count!;
    for (var mod in pos.positionItems!){
      result=result+(menuController.menu.value.products.firstWhere((element) => element.guidId==mod.modifierId!).sizePrice.first.price.currentPrice.toInt()*mod.count!)*pos.count!;
    }
    return result;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    double _width= MediaQuery.of(context).size.width ;
    return Obx((){
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: orderController.order.value.positions.length,
        itemBuilder: (context, index) {
          Position pos = orderController.order.value.positions[index];
          return Container(
            height: _width>770?282:255,
            margin: EdgeInsets.only(top:5),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(51, 51, 51, 1), width: 0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  Obx((){
                    return ListTile(
                      contentPadding: EdgeInsets.all(10), // Устанавливаем padding для контента
                      title:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _width>770?160:120, // Задаем ширину контейнера
                            height: _width>770?160:120, // Задаем высоту контейнера
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                menuController.menu.value.products.firstWhere((element) => element.guidId == pos.productId).imageLink,
                                fit: BoxFit.cover, // Масштабируем изображение без искажения
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    // Изображение загружено
                                    return child;
                                  }
                                  // Отображаем индикатор загрузки
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  // Если основное изображение не загружается, пробуем альтернативный источник
                                  return Image.network(
                                    menuController.menu.value.products.firstWhere((element) => element.guidId == pos.productId).imageLinkFromExternalSystem,
                                    fit: BoxFit.cover, // Масштабируем изображение без искажения
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        // Изображение из альтернативного источника загружено
                                        return child;
                                      }
                                      // Отображаем индикатор загрузки
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      // Если оба изображения не загрузились, показываем локальное изображение
                                      return Image.asset(
                                        'assets/images/logo_for_dark.png',
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(child: Container(
                            alignment: Alignment.topLeft,
                            // margin: EdgeInsets.only(top: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  localSettingsController.selectLanguage.value == "RU"
                                      ? menuController.menu.value.products.firstWhere((element) => element.guidId == pos.productId).name
                                      : (localSettingsController.selectLanguage.value == "KZ"
                                      ? menuController.menu.value.products.firstWhere((element) => element.guidId == pos.productId).nameQaz
                                      : menuController.menu.value.products.firstWhere((element) => element.guidId == pos.productId).nameEnglish),
                                  style: _width>770?themData.textTheme.labelMedium:themData.textTheme.bodyLarge,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                if( pos.positionItems.isNotEmpty==true)
                                  Wrap(
                                    spacing: 16,
                                    children: [
                                      for (var mod in pos.positionItems)
                                        Text(
                                          localSettingsController.selectLanguage.value=="RU"?menuController.menu.value.products.firstWhere((element)=>element.guidId==mod.modifierId).name:(localSettingsController.selectLanguage.value=="KZ"?menuController.menu.value.products.firstWhere((element)=>element.guidId==mod.modifierId).nameQaz:menuController.menu.value.products.firstWhere((element)=>element.guidId==mod.modifierId).nameEnglish),
                                          style: TextStyle(color: greenThemeColor,fontSize: _width>770?18:14),)
                                    ],
                                  )
                              ],
                            ),
                          ),),
                          if(menuController.deliveriesProducts.value.contains(pos.productId)==false) Container(
                            // margin: EdgeInsets.only(top: 30),
                            alignment: Alignment.topRight,
                            child: IconButton(onPressed: (){
                              setState(() {
                                orderController.order.value.positions.remove(pos);
                                orderController.changeOrder();
                              });
                            }, icon: Icon(Icons.restore_from_trash,color: Colors.white,)),
                          )
                        ],
                      ),
                    );
                  }),
                  if(menuController.deliveriesProducts.value.contains(pos.productId)==false) Container(
                    margin: EdgeInsets.only(left: 24,right: 24),
                    child:  Divider(
                      color: Color.fromRGBO(51, 51, 51, 1),
                      thickness: 0.3,
                    ),
                  ),
                  if(menuController.deliveriesProducts.value.contains(pos.productId)==false) SizedBox(
                    height: _width>770?16:5,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        if(menuController.deliveriesProducts.value.contains(pos.productId)==false) Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(child: Container()),
                                  Expanded(
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      margin: EdgeInsets.only(left:_width>770?15:0),
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: primaryColor,
                                          ),
                                          child: Icon(Icons.remove,color:Colors.white),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            if (pos.count==1){
                                              orderController.order.value.positions.remove(pos);

                                            }
                                            if (pos.count!>1){
                                              pos.count=pos.count!-1;
                                            }
                                            orderController.changeOrder();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text("${pos.count}",style: themData.textTheme.displayLarge,)
                                    ),),
                                  Expanded(
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      margin: EdgeInsets.only(right:_width>770?15:0),
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: primaryColor,
                                          ),
                                          child: Icon(Icons.add,color:Colors.white),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            pos.count=pos.count!+1;
                                            orderController.changeOrder();

                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Expanded(
                            flex: _width>770?1: 2,
                            child: Container(
                              child: Row(
                                children: [

                                  Expanded(
                                      flex:_width>770?3:4,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 24),
                                        alignment: Alignment.centerRight,
                                        child: Obx((){
                                          return Text(
                                            "${getPositionSum(pos)} ₸",//"${orderController.order.value.positions.firstWhere((element)=>element==pos).positionPrice!*pos.count!} ₸",
                                            style: themData.textTheme.displayLarge,
                                          );
                                        }),
                                      )),
                                ],
                              ),
                            )),

                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}