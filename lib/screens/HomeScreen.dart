import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:drive_clone_app/model/File_modle.dart';
import 'package:drive_clone_app/screens/SearchScreen.dart';
import 'package:drive_clone_app/screens/View_Files.dart';
import 'package:drive_clone_app/screens/uploadScreen.dart';
import 'package:drive_clone_app/Controller/Apiservice.dart';
import 'package:drive_clone_app/widgets/ThemeSwitcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../providers/HomePage_provider.dart';
import '../providers/ThemeNotifier.dart';
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
    final notifierProvider = Provider.of<ThemeNotifier>(context);
    final iconColor = notifierProvider.themeData.iconTheme.color;
    log('build');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FDrive",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.028),
        ),
        centerTitle: false,
        actions: [
          ThemeSwitcher(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScearchScreen()),
              );
            },
            icon: Icon(
              Icons.search,
              color: iconColor,
            ),
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
              ],
            ),
          );
        },
      ),
    );
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
            }));
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
    return Image.asset("assets/video.png");
  } else {
    return Image.asset("assets/pdf.png");
  }
}
