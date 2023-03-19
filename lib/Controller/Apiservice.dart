import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as fileUtil;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../model/File_modle.dart';

typedef void OnDownloadProgressCallback(int recvBytes , int totalBytes);
typedef void OnUploadProgressCallBack(int sentBytes,int totalBytes);
/*
 This is Controller Package : it contains ->  Apiservice : is the class that has all api calls using future and all api is url that already deployed on railway server
 */
class Apiservice{
  static bool trustSelfSigned = true;

  static HttpClient getHttpClient(){
    HttpClient httpClient = new HttpClient()
        ..connectionTimeout= const Duration(seconds: 10)
        ..badCertificateCallback = ((X509Certificate cert , String host , int port)=>trustSelfSigned);
    return httpClient;
  }
  // static String baseUrlForAndroid = 'http://10.0.2.2:8094';
  // static String baseUrlForIos = 'http://localHost:8094';
  static String BaseDeploymentUrl = "https://drivebackenrestapi-production.up.railway.app";
  static String DomainUrl = 'api/files';

  static Future<List<FileModle>> getFilesFromApi(List<FileModle> files) async {
    try {
      final response = await http.get(Uri.parse("$BaseDeploymentUrl/$DomainUrl/files"));
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (Map<String, dynamic> map in body) {
          files.add(FileModle.fromJson(map));
        }
        print("${response.statusCode}");
      } else {
        log("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return files;
  }

  static Future<List<FileModle>> getFilesFromApiS() async {
    List<FileModle> files=[];
    try {
      final response = await http.get(Uri.parse("$BaseDeploymentUrl/$DomainUrl/files"));
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (Map<String, dynamic> map in body) {
          files.add(FileModle.fromJson(map));
        }
        print("${response.statusCode}");
      } else {
        log("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return files;
  }



  static Future<void> deleteFile(String id) async {
    try {

        final req = await http.delete(Uri.parse("$BaseDeploymentUrl/$DomainUrl/DeleteOneFile/$id"));
        if (req.statusCode == 200) {
          print('file with deleted');
        } else {
          throw new Exception('failed');
        }


    } catch (e) {
      print(e);
    }
  }

  static Future<void> uploadFile(BuildContext context, File file) async {
    // read file as contents of byte
    try {
       var request = http.MultipartRequest(
           'POST', Uri.parse("$BaseDeploymentUrl/$DomainUrl/upload"));
       var multiPartFile = new http.MultipartFile.fromBytes(
           'file', file.readAsBytesSync(),
           filename: file.path);
       request.files.add(multiPartFile);
       var response = await request.send();
       if (response.statusCode == 200) {
         print('File uploaded successfully.');
       } else {
         print('Failed to upload file');
       }

    } catch (e) {
      print(e);
    }
  }
  static Future<FileModle> UpdateFile(String id, String newName) async {
     final url = Uri.parse("$BaseDeploymentUrl/$DomainUrl/rename/$id");
     final response = await http.put(
         url,
         headers: {HttpHeaders.contentTypeHeader : 'application/json'},
         body: json.encode({'name' : newName})
     );
     if( response.statusCode == 200 ){
       final updatedFile = FileModle.fromJson(json.decode(response.body));
       return updatedFile;

     } else {
       throw Exception("error on update");
     }

  }
   void DonwloadFile(FileModle file) async {
    try {
      final downloadpath = await downloadPath();
      final path = "$downloadpath/${file.name.replaceAll(" ","")}";
      var status  = await Permission.storage.status;
      print("$status");
      if(!status.isGranted){
        await Permission.storage.request();
      }
      await  Dio().download(file.url, path);
      print("success");
    } catch (e) {
      print(e.toString());
      print("error");
    }

  }
    Future<String?> downloadPath()async{
    Directory?  directory;
    try{
      if(Platform.isIOS){
        directory = await getApplicationDocumentsDirectory();
      }else{
        directory  =  Directory('/storage/emulated/0/Download');
        if(!await directory.exists()){
          directory = await getExternalStorageDirectory();
        }
      }
    }catch(e){
      print("can't download path");
    }
    print(directory?.path);
    return directory?.path;
  }

}
