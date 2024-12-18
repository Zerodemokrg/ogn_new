import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../models/models.dart';


class ProductModifierWidget extends StatefulWidget{
  String mod;
  ProductModifierWidget({required this.mod});
  @override
  _ProductModifierWidgetState createState()=>new _ProductModifierWidgetState(mod: mod);
}

class _ProductModifierWidgetState extends State<ProductModifierWidget>{
  String mod;
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(28, 28, 30, 1),
          image: (menuController.menu.value.products.firstWhere((element) => element.guidId==mod).imageLinkFromExternalSystem!="")?DecorationImage(image: NetworkImage(menuController.menu.value.products.firstWhere((element) => element.guidId==mod).imageLinkFromExternalSystem),fit: BoxFit.fill):DecorationImage(image: AssetImage('assets/images/logo_for_dark.png'),fit: BoxFit.contain),
        ),
      ),
    );
  }
}