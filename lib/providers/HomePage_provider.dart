import 'dart:convert';

import 'package:drive_clone_app/model/File_modle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:drive_clone_app/Controller/Apiservice.dart';
import 'package:path/path.dart';

class HomePage_provider with ChangeNotifier {
  List<FileModle> _list = [];
  late List<FileModle> _searchList;
  bool checkFirstLoad = false;
  bool checkAfterRefersh = false;

  dynamic _response;

  File? file;

  List<FileModle> _favorite = [];
  List<FileModle> get favorites => _favorite;

  bool _isFav = false;
  bool get isFav => _isFav;

  void toggle() {
    _isFav = !_isFav;
    notifyListeners();
  }

  List<FileModle> get fileList => _list;
  dynamic get response => _response;

  Future<FileModle?> updateFileName(String id, String newName) async {
    try {
      print("no exception $id and $newName");
      final updateFile = await Apiservice.UpdateFile(id, newName);
      print("no exception $id and $newName");
      final selectedIndex = _list.indexWhere((file) => file.id == id);
      _list[selectedIndex] = updateFile;
      print("updated done");
      print("select index  : $selectedIndex");
      notifyListeners();
      return updateFile;
    } catch (e) {
      print(" exception");
      print(e.toString());
    }
  }

  void addtoFav(FileModle fileModle) {
    _favorite.add(fileModle);
    notifyListeners();
  }

  void removetoFav(FileModle fileModle) {
    _favorite.remove(fileModle);
    notifyListeners();
  }

  Future<void> deleteFilefromApi(int index) async {
    await Apiservice.deleteFile(_list[index].id);
    _list.removeAt(index);
    notifyListeners();
  }

  Future<List<FileModle>> getFileList() async {
    _list.clear();
    final files = await Apiservice.getFilesFromApi(_list);
    _list = files;
    return _list;
  }

  bool _loadingState = false;
  getSearchedList(List<FileModle> _listforSearch) async {
    _loadingState = true;
    _searchList = await Apiservice.getFilesFromApi(_listforSearch);
    _loadingState = false;
    notifyListeners();
  }
}
