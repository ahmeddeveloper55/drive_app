import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../Utils/utils.dart';

class ThemeNotifier extends ChangeNotifier{
  late  ThemeData themeData;
  ThemeNotifier(){
    final brightness = SchedulerBinding.instance.window.platformBrightness;
    themeData = brightness == Brightness.dark ? darkTheme : lightTheme;
  }
   ThemeData get getTheme => themeData;

   void toggleTheme(){
     if(themeData == lightTheme){
       themeData = darkTheme;

     }else{
       themeData = lightTheme;
     }
     notifyListeners();
   }


}