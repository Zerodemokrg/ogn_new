import 'package:flutter/material.dart';
import 'package:ogn/ui/themes/defaultTheme.dart';
import 'package:url_launcher/url_launcher.dart';


class KaspiPayWidget extends StatefulWidget{
  String kaspiUrl;
  KaspiPayWidget({required this.kaspiUrl});
  @override
  _KaspiPayWidgetState createState()=>new _KaspiPayWidgetState(kaspiUrl: kaspiUrl);
}

class _KaspiPayWidgetState extends State<KaspiPayWidget>{
  String kaspiUrl;
  _KaspiPayWidgetState({required this.kaspiUrl});
  bool isLoaded=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Dialog(
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45.0),
      ),
      alignment: Alignment.center,
      child: Container(
        color: themData.scaffoldBackgroundColor,

        constraints: BoxConstraints(
          maxHeight: 200, // Ма
          maxWidth: 300,// ксимальная высота содержимого
        ),
        alignment: Alignment.center,
        child:  ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    //side: const BorderSide(color: Colors.green)
                  )
              )
          ),
          onPressed: ()async{
            await launch(kaspiUrl);
            Navigator.of(context).pop();
          },
          child: Text("Перейти к оплате",style: themData.textTheme.displayMedium,),
        ),
      ),
    );
  }
}