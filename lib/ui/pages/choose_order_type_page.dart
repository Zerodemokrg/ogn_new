import 'package:flutter/material.dart';
import '../../controllers/intl.dart';
import '../../main.dart';
import '../themes/defaultTheme.dart';
import '../widgets/language_selector.dart';

class ChooseOrderTypePage extends StatefulWidget{
  @override
  _ChooseOrderTypePageState createState()=>new _ChooseOrderTypePageState();
}
class _ChooseOrderTypePageState extends State<ChooseOrderTypePage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context){

    return Center(
      child: Container(
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 180,
            ),
            Image.asset("assets/images/logo.png",height: 340,width: 340),
            Container(
                alignment: Alignment.center,
                child: Obx((){
                  return Text(
                      textAlign: TextAlign.center,
                      localSettingsController.selectLanguage.value=="RU"?welcomeText[0]:(localSettingsController.selectLanguage.value=="KZ"?welcomeText[1]:welcomeText[2]),
                      style:TextStyle(fontSize: 46,fontWeight: FontWeight.w700)
                  );
                })
            ),
            SizedBox(
              height: 43,
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 217,
                  child: ElevatedButton(
                    style: ButtonStyles.whiteButtonStyle,
                    onPressed: (){
                      orderController.changeOrderType("delivery");
                      Get.toNamed('/main');
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        //  SvgPicture.asset("assets/images/deliveryLogo.svg",),
                          const SizedBox(
                            width: 8,
                          ),
                          Obx((){
                            return Text(
                              localSettingsController.selectLanguage.value=="RU"?deliveryText[0]:(localSettingsController.selectLanguage.value=="KZ"?deliveryText[1]:deliveryText[2]),
                              style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 24),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  height: 80,
                  width: 217,
                  child: ElevatedButton(
                    style: ButtonStyles.whiteButtonStyle,
                    onPressed: (){
                      orderController.changeOrderType("pickup");
                      Get.toNamed('/chooseDepartments');
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        //  SvgPicture.asset("assets/images/pickupLogo.svg",),
                          const SizedBox(
                            width: 8,
                          ),
                          Obx((){
                            return Text(
                              localSettingsController.selectLanguage.value=="RU"?pickupText[0]:(localSettingsController.selectLanguage.value=="KZ"?pickupText[1]:pickupText[2]),
                              style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 24),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: LanguageSelector(),
            ),
          ],
        ),
      ),
    );
  }
}