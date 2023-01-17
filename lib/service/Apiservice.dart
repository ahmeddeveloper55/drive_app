import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:developer';

import '../model/File_modle.dart';
Future<List<FileModle>> getFilesFromApi(List<FileModle> files)async{
  try{
    final response = await http.get(Uri.parse("http://localhost:8089/api/files/files"));
    final body = jsonDecode(response.body);
    if(response.statusCode == 200){
      for(Map<String,dynamic> map in body){
        files.add(FileModle.fromJson(map));
      }

    }else{
      log("error");
    }

  }catch(e){
    log(e.toString());

  }
  return files;
}
Future<void> uploadFile(BuildContext context , File file)async{
  // read file as contents of byte
  try{
    var request = http.MultipartRequest('POST',Uri.parse("http://localhost:8089/api/files/upload"));
    var multiPartFile = new http.MultipartFile.fromBytes('file', file.readAsBytesSync(),filename: file.path);
    request.files.add(multiPartFile);
    var response = await request.send();
    if(response.statusCode == 200){
      print('File uploaded successfully.');
    }else{
      print('Failed to upload file');
    }

  }catch(e){
    print(e);
  }

}