import 'package:flutter/material.dart';

class ColorProvider with ChangeNotifier {
  Color _color = Color.fromARGB(255, 63, 89, 168);
  Color _textcolor = Color.fromARGB(255, 255, 255, 255);

  Color get color => _color;
  Color get textcolor => _textcolor;

  void changeColor(Color newColor) {
    _color = newColor;
    notifyListeners();
  }

  void changeTextColor(Color newTextColor) {
    _textcolor = newTextColor;
    notifyListeners();
  }
}