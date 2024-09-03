import 'package:flutter/material.dart';

class GradientBorderContainer extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double borderWidth;

  GradientBorderContainer({
    required this.child,
    required this.gradient,
    this.borderWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(8.0), // Закругленные углы рамки, если нужно
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth), // Толщина рамки
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Цвет внутреннего фона
            borderRadius: BorderRadius.circular(8.0 - borderWidth), // Закругленные углы внутреннего контейнера
          ),
          child: child,
        ),
      ),
    );
  }
}