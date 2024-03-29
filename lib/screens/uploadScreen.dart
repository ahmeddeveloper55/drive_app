import 'dart:math';

import 'package:drive_clone_app/providers/HomePage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utils/utils.dart';
import '../providers/ThemeNotifier.dart';
import '../providers/UploadProvider.dart';

class uploadScreen extends StatelessWidget {
  const uploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uploadProvider = Provider.of<UploadProvider>(context);
    final homePageProvider = Provider.of<HomePage_provider>(context);
    final notifierProvider = Provider.of<ThemeNotifier>(context);
    final iconColor = notifierProvider.themeData.iconTheme.color;
    return Scaffold(
        // backgroundColor: Colors.white30,

        appBar: AppBar(
          centerTitle: false,
          title: const Text("Uploading Screen"),
        ),
        body: Consumer<UploadProvider>(
          builder: (context, value, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MaterialButton(
                      color: Colors.white30,
                      onPressed: () async {
                        uploadProvider.selectFile();
                      },
                      child: const Text("Select file"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MaterialButton(
                      onPressed: () {
                        if (uploadProvider.file != null) {
                          print("no error");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('File uploaded successfully.')),
                          );

                          value.uploadFileFromserver(context);
                        } else {
                          print("error");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('error in  uploaded File.')),
                          );
                        }
                      },
                      color: Colors.black45,
                      child: Text(
                        "Upload",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
