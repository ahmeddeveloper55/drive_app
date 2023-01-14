import 'package:flutter/material.dart';

import '../screens/HomeScreen.dart';

class TappedProvider extends ChangeNotifier{
  int _currentIndex=0;
  Widget _widgetBody = HomeScreen();
  Widget get widgetBody => _widgetBody;
  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  set widgetBody(Widget value) {
    _widgetBody = value;
    notifyListeners();
  }
}