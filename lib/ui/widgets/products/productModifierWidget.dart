import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../models/models.dart';


class ProductModifierWidget extends StatefulWidget{
  Modifier mod;
  ProductModifierWidget({required this.mod});
  @override
  _ProductModifierWidgetState createState()=>new _ProductModifierWidgetState(mod: mod);
}

class _ProductModifierWidgetState extends State<ProductModifierWidget>{
  Modifier mod;
  _ProductModifierWidgetState({required this.mod});
  Uint8List? img;
  bool isLoaded=true;
  getData()async{
    setState(() {
     // img =base64Decode(menuController.menu.value.products.firstWhere((element) => element.guidId==mod.guid).imageLink!);
      isLoaded=false;
    });
  }
  @override
  void initState() {
    super.initState();
    getData();

  }
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        image: (menuController.menu.value.products.firstWhere((element) => element.guidId==mod.guid).imageLink!="")?DecorationImage(image: NetworkImage(menuController.menu.value.products.firstWhere((element) => element.guidId==mod.guid).imageLink),fit: BoxFit.contain):DecorationImage(image: AssetImage('assets/images/greylogo.png'),fit: BoxFit.contain),
      ),
    );
  }
}