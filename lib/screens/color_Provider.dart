import 'package:flutter/material.dart';

class ColorProvider with ChangeNotifier {
  Color _color = const Color.fromARGB(255, 243, 33, 236);

  Color get color => _color;

  void changeColor(Color newColor) {
    _color = newColor;
    notifyListeners();
  }
}