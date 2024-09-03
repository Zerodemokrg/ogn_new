
import 'package:cached_network_image/cached_network_image.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    double _width= MediaQuery.of(context).size.width ;
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: orderController.order.value.positions.length,
      itemBuilder: (context, index) {
        Position pos = orderController.order.value.positions[index];
        return Container(
          height: 282,
          margin: EdgeInsets.only(top:0),
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
                              child: CachedNetworkImage(
                                imageUrl: menuController.menu.value.products.firstWhere((element) => element.guidId == pos.productId).imageLink,
                                fit: BoxFit.cover, // Масштабируем изображение без искажения
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) {
                                  return CachedNetworkImage(
                                    imageUrl: menuController.menu.value.products.firstWhere((element) => element.guidId == pos.productId).imageLinkFromExternalSystem,
                                    fit: BoxFit.cover, // Масштабируем изображение без искажения
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Image.asset('assets/images/logo_for_dark.png'),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(child: Container(
                            margin: EdgeInsets.only(top: 20),
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
                                  style: _width>770?themData.textTheme.displayLarge:themData.textTheme.displayMedium,
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
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            alignment: Alignment.centerRight,
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
                  Container(
                    margin: EdgeInsets.only(left: 24,right: 24),
                    child:  Divider(
                      color: Color.fromRGBO(51, 51, 51, 1),
                      thickness: 0.3,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container()),
                        Expanded(
                          flex: _width>770?1: 2,
                            child: Container(
                              child: Row(
                                children: [
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
                                  Expanded(
                                      flex:_width>770?3:4,
                                      child: Container(
                                    margin: EdgeInsets.only(right: 24),
                                    alignment: Alignment.centerRight,
                                    child: Obx((){
                                      return Text(
                                        "${orderController.order.value.positions.firstWhere((element)=>element==pos).positionPrice!*pos.count!} ₸",
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
  }
}