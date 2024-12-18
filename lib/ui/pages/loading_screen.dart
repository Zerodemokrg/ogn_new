import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/images/fire.gif',
          width: 300,
          height: 375,
          fit: BoxFit.cover,
        ).animate().fade(duration: 1200.ms).scale(),
      ),
    );
  }
}

