import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Constants {
  static Color mainBlue = Color(0xff0066cc);
  static Color lightBlut = mainBlue.withOpacity(0.5);
  static Color mainYello = Color(0xffffd139);
  static Color darkBlue = Color(0xff093b7b);
  static Color containerWhite = Color(0xfff6f8fb);
}

class SizeConfig {
  MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double b;
  static double v;
  static double topPadding;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    b = (screenWidth - _safeAreaHorizontal) / 100;
    v = (screenHeight - _safeAreaVertical) / 100;
  }
}

class HomeViewModel {
  final String title;
  final String lights;
  final SvgPicture icon;

  HomeViewModel(this.title, this.lights, this.icon);
}

class SceneModel {
  final String title;
  final List<Color> colorData;

  SceneModel(this.title, this.colorData);
}

class TopListViewModel {
  final String title;
  final String icon;

  TopListViewModel(this.title, this.icon);
}
