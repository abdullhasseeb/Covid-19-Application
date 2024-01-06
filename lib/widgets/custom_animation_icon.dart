import 'dart:math';
import 'package:flutter/material.dart';
class CustomAnimatedIcon extends StatefulWidget {
  final animationController;
  const CustomAnimatedIcon({
    super.key,
    required this.animationController
  });

  @override
  State<CustomAnimatedIcon> createState() => _CustomAnimationIconState();
}
class _CustomAnimationIconState extends State<CustomAnimatedIcon> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
        animation: widget.animationController,
        child: Center(
          child: SizedBox(
            width: height/2.3,
            height: height/2.3,
            child: Image.asset('assets/images/world.png'),
          ),
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: widget.animationController.value * 2.0 * pi,
            child: child,
          );
        },
    );
  }
}
