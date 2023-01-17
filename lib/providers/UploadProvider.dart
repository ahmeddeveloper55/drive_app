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

  void uploadFileFromserver(BuildContext context)async{
    try {
      var request = new http.MultipartRequest("POST", Uri.parse('http://localhost:8089/api/files/upload'));
      var multipartFile = new http.MultipartFile.fromBytes('file', _file.readAsBytesSync(), filename: _fileName);
      request.files.add(multipartFile);

      var response = await request.send();
      if (response.statusCode == 200) {
        print('File uploaded successfully.');
        _fileName = '';
        notifyListeners();
      } else {
        print('Failed to upload file');

      }
    } catch (e) {
      print(e);

    }
  }

}