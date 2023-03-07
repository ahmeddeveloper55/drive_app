import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:drive_clone_app/model/File_modle.dart';
import 'package:drive_clone_app/screens/SearchScreen.dart';
import 'package:drive_clone_app/screens/View_Files.dart';
import 'package:drive_clone_app/screens/uploadScreen.dart';
import 'package:drive_clone_app/service/Apiservice.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../providers/HomePage_provider.dart';
import '../providers/UploadProvider.dart';
import '../widgets/CustomSlideableWidget.dart';
import '../widgets/FloatingActionButtonWidget.dart';

class HomeScreen extends StatefulWidget {
  static List<FileModle> _list1 = [];
  static List<FileModle> _searchresult = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool state = false;
  Apiservice apiservice = Apiservice();
  TextEditingController controller = new TextEditingController();

  // @override
  @override
  Widget build(BuildContext context) {
    log('build');
    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        title: const Text("FDrive", style:TextStyle(color:Colors.black) ,),
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ScearchScreen()),
                );
              },
              icon: Icon(Icons.search),
            color: Colors.black,
          ),

        ],
      ),
      body: Consumer<HomePage_provider>(
        builder: (context, model, _) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: buildFutureBuilder(model),
                ),
                const SizedBox(
                  height: 5,
                ),
                FloatingActionButtonWidget(
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.cloud_upload),
                  onPress: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const uploadScreen()),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
    // return SafeArea(
    //   child: Center(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //          Container(
    //                 padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),
    //                 child: Material(
    //                   elevation: 2,
    //                   borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   child: SizedBox(
    //                     height: 50,
    //                     child: SafeArea(
    //                       child: TextFormField(
    //                         controller: myProvider.textController,
    //                         decoration: InputDecoration(
    //                           hintText: "Search in Drive",
    //                           border: InputBorder.none,
    //                           icon: Container(
    //                               margin: EdgeInsets.only(left: 10),
    //                               child: Icon(Icons.dehaze)),
    //
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //
    //
    //        SizedBox(height: 5,),
    //
    //
    //         new Expanded(
    //           child: _searchresult.length != 0 || controller.text.isNotEmpty
    //               ? new ListView.builder(
    //               itemCount: _searchresult.length,
    //               itemBuilder: (context, i) {
    //                 FileModle filemodel = _searchresult[i];
    //                 return _getList(filemodel);
    //               })
    //               : ListView.builder(
    //               itemCount: _list1.length,
    //               itemBuilder: (context, i) {
    //                 FileModle filemodelU = _list1[i];
    //                 return _getList(filemodelU);
    //               }),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  RefreshIndicator buildFutureBuilder(HomePage_provider model) {
    return RefreshIndicator(
        onRefresh: () {
          return Future(() => setState(() {}));
        },
        child: FutureBuilder<List<FileModle>>(
            future: model.getFileList(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                print("${snapshot.hasData}");

                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, i) {
                      FileModle filemodelU = snapshot.data![i];
                      return CustomSlideableWidget(
                          filemodelU: filemodelU,
                          apiservice: apiservice,
                          Index: i,
                          model: model);
                    });
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Text(snapshot.error.toString());
              }
            })
    );
  }
}


fileImage(String filename) {
  if (filename.contains("docs")) {
    return Image.asset("assets/google-docs.png");
  } else if (filename.contains('png') || filename.contains('jpg')) {
    return Image.asset("assets/photo.png");
  } else if (filename.contains("pdf")) {
    return Image.asset("assets/pdf.png");
  } else if (filename == "sheets") {
    return Image.asset("assets/google-sheets.png");
  } else if (filename.contains("mp4")) {
    return Image.asset("assets/google-sheets.png");
  } else {
    return Image.asset("assets/pdf.png");
  }
}
