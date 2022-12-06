import 'package:assgn/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



//Notifier to track value of animationController for bedroom page
class BedRoomPageAnimationController extends ChangeNotifier {
  final AnimationController _bedRoomController;
  BedRoomPageAnimationController(this._bedRoomController) {
    _bedRoomController.addListener(_onAnimationControllerChange);
  }

  void _onAnimationControllerChange() {
    notifyListeners();
  }

  void dispose() {
    _bedRoomController.dispose();
    super.dispose();
  }

  double get value => _bedRoomController.value;
  void forward() => _bedRoomController.forward();
  void reverse() => _bedRoomController.reverse();
  AnimationController get controller => _bedRoomController;
}


//Notifer to track the intensity of light bulb 
class Intensity extends ChangeNotifier {
  double _value = 5;

  double get value => _value;

  void setValue(double value) {
    _value = value;
    notifyListeners();
  }
}


//Notifier to change the color selected
class ColorNotifier extends ChangeNotifier {
  Color _color = Constants.mainYello;

  Color get color => _color;

  void setBulbColor(Color color) {
    _color = color;
    notifyListeners();
  }
}