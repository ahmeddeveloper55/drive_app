import 'package:flutter/material.dart';

import '../model/File_modle.dart';
import '../service/Apiservice.dart';

class HomePage_provider with ChangeNotifier {
  List<FileModle> _list = [];

  // List<File> _fileList = [];
  String _searchTerm = '';

  List<FileModle> get fileList => _list;
  String get searchTerm => _searchTerm;
  set searchTerm(String value) {
    _searchTerm = value;
    notifyListeners();
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
