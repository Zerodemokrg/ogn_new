import 'package:flutter/material.dart';
import 'package:ogn/ui/themes/defaultTheme.dart';

import 'package:flutter/material.dart';

class GradientBorderContainer extends StatelessWidget {
  final Widget child;
  final Color backendColor;
  const GradientBorderContainer({Key? key, required this.child,required this.backendColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(220, 53, 42, 1),
              Color.fromRGBO(255, 214, 10, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12), // Скругление углов
        ),
        //padding: const EdgeInsets.all(4), // Толщина градиентной границы
        child: Container(
          margin: EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backendColor, // Фон внутри контейнера
            borderRadius: BorderRadius.circular(12), // Скругление углов
          ),
          child: child, // Ваше содержимое
        ),
      ),
    );
  }
}

// class GradientBorderContainer extends StatelessWidget {
//   final double width;
//   final double height;
//   final double borderRadius;
//   final double borderWidth;
//   final Gradient gradient;
//   final Widget child;
//
//   const GradientBorderContainer({
//     required this.width,
//     required this.height,
//     required this.borderRadius,
//     required this.borderWidth,
//     required this.gradient,
//     required this.child,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: width,
//           height: height,
//           decoration: BoxDecoration(
//             gradient: gradient,
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//         ),
//         Positioned.fill(
//           child: Padding(
//             padding: EdgeInsets.all(borderWidth),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(borderRadius - borderWidth),
//               ),
//               child: child,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class AnimatedGradientBorderContainer extends StatefulWidget {
  final double borderRadius;
  final double borderWidth;
  final ImageProvider backgroundImage;
  final Widget child;

  const AnimatedGradientBorderContainer({
    required this.borderRadius,
    required this.borderWidth,
    required this.backgroundImage,
    required this.child,
  });

  @override
  _AnimatedGradientBorderContainerState createState() => _AnimatedGradientBorderContainerState();
}

class _AnimatedGradientBorderContainerState extends State<AnimatedGradientBorderContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;
  late Animation<Color?> _color3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _color1 = ColorTween(
      begin: Color.fromRGBO(220, 53, 42, 1),
      end: Color.fromRGBO(255, 214, 10, 1),
    ).animate(_controller);

    _color2 = ColorTween(
      begin: Color.fromRGBO(220, 53, 42, 1),
      end: Color.fromRGBO(255, 214, 10, 1),
    ).animate(_controller);

    _color3 = ColorTween(
      begin: Color.fromRGBO(220, 53, 42, 1),
      end: Color.fromRGBO(255, 214, 10, 1),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: [
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _color1.value!,
                        _color2.value!,
                        _color3.value!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(widget.borderWidth),
                    child: Container(
                      decoration: BoxDecoration(
                        color: themData.scaffoldBackgroundColor,
                      //  border: Border.all(color:Colors.white,width: 0),
                        borderRadius: BorderRadius.circular(widget.borderRadius - widget.borderWidth),
                        image: DecorationImage(
                          image: widget.backgroundImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                       child: widget.child,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
// class AnimatedGradientBorderContainer extends StatefulWidget {
//   final double width;
//   final double height;
//   final double borderRadius;
//   final double borderWidth;
//   final Widget child;
//
//   const AnimatedGradientBorderContainer({
//     required this.width,
//     required this.height,
//     required this.borderRadius,
//     required this.borderWidth,
//     required this.child,
//   });
//
//   @override
//   _AnimatedGradientBorderContainerState createState() => _AnimatedGradientBorderContainerState();
// }
//
// class _AnimatedGradientBorderContainerState extends State<AnimatedGradientBorderContainer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Color?> _color1;
//   late Animation<Color?> _color2;
//   late Animation<Color?> _color3;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     )..repeat(reverse: true);
//
//     _color1 = ColorTween(
//       begin: Color.fromRGBO(226, 75, 55, 1),
//       end: Color.fromRGBO(250, 229, 49, 1),
//     ).animate(_controller);
//
//     _color2 = ColorTween(
//       begin: Color.fromRGBO(250, 229, 49, 1),
//       end: Color.fromRGBO(226, 75, 55, 1),
//     ).animate(_controller);
//
//     _color3 = ColorTween(
//       begin: Color.fromRGBO(226, 75, 55, 1),
//       end: Color.fromRGBO(250, 229, 49, 1),
//     ).animate(_controller);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Stack(
//           children: [
//             Container(
//               width: widget.width,
//               height: widget.height,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     _color1.value!,
//                     _color2.value!,
//                     _color3.value!,
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(widget.borderRadius),
//               ),
//
//             ),
//             Positioned.fill(
//               child: Padding(
//                 padding: EdgeInsets.all(widget.borderWidth),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(widget.borderRadius - widget.borderWidth),
//                   ),
//                   child: widget.child,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }