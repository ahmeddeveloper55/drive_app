import 'package:drive_clone_app/providers/TappedProvider.dart';
import 'package:drive_clone_app/screens/SearchScreen.dart';
import 'package:drive_clone_app/screens/StarScreen.dart';
import 'package:drive_clone_app/screens/uploadScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomeScreen.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: (context) => TappedProvider(),
        child: Scaffold(
          body: Consumer<TappedProvider>(
            builder: (context, model, chile) {
              return model.widgetBody;
            },
          ),
          bottomNavigationBar: Consumer<TappedProvider>(
            builder: (context, model, child) {
              return BottomNavigationBar(
                currentIndex: model.currentIndex,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                selectedItemColor: Colors.blue.shade700,
                onTap: (index) {
                  if (index == 0) {
                    model.widgetBody = HomeScreen();
                  } else if (index == 1) {
                    model.widgetBody = StarScreen();
                  } else if (index == 2) {
                    model.widgetBody = uploadScreen();
                  }
                  model.currentIndex = index;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: model.currentIndex == 0
                          ? const Icon(
                              Icons.home,
                              size: 25,
                            )
                          : const Icon(Icons.home_outlined, size: 25),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: model.currentIndex == 1
                          ? const Icon(
                              Icons.star,
                              size: 25,
                            )
                          : const Icon(Icons.star_border_outlined, size: 25),
                      label: "Starred"),
                  BottomNavigationBarItem(
                      icon: model.currentIndex == 2
                          ? const Icon(
                              Icons.upload_file,
                              size: 25,
                            )
                          : Icon(Icons.upload_file_outlined, size: 25),
                      label: "Upload"),
                ],
              );
            },
          ),
        ));
  }
}
