import 'dart:convert';

import 'package:drive_clone_app/model/File_modle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:drive_clone_app/Controller/Apiservice.dart';
import 'package:path/path.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

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


/// Using lookupMimeType to get the proper contentType of File or it will give ['application/octet-stream'] as default value
  /// and when we need to call  fromBytes we should specify 'file'  -> whcih name tag we have to gave as key while we post new file on postman.
  ///  _file.readAsBytesSync() to read files bytes synchronously , filename: _fileName , contentType: MediaType.parse(mimeType) : parse mimeType by using MediaType.parse which http.parse function.
  ///  mimeType will have proper file type
  Future<FileModle?> uploadFileFromserver(BuildContext context)async{
    try {
        String mimeType = lookupMimeType(_fileName) ?? 'application/octet-stream';
        var request = http.MultipartRequest("POST", Uri.parse('$BaseDeploymentUrl/$DomainUrl/upload'));
        var multipartFile = http.MultipartFile.fromBytes('file', _file.readAsBytesSync(), filename: _fileName, contentType: MediaType.parse(mimeType));
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