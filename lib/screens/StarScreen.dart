import 'package:drive_clone_app/screens/uploadScreen.dart';
import 'package:drive_clone_app/service/Apiservice.dart';
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Apiservice apiservice = Apiservice();
    return Scaffold(
      backgroundColor: Colors.white30,

      appBar: AppBar(
        title: const Text('Stars page',style: TextStyle(color: Colors.black),),
        centerTitle: false,
        backgroundColor: Colors.white,

      ),
      body: Consumer<HomePage_provider>(
        builder: (context,model,child){
          return  SafeArea(
            child:
                Container(
                  child: ListView.builder(
                      itemCount: model.favorites.length,
                      itemBuilder: (context, i) {
                        FileModle filemodelU = model.favorites![i];
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
