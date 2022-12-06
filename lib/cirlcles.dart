import 'package:assgn/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class BackgroundCircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<AnimationController>(builder: (context, controller, child) {
      return Positioned(
        top: - SizeConfig.screenHeight * 170 / 812,
        left: -SizeConfig.screenWidth * 120 /411,
        right: 0,
        child: Container(
          // color: Colors.black12,
          child: Transform(
            transform: Matrix4.identity()
            ..scale( 1.2),
            
            
            child: RotatedBox(
              quarterTurns:  math.max(0, 3 -  3 * controller.value).toInt(),
              child: SvgPicture.asset('assets/Circles.svg'))),
              
        ),
      );
    });
  }
}
