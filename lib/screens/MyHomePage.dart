import 'package:drive_clone_app/providers/TappedProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomeScreen.dart';
import 'MyDriveScreen.dart';



class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
                    model.widgetBody =  HomeScreen();
                  } else if (index == 1) {
                    model.widgetBody = Center(child: Text('hell1'));
                  } else if (index == 2) {
                    model.widgetBody = Center(
                      child: Text('Hell'),
                    );
                  } else if (index == 3) {
                    model.widgetBody = MyDriveScreen();
                  }
                  model.currentIndex = index;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: model.currentIndex == 0
                          ? Icon(
                        Icons.home,
                        size: 25,
                      )
                          : Icon(Icons.home_outlined, size: 25),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: model.currentIndex == 1
                          ? Icon(
                        Icons.star,
                        size: 25,
                      )
                          : Icon(Icons.star_border_outlined, size: 25),
                      label: "Starred"),
                  BottomNavigationBarItem(
                      icon: model.currentIndex == 2
                          ? Icon(
                        Icons.supervised_user_circle,
                        size: 25,
                      )
                          : Icon(Icons.supervised_user_circle, size: 25),
                      label: "Shared"),
                  BottomNavigationBarItem(
                      icon: model.currentIndex == 3
                          ? Icon(
                        Icons.folder,
                        size: 25,
                      )
                          : Icon(Icons.folder_open, size: 25),
                      label: "Files"),
                ],
              );
            },
          ),
        )


    );
  }

}
