import 'package:dio/dio.dart';
import 'package:drive_clone_app/model/File_modle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as fileUtil;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Utils/utils.dart';
import '../widgets/VideoPlayerWidger.dart';
import 'PdfViewr.dart';

class View_Files extends StatelessWidget {
  FileModle fileModle;
  View_Files(this.fileModle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
        child: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            fileModle.name,
            style: txtstyle(20.0, Colors.white, FontWeight.w600),
          ),
        ),
      ),
      body: fileModle.type.contains("image")
          ? showImg(fileModle.url)
          : fileModle.type.contains("application")
              ? showFile(fileModle, context)
              : fileModle.type.contains("video")
                  ? VideoPlayerWidger(fileModle.url)
                  : Container(),
    );
  }


  showImg(String url) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Image(
          image: NetworkImage(url),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  showFile(FileModle fileModle, BuildContext context) {
    if (fileModle.name.contains("pdf")) {
      return PdfViewr(fileModle);
    } else {}
  }

}
