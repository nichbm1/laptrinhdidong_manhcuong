import 'package:flutter/material.dart';

class MenuBarViewModel with ChangeNotifier {
  Offset offSet = const Offset(0, 0);
  void setOffset(Offset offSet){
    notifyListeners();
    this.offSet = offSet;
    notifyListeners();
  }
}