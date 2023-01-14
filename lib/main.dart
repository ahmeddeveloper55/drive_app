import 'package:drive_clone_app/providers/HomePage_provider.dart';
import 'package:drive_clone_app/providers/TappedProvider.dart';
import 'package:drive_clone_app/screens/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
          providers:[
            ChangeNotifierProvider(create: (_) => HomePage_provider()),
            ChangeNotifierProvider(create: (_)=>TappedProvider())

          ],
     child :  const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home : MyHomePage(),
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSwatch(accentColor: Colors.black54),
        ),



    );
  }
}


