import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/UploadProvider.dart';

class uploadScreen extends StatelessWidget {
  const uploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uploadProvider = Provider.of<UploadProvider>(context);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MaterialButton(
            color: Colors.cyan,
            onPressed: ()  async{
                uploadProvider.selectFile();
            },
            child: Text("Select file"),

          ),
          MaterialButton(
            onPressed: () {
              if (uploadProvider.file != null) {
                uploadProvider.uploadFileFromserver(context);
              } else {
                print("error");
              }
            },
            color: Colors.black45,
            child: Text("Upload", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    ));
  }
}
