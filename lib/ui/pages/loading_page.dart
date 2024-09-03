import 'package:flutter/material.dart';
class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Future.delayed( const Duration(seconds: 3), () {
    //   GoRouter.of(context).go('/login');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Container(
         child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.6,
                  child:   Image.asset(
                    'assets/images/logo.png',fit: BoxFit.contain,height: 250,width: 300,
                  ),
                ),
                const SizedBox(height: 30),
                const SizedBox(
                  width: 60,
                  height: 60,
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                    strokeWidth: 5.0,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}