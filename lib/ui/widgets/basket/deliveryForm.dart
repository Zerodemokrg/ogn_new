import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ogn/ui/themes/defaultTheme.dart';
import '../../../configs/urls.dart';
import '../../../controllers/intl.dart';
import '../../../main.dart';
import '../../../models/models.dart';
import '../../../services/external/api.dart';

class ValidClientInfo{
  bool name=true;
  bool phone=true;
  bool address=true;
  bool flat=true;
//ValidClientInfo({});
}

class DeliveryForm extends StatefulWidget{
  @override
  _DeliveryFormState createState()=>new _DeliveryFormState();
}

class _DeliveryFormState extends State<DeliveryForm>{


  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerFlat = TextEditingController();
  TextEditingController _controllerEntrance = TextEditingController();
  TextEditingController _controllerFloor = TextEditingController();
  TextEditingController _controllerDoorPhone = TextEditingController();
  TextEditingController _controllerComment = TextEditingController();
  TextEditingController _textEditingControllerAddress = TextEditingController();

  Timer? _debounceTimer;
  ValidClientInfo checkValid=ValidClientInfo();
  List<AddressItem> addresses=[];
  AddressItem? SelectedAddres;
  List<String> posRecs=[];
  int? SelectedDepartmentId;
  int range=0;
  bool isPushedButton=false;
  double degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }
  int distanceInAir(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusKm = 6371.0; // Средний радиус Земли в километрах

    double dLat = degreesToRadians(lat2 - lat1);
    double dLon = degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degreesToRadians(lat1)) * cos(degreesToRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadiusKm * c;
    return (distance*1000).toInt();
  }

  int GetNearestDepId(AddressItem start){
    int result=-1;
    int resultId=-1;
    print("количество филиалов:${departmentsController.departments.where((element) => element.working==true  && CheckBasketInDep(element.id!)==true).length}");

    print("количество филиалов которые могут приготовить:${departmentsController.departments.where((element) => element.working==true && CheckBasketInDep(element.id!)==true ).length}");
    for (var dep in departmentsController.departments.where((element) => element.working==true && CheckBasketInDep(element.id!)==true)){
      if (result==-1){
        result=distanceInAir(start.point.lat, start.point.lon, dep.latitude!,dep.longitude!);
        print("dep id: ${dep.id} distance on air:$result");
      }
      if (result!=-1){
        int distance=distanceInAir(start.point.lat, start.point.lon, dep.latitude!,dep.longitude!);
        if (distance<=result){
          result=distance;
          resultId=dep.id!;
        }
      }
    }
    print("dep ID is : $resultId");
    return resultId;
  }
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
    double _width= MediaQuery.of(context).size.width;

    return Container(
      child: Obx((){
        return Column(
          children: [
            // Container(
            //   margin: EdgeInsets.only(left:15,right:15,bottom: 10),
            //   child: Text(nameCustomerInfo),
            // ),
            Container(
              padding: EdgeInsets.all(25),
              child: TextFormField(
                controller: _controllerName,
                decoration:  InputDecoration(
                  errorText:  checkValid.name==false?(localSettingsController.selectLanguage.value=="RU"?nameNameFailInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameNameFailInForm[1]:nameNameFailInForm[2])):null,
                  filled: true,
                  fillColor: Colors.black,
                  labelText: localSettingsController.selectLanguage.value=="RU"?nameNameInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameNameInForm[1]:nameNameInForm[2]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  floatingLabelStyle: themData.textTheme.displaySmall,
                ),
                onChanged: (text){
                  //order.clientName=text;
                  setState(() {
                    _controllerName.text=text;
                    _controllerName.selection = TextSelection.fromPosition(
                      TextPosition(offset: _controllerName.text.length),
                    );
                    if(_controllerName.text.length>0){
                      checkValid.name=true;
                    }
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(),
              padding: EdgeInsets.all(25),
              child: TextFormField(

                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.phone,
                controller: _controllerPhone,
                decoration: new InputDecoration(
                  errorText:  checkValid.phone==false?localSettingsController.selectLanguage.value=="RU"?namePhoneFailInForm.first:(localSettingsController.selectLanguage.value=="KZ"?namePhoneFailInForm[1]:namePhoneFailInForm[2]):null,
                  filled: true,
                  fillColor: Colors.black,
                  labelText: localSettingsController.selectLanguage.value=="RU"?namePhoneInForm.first:(localSettingsController.selectLanguage.value=="KZ"?namePhoneInForm[1]:namePhoneInForm[2]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (text){
                  setState(() {
                    //   order.clientPhone=text;
                    _controllerPhone.text="+"+text;
                    _controllerPhone.selection=TextSelection.fromPosition(
                      TextPosition(offset: _controllerPhone.text.length),
                    );
                    if (_controllerPhone.text.length==12){
                      checkValid.phone=true;
                    } else {
                      checkValid.phone=false;
                    }
                  });
                },
              ),
            ),
            if (orderController.order.value.orderType=="delivery")  Container(
              margin: EdgeInsets.only(),
              padding: EdgeInsets.all(25),
              child:  Autocomplete<AddressItem>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  final inputText = textEditingValue.text.toLowerCase();
                  // Здесь вам нужно определить список вариантов, основанных на введенном тексте textEditingValue.text
                  // и вернуть его в качестве результата

                  final filteredAddresses=addresses.where((element) =>element.address_name!="" );
                  setState(() {
                    if (filteredAddresses.length==0){
                      checkValid.address=false;
                    }  else {
                      checkValid.address=true;
                    }
                  });
                  return filteredAddresses;
                },
                displayStringForOption: (AddressItem option)=>option.address_name,
                onSelected: (AddressItem location) async {
                  setState(() {
                    if (location.address_name.contains('/')){
                      List<String> parts=location.address_name.split('/');

                      bool containsOnlyDigits = parts[1].contains(RegExp(r'^[0-9]+$'));

                      if (containsOnlyDigits) {

                        _textEditingControllerAddress.text = location.address_name;
                      } else {
                        _textEditingControllerAddress.text = location.address_name;
                        location.address_name=parts[0];

                      }



                    } else {
                      _textEditingControllerAddress.text = location.address_name;
                    }
                    SelectedAddres=location;
                    checkValid.address=true;
                  });

                  SelectedDepartmentId=GetNearestDepId(SelectedAddres!);
                  CalculateDistanceRequest req=CalculateDistanceRequest(idDepartment: SelectedDepartmentId!, startPoint: SelectedAddres!.point);

                  int res=await API.postCalculateDistance(req, MainConfig().getDeliveryPriceUrl);
                  range=res;
                },
                fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                  // Здесь вы возвращаете оригинальный виджет TextFormField
                  return TextFormField(
                    controller: _textEditingControllerAddress,//test,
                    focusNode: focusNode,
                    onFieldSubmitted: (value) {
                      onFieldSubmitted();
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      errorText:  checkValid.address==false?localSettingsController.selectLanguage.value=="RU"?nameAddressFailInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameAddressFailInForm[1]:nameAddressFailInForm[2]):null,
                      filled: true,
                      fillColor: Colors.black,
                      labelText: localSettingsController.selectLanguage.value=="RU"?nameAddressFailInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameAddressFailInForm[1]:nameAddressFailInForm[2]),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onChanged: (text) async {
                      setState(() {
                        checkValid.address=false;
                      });

                      if (text.length>2){
                        _debounceTimer?.cancel();

                        // Создаем новый таймер, который вызовет функцию через 3 секунды
                        _debounceTimer = Timer(Duration(milliseconds: 800), () async {
                          // Ваш код функции, которую хотите вызвать
                          var resAddress=await API.getAddressNames(text);
                          addresses=resAddress;
                          textEditingController.text=text;

                        });
                      }

                      // Здесь обрабатывается событие изменения текста
                      // Можно использовать onChanged или onFieldSubmitted, как вам удобнее
                    },
                  );
                },
              ),
            ),
            if (orderController.order.value.orderType=="delivery" &&_width>770) Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child:  Container(
                        margin: EdgeInsets.only(),
                        padding: EdgeInsets.all(25),
                        child: TextFormField(
                          controller: _controllerFlat,
                          decoration: new InputDecoration(
                            errorText:  checkValid.flat==false?localSettingsController.selectLanguage.value=="RU"?nameApartmentInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameApartmentInForm[1]:nameApartmentInForm[2]):null,
                            filled: true,
                            fillColor: Colors.black,
                            labelText: localSettingsController.selectLanguage.value=="RU"?nameApartmentInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameApartmentInForm[1]:nameApartmentInForm[2]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (text){
                            setState(() {
                              _controllerFlat.text=text;
                              _controllerFlat.selection=TextSelection.fromPosition(
                                TextPosition(offset: _controllerFlat.text.length),
                              );
                              if (_controllerFlat.text.length>0){
                                checkValid.flat=true;
                              } else {

                                checkValid.flat=false;
                              }
                            });

                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child:  Container(
                        margin: EdgeInsets.only(),
                        padding: EdgeInsets.all(25),
                        child: TextFormField(
                          controller: _controllerEntrance,
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: Colors.black,
                            labelText: localSettingsController.selectLanguage.value=="RU"?nameEntranceInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameEntranceInForm[1]:nameEntranceInForm[2]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (text){
                            setState(() {
                              _controllerEntrance.text=text;
                              _controllerEntrance.selection=TextSelection.fromPosition(
                                TextPosition(offset: _controllerEntrance.text.length),
                              );
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
               Row(
                 children: [
                   Expanded(
                     child:  Container(
                       margin: EdgeInsets.only(),
                       padding: EdgeInsets.all(25),
                       child: TextFormField(
                         controller:_controllerFloor,
                         decoration: new InputDecoration(
                           filled: true,
                           fillColor: Colors.black,
                           labelText: localSettingsController.selectLanguage.value=="RU"?nameFloorInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameFloorInForm[1]:nameFloorInForm[2]),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10),
                           ),
                         ),
                         onChanged: (text){
                           setState(() {
                             _controllerFloor.text=text;
                             _controllerFloor.selection=TextSelection.fromPosition(
                               TextPosition(offset: _controllerFloor.text.length),
                             );
                           });
                         },
                       ),
                     ),
                   ),
                   Expanded(
                     child:  Container(
                       margin: EdgeInsets.only(),
                       padding: EdgeInsets.all(25),
                       child: TextFormField(
                         controller: _controllerDoorPhone,
                         decoration: new InputDecoration(
                           filled: true,
                           fillColor: Colors.black,
                           labelText: localSettingsController.selectLanguage.value=="RU"?nameDoorPhoneInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameDoorPhoneInForm[1]:nameDoorPhoneInForm[2]),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10),
                           ),
                         ),
                         onChanged: (text){
                           setState(() {
                             _controllerDoorPhone.text=text;
                             _controllerDoorPhone.selection=TextSelection.fromPosition(
                               TextPosition(offset: _controllerDoorPhone.text.length),
                             );
                           });
                         },
                       ),
                     ),
                   ),
                 ],
               )

              ],
            ),
            if (orderController.order.value.orderType=="delivery" &&_width<=770)Column(
              children: [
                Container(
                  child:  Container(
                    margin: EdgeInsets.only(),
                    padding: EdgeInsets.all(25),
                    child: TextFormField(
                      controller: _controllerFlat,
                      decoration: new InputDecoration(
                        errorText:  checkValid.flat==false?localSettingsController.selectLanguage.value=="RU"?nameApartmentInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameApartmentInForm[1]:nameApartmentInForm[2]):null,
                        filled: true,
                        fillColor: Colors.black,
                        labelText: localSettingsController.selectLanguage.value=="RU"?nameApartmentInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameApartmentInForm[1]:nameApartmentInForm[2]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (text){
                        setState(() {
                          _controllerFlat.text=text;
                          _controllerFlat.selection=TextSelection.fromPosition(
                            TextPosition(offset: _controllerFlat.text.length),
                          );
                          if (_controllerFlat.text.length>0){
                            checkValid.flat=true;
                          } else {

                            checkValid.flat=false;
                          }
                        });

                      },
                    ),
                  ),
                ),
                Container(
                  child:  Container(
                    margin: EdgeInsets.only(),
                    padding: EdgeInsets.all(25),
                    child: TextFormField(
                      controller: _controllerEntrance,
                      decoration: new InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        labelText: localSettingsController.selectLanguage.value=="RU"?nameEntranceInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameEntranceInForm[1]:nameEntranceInForm[2]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (text){
                        setState(() {
                          _controllerEntrance.text=text;
                          _controllerEntrance.selection=TextSelection.fromPosition(
                            TextPosition(offset: _controllerEntrance.text.length),
                          );
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  child:  Container(
                    margin: EdgeInsets.only(),
                    padding: EdgeInsets.all(25),
                    child: TextFormField(
                      controller:_controllerFloor,
                      decoration: new InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        labelText: localSettingsController.selectLanguage.value=="RU"?nameFloorInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameFloorInForm[1]:nameFloorInForm[2]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (text){
                        setState(() {
                          _controllerFloor.text=text;
                          _controllerFloor.selection=TextSelection.fromPosition(
                            TextPosition(offset: _controllerFloor.text.length),
                          );
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  child:  Container(
                    margin: EdgeInsets.only(),
                    padding: EdgeInsets.all(25),
                    child: TextFormField(
                      controller: _controllerDoorPhone,
                      decoration: new InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        labelText: localSettingsController.selectLanguage.value=="RU"?nameDoorPhoneInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameDoorPhoneInForm[1]:nameDoorPhoneInForm[2]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (text){
                        setState(() {
                          _controllerDoorPhone.text=text;
                          _controllerDoorPhone.selection=TextSelection.fromPosition(
                            TextPosition(offset: _controllerDoorPhone.text.length),
                          );
                        });
                      },
                    ),
                  ),
                ),

              ],
            ),

              Container(

              margin: EdgeInsets.only(),
              padding: EdgeInsets.all(25),
              child: TextFormField(
                controller: _controllerComment,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration:  InputDecoration(filled: true,
                  fillColor: Colors.black,
                  labelText: localSettingsController.selectLanguage.value=="RU"?nameCommentInForm.first:(localSettingsController.selectLanguage.value=="KZ"?nameCommentInForm[1]:nameCommentInForm[2]),

                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (text){
                  setState(() {
                    setState(() {
                      _controllerComment.text=text;
                      _controllerComment.selection=TextSelection.fromPosition(
                        TextPosition(offset: _controllerComment.text.length),
                      );
                    });
                  });
                },
              ),
            ),


          ],
        );
      }),
    );

  }
}

bool CheckBasketInDep(int depId){
  print("CheckBasketInDep depId:$depId");
  bool result=true;
  print("order position count:${orderController.order.value.positions.length}");
  for (var item in orderController.order.value.positions){
    if (menuController.menu.value.products.firstWhere((element) => element.guidId==item.productId).departmentIds.contains(depId.toString())==false){
      return false;
    }
  }

  return result;
}