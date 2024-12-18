import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/intl.dart';
import '../../main.dart';
import '../themes/defaultTheme.dart';
import '../widgets/appBar.dart';

class DepartmentsPage extends StatefulWidget{
  @override
  _DepartmentsPageState createState()=>new _DepartmentsPageState();
}

class _DepartmentsPageState extends State<DepartmentsPage>{
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
    double _width= MediaQuery.of(context).size.width ;
    return CustomScrollView(
      slivers: [
        SiteSliverAppBar(title: ''),
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Obx((){
                  return Text(
                      localSettingsController.selectLanguage.value=="RU"?ourDepartmentsText.first:localSettingsController.selectLanguage.value=="KZ"?ourDepartmentsText[1]:ourDepartmentsText[2],
                      style: themData.textTheme.displayLarge,
                  );
                }),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                alignment: Alignment.center,
                child: Wrap(

                  spacing: 20,
                  runSpacing: 30,
                  children: [
                    for (var dep in departmentsController.departments)
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey, // Цвет границы
                              width: 1.0, // Ширина границы
                            ),
                            borderRadius: BorderRadius.circular(16), // Радиус углов
                          ),
                          width: 450,
                          height: 180,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Row(
                            children: [
                              Container(
                                  width: _width>600?180:100,
                                  height: _width>600?180:100,
                                  child: Image.network(
                                    dep.imageLink!,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/logo_for_light.png',
                                        width: 240,
                                        height: 240,
                                      );
                                    },
                                  )
                              ),
                              Expanded(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        height: 60,
                                        child: GradientText(
                                          (localSettingsController.selectLanguage.value=="RU"?dep.address:localSettingsController.selectLanguage.value=="KZ"?dep.addressQaz:dep.addressEng)??"",
                                          gradient: const LinearGradient(
                                            colors: <Color>[
                                              Color.fromRGBO(220, 53, 42, 1),  // rgba(220, 53, 42, 1)
                                              Color.fromRGBO(255, 214, 10, 1), // rgba(255, 214, 10, 1)
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          sizeFont: 20,),
                                      ),
                                      Container(
                                        child: Text("${workingSchedulesText.first}: 24/7",style: themData.textTheme.titleSmall, overflow: TextOverflow.ellipsis,maxLines: 2,),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex:1,
                                              child: Container(
                                                height: 45,
                                                margin: EdgeInsets.only(left: 25,right: 25),
                                                child: ElevatedButton(
                                                    onPressed: (){
                                                      if (dep.mapLink!=""){
                                                        launch(dep.mapLink??"");
                                                      }
                                                    },
                                                    child: Text("2GIS",style: TextStyle(fontSize: 16),maxLines: 1,),
                                                    style: ButtonStyle(backgroundColor:WidgetStateProperty.all<Color>(Color.fromRGBO(51, 51, 51, 1)) )
                                                ),
                                              )
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 25),
                                            height: 45,
                                            child: ElevatedButton(
                                              onPressed: (){
                                                if (dep.tourLink!=""){
                                                  launch(dep.tourLink??"");
                                                }
                                              },
                                              child: Text("Обзор ",style: TextStyle(fontSize: 16)),
                                              style: ButtonStyle(backgroundColor:WidgetStateProperty.all<Color>(Color.fromRGBO(51, 51, 51, 1)) ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ))
                            ],
                          ),),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
        // SliverFillRemaining(
        //   hasScrollBody: false,
        //   child: FooterWidget(),
        // ),
      ],
    );
  }
}