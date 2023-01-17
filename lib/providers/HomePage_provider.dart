import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../model/File_modle.dart';
import '../service/Apiservice.dart';

class HomePage_provider with ChangeNotifier {
  List<FileModle> _list = [];

  // List<File> _fileList = [];
  String _searchTerm = '';
  late String _fileName;
  dynamic _response;
 File? file;

  List<FileModle> get fileList => _list;
  String get searchTerm => _searchTerm;
  String get fileName => _fileName;
  dynamic get response => _response;
  set searchTerm(String value) {
    _searchTerm = value;
    notifyListeners();
  }
  void selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any,allowMultiple: false);
    if(result != null) {
      file = File(result.files.first.path!);
      _fileName = result.files.first.name;
      notifyListeners();
    } else {
      print("No file selected.");
    }
  }

  // Future<void> uploadFileFromserver(BuildContext context , File file)async{
  //   await uploadFile(context, file);
  //   notifyListeners();
  // }
 Future<void> pickFile(BuildContext context) async{
   try {
     final result = await FilePicker.platform.pickFiles() ;
     if (result != null) {
       File file = File(result.files.single.path!);
       await uploadFile(context, file);
     } else {
       // User canceled the picker
       print("No file selected.");

     }

   } catch (e) {
     print(e);
   }
 }
  bool state = false;
  Future<List<FileModle>> getFileList() async {
    // Call the API to retrieve the list of files

    // If the API call was successful, set the file list and return it
    if (!state && _list.isEmpty) {
      final files = await getFilesFromApi(_list);
      _list = files;
      state = true;
      return _list;
    } else if (_list.isNotEmpty && state) {
      // If the API call was unsuccessful, throw an error
      return _list;
    } else {
      throw Exception('error in loading');
    }
  }

  void fliterSearch(String s) {
    _searchTerm = s;
    _list = _list
        .where((fileModle) =>
            fileModle.name.contains(_searchTerm.toLowerCase()) ||
            fileModle.size.toString().contains(_searchTerm.toLowerCase()) ||
            fileModle.type.contains(_searchTerm.toLowerCase()))
        .toList();
    notifyListeners();
  }
 
}
