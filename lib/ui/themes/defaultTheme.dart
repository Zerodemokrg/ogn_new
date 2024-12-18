import 'package:flutter/material.dart';

const primaryColor=Color.fromRGBO(226, 75, 55, 1);
const greenThemeColor=Color.fromRGBO(52, 199, 89, 1);

final themData=ThemeData(
  fontFamily: 'SofiaSans',
  textTheme: const TextTheme(
    headlineLarge:TextStyle(fontFamily: 'Bitter',color: Colors.white,fontSize: 25,fontWeight: FontWeight.w700),
    headlineMedium:TextStyle(fontFamily: 'Bitter',color: Colors.white,fontSize: 28,fontWeight: FontWeight.w700),
    headlineSmall:TextStyle(fontFamily: 'Bitter',color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700),

    displayMedium: TextStyle(fontFamily: 'Bitter',color: Colors.white,fontSize: 24,fontWeight: FontWeight.w500),
    displayLarge: TextStyle(fontFamily: 'Bitter',color: Colors.white,fontSize: 28,fontWeight: FontWeight.w500),
    displaySmall: TextStyle(fontFamily: 'Bitter',color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),

    bodyLarge: TextStyle(fontFamily: 'Bitter',color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontFamily: 'Bitter',color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontFamily: 'Bitter',color: Colors.white,fontSize: 11,fontWeight: FontWeight.w500),

    labelSmall: TextStyle(fontFamily: 'Bitter',color: Colors.white,fontSize: 12,fontWeight: FontWeight.w700),
    labelMedium: TextStyle(fontFamily: 'Bitter',color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),
    labelLarge: TextStyle(fontFamily: 'Bitter',color: Colors.white,fontSize: 28,fontWeight: FontWeight.w700),

    titleMedium: TextStyle(fontFamily: 'Bitter',color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),
    titleLarge: TextStyle(fontFamily: 'Bitter',color: Colors.black,fontSize: 28,fontWeight: FontWeight.w700),
    titleSmall: TextStyle(fontFamily: 'Bitter',color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),


),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintStyle: TextStyle(fontFamily: 'SofiaSans', color: Colors.grey),
    labelStyle: TextStyle(
      fontFamily: 'SofiaSans',
      color: Colors.grey,
      fontSize: 16, // Размер текста метки в обычном состоянии
    ),
    floatingLabelStyle: TextStyle(
      fontFamily: 'SofiaSans',
      color:primaryColor,
      fontSize: 20, // Размер текста метки при фокусировке (плавающий текст)
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), // Радиус углов
      borderSide: BorderSide(
        width: 3,
        color: primaryColor, // Цвет границы при фокусировке
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), // Радиус углов
      borderSide: BorderSide(
        color: Colors.grey, // Цвет границы в обычном состоянии
      ),
    ),

  ),
  // inputDecorationTheme: const InputDecorationTheme(
  //   hintStyle: TextStyle(fontFamily: 'white',color: Colors.white),
  //   labelStyle: TextStyle(fontFamily: 'white',color: Colors.white),
  //   focusedBorder: OutlineInputBorder(
  //     borderSide: BorderSide(
  //       color: Color.fromRGBO(56, 199, 185, 1),
  //     ),
  //   ),
  //   enabledBorder: OutlineInputBorder(
  //     borderSide: BorderSide(
  //       color: Colors.grey,
  //     ),
  //   ),
  // ),
  //primaryColor: primaryColor,
  //primarySwatch: Colors.yellow,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: primaryColor, // Цвет для CircularProgressIndicator
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: TextStyle(fontFamily: 'Bitter',fontWeight: FontWeight.w700,fontSize: 18,color: Colors.white),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ),
  scaffoldBackgroundColor:  Color.fromRGBO(28, 28, 30, 1),
  colorScheme: ColorScheme.fromSeed(
    //background: Color.fromRGBO(28, 28, 30, 1),
      seedColor: Colors.black,
      brightness: Brightness.light
  ),
);



class ButtonStyles {
  static final ButtonStyle whiteButtonStyle = ElevatedButton.styleFrom(
    textStyle: TextStyle(fontFamily: 'Bitter',fontWeight: FontWeight.w700,fontSize: 18,color: Colors.white),

    foregroundColor:Colors.black, backgroundColor: Colors.white,
    side:  const BorderSide(color: Colors.grey),
  );

  static final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black, backgroundColor: Colors.grey,
    textStyle: TextStyle(
      fontSize: 14,
    ),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );

}


class GradientText extends StatelessWidget {
  final String text;
  final double sizeFont;
  final Gradient gradient;

  GradientText(this.text, {required this.gradient,required this.sizeFont});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white, // Важно: цвет текста должен быть белым или прозрачным
          fontSize: sizeFont,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
