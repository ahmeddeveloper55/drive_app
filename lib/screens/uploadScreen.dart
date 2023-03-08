import 'dart:math';

import 'package:drive_clone_app/providers/HomePage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utils/utils.dart';
import '../providers/UploadProvider.dart';

class uploadScreen extends StatelessWidget {
  const uploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uploadProvider = Provider.of<UploadProvider>(context);
    final homePageProvider = Provider.of<HomePage_provider>(context);
    return Scaffold(
        backgroundColor: Colors.white,

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.06),
          child: AppBar(
            centerTitle: false,
            backgroundColor: Colors.white,
            title :  Text("Uploading Screen",style: txtstyle(15.0 , Colors.black , FontWeight.w600),),
          ),
        ),
        body: Consumer<UploadProvider>(
          builder: (context,value,child){
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,

                    child: MaterialButton(
                      color: Colors.white30,
                      onPressed: ()  async{
                        uploadProvider.selectFile();
                      },
                      child: Text("Select file"),

                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: MaterialButton(
                      onPressed: () {
                        if (uploadProvider.file != null) {
                          print("no error");
                         value.uploadFileFromserver(context);

                        } else {
                          print("error");
                        }
                      },
                      color: Colors.black45,
                      child: Text("Upload", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            );
          },

        ));
  }
}
