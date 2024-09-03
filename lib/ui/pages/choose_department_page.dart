import 'package:flutter/material.dart';

import '../../controllers/intl.dart';
import '../../main.dart';
import '../themes/defaultTheme.dart';
import '../widgets/language_selector.dart';

class ChooseDepartmentPage extends StatefulWidget{
  @override
  _ChooseDepartmentPageState createState()=> _ChooseDepartmentPageState();
}

class _ChooseDepartmentPageState extends State<ChooseDepartmentPage>{
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context){
    // double _width= MediaQuery.of(context).size.width ;
    // print(_width);
    return Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10,left: 10),
              child: Image.asset("assets/images/logo.png",width: 170,height: 170,),
            ),
            Center(
              child: Text(
                  localSettingsController.selectLanguage.value=="RU"?chooseDepartmentText[0]:(localSettingsController.selectLanguage.value=="KZ"?chooseDepartmentText[1]:chooseDepartmentText[2]),
                  style:const TextStyle(fontSize: 46,fontWeight: FontWeight.w700)
              ),
            ),
            const SizedBox(
              height: 37,
            ),
            Center(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (var i = 0; i < departmentsController.departments.length; i++)
                    GestureDetector(
                      onTap: () =>  departmentsController.selectDepartment(i),
                      child: Obx((){
                        return Container(
                          height: 136,
                          width: 248,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: departmentsController.selectedIndex.value == i
                                  ? primaryColor// цвет бордюра при выборе
                                  : Colors.grey, // цвет бордюра
                              width: departmentsController.selectedIndex.value == i?2.0:1.0, // ширина бордюра
                            ),
                            borderRadius: BorderRadius.circular(16.0), // радиус скругления углов
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/logo.png",width: 64,height: 64,),
                                      Expanded(child: Container(
                                        margin: const EdgeInsets.only(top: 10,right: 10),
                                        alignment: Alignment.centerRight,
                                        child: Text("24/7",style: Theme.of(context).textTheme.labelMedium, // Применение стиля labelMedium
                                        ),
                                      ),)
                                    ],
                                  )
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin:const EdgeInsets.all(10),
                                  child: Text(
                                    localSettingsController.selectLanguage.value=="RU"?departmentsController.departments[i].address!:(localSettingsController.selectLanguage.value=="KZ"?departmentsController.departments[i].addressQaz??departmentsController.departments[i].address!:departmentsController.departments[i].addressEng??departmentsController.departments[i].address!),
                                    // departmentsController.departments[i].address??"",
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    height: 72,
                    width: 248,
                    child: ElevatedButton(
                        style: ButtonStyles.whiteButtonStyle,
                        onPressed: ()=> Get.toNamed('/'),
                        child:  Row(
                          children: [
                            Icon(Icons.keyboard_arrow_left),
                            Expanded(child:  Text("Вернуться",textAlign: TextAlign.center,),),
                          ],
                        )
                    ),
                  ),
                  SizedBox(width: 16,),
                  Container(
                    height: 72,
                    width: 248,
                    child: ElevatedButton(
                        onPressed: (){},
                        child: Row(
                          children: [
                            Expanded(child:  Text("Начать заказ",textAlign: TextAlign.center,),),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            LanguageSelector(),
            const SizedBox(
              height: 50,
            ),
          ],
        )
    );
  }
}