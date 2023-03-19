import 'package:drive_clone_app/screens/uploadScreen.dart';
import 'package:drive_clone_app/Controller/Apiservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/File_modle.dart';
import '../providers/HomePage_provider.dart';
import '../widgets/CustomSlideableWidget.dart';
import 'HomeScreen.dart';
class StarScreen extends StatelessWidget {
  const StarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Apiservice apiservice = Apiservice();
    return Scaffold(

      appBar: AppBar(
        title: const Text('Stars page'),
        centerTitle: false,

      ),
      body: Consumer<HomePage_provider>(
        builder: (context,model,child){
          return  SafeArea(
            child:
                Container(
                  child: ListView.builder(
                      itemCount: model.favorites.length,
                      itemBuilder: (context, i) {
                        FileModle filemodelU = model.favorites[i];
                        return CustomSlideableWidget(
                            filemodelU: filemodelU,
                            apiservice: apiservice,
                            Index: i,
                            model: model);
                      })
                ),
          );
        },

      ),

    );
  }
}
