import 'dart:convert';

import 'package:drive_clone_app/model/File_modle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:drive_clone_app/service/Apiservice.dart';
import 'package:path/path.dart';
class UploadProvider with ChangeNotifier {
  late File _file;
  late String _fileName;
  // static String baseUrlForAndroid = 'http://10.0.2.2:8094';
  // static String baseUrlForIos = 'http://localHost:8094';
  static String BaseDeploymentUrl = "https://drivebackenrestapi-production.up.railway.app";

  static String DomainUrl = 'api/files';
  List<FileModle> _list = [];
  File get file => _file;
  String get fileName => _fileName;

void selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if(result != null) {
      _file = File(result.files.first.path!);
      _fileName = result.files.first.name;
      notifyListeners();
    } else {
      print("No file selected.");
    }
  }



  Future<FileModle?> uploadFileFromserver(BuildContext context)async{
    try {
     if(Platform.isAndroid){
       var request = http.MultipartRequest("POST", Uri.parse('$BaseDeploymentUrl/$DomainUrl/upload'));
       var multipartFile = http.MultipartFile.fromBytes('file', _file.readAsBytesSync(), filename: _fileName);
       request.files.add(multipartFile);

       var response = await request.send();
       if (response.statusCode == 200) {
         print('File uploaded successfully.');
         _fileName = '';
         notifyListeners();
       } else {
         print('Failed to upload file');

       }
     }else{
       var request = http.MultipartRequest("POST", Uri.parse('$BaseDeploymentUrl/$DomainUrl/upload'));
       var multipartFile = http.MultipartFile.fromBytes('file', _file.readAsBytesSync(), filename: _fileName);
       request.files.add(multipartFile);

       var response = await request.send();
       if (response.statusCode == 200) {
         print('File uploaded successfully.');
         _fileName = '';
         notifyListeners();
       } else {
         print('Failed to upload file');

       }
     }
    } catch (e) {
      print(e);

    }
  }

}