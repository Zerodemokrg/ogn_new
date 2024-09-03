import 'package:flutter/material.dart';

class CategoryContainer extends StatefulWidget{
  final Widget child;
  CategoryContainer({ required this.child,});
  @override
  _CategoryContainerState createState()=>new _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer>{
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
      return Container();
    });
  }
}