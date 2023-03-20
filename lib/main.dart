import 'package:drive_clone_app/Utils/utils.dart';
import 'package:drive_clone_app/providers/HomePage_provider.dart';
import 'package:drive_clone_app/providers/TappedProvider.dart';
import 'package:drive_clone_app/providers/ThemeNotifier.dart';
import 'package:drive_clone_app/providers/UploadProvider.dart';
import 'package:drive_clone_app/screens/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomePage_provider()),
    ChangeNotifierProvider(create: (_) => TappedProvider()),
    ChangeNotifierProvider(create: (_) => UploadProvider()),
    ChangeNotifierProvider(create: (_) => ThemeNotifier())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: themeProvider.getTheme,
    );
  }
}
