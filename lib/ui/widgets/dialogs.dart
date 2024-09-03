import 'package:flutter/material.dart';
import 'package:ogn/ui/widgets/products/product_window.dart';
import '../../main.dart';
import '../../models/models.dart';
import '../themes/defaultTheme.dart';
import 'banners/banners_dialogs.dart';



void showResponsiveDialog(BuildContext context,Product prod) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ResponsiveDialogWidget(product: prod,);
    },
  );
}




void showBannersResponsiveDialog(BuildContext context,int ind) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BannersDialogWidget(indexBanner: ind,);
    },
  );
}


class MessageFromServerWidget extends StatefulWidget{
  DeliveryCreateResponse data;

  MessageFromServerWidget({required this.data});
  @override
  _MessageFromServerWidgetState createState()=>new _MessageFromServerWidgetState(data:data);
}

class _MessageFromServerWidgetState extends State<MessageFromServerWidget>{
  DeliveryCreateResponse data;
  _MessageFromServerWidgetState({required this.data});
  bool isLoaded=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return  Dialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45.0),
      ),
      alignment: Alignment.center,
      child: Container(
        height: 250,
        constraints: BoxConstraints(

          maxHeight: MediaQuery.of(context).size.height * 0.4, // Ма
          maxWidth: 400,// ксимальная высота содержимого
        ),
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15,right: 15),
              alignment: Alignment.center,
              child: Text(data.message,maxLines: 3,textAlign: TextAlign.center,),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          //side: const BorderSide(color: Colors.green)
                        )
                    )
                ),
                onPressed: (){
                  orderController.order.value=Order(positions: [], sumPrice: 0,deliverySum: 0,orderType: "delivery");
                  Get.toNamed('/main');
                },
                child: Text("OK"))
          ],
        ),
      ),
    );
  }
}

