import 'dart:convert';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart' as fileUtil;
import 'package:http/http.dart' as http;
import 'package:drive_clone_app/model/File_modle.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewr extends StatefulWidget {
  final FileModle fileModle;
  PdfViewr(this.fileModle);

  @override
  State<PdfViewr> createState() => _PdfViewrState();
}

class _PdfViewrState extends State<PdfViewr> {
  // String baseUrlForAndroid = 'http://10.0.2.2:8094';
  // String baseUrlForIos = 'http://localHost:8094';
  static String BaseDeploymentUrl =
      "https://drivebackenrestapi-production.up.railway.app";
  String DomainUrl = 'api/files';
  bool InititlizedCheck = false;
  late File pdfFile;
  InitilizePdf() async {
    pdfFile = await loadingFile(widget.fileModle);
    InititlizedCheck = true;
    setState(() {});
  }

  loadingFile(FileModle fileModle) async {
    final response = await http.get(Uri.parse(
        "$BaseDeploymentUrl/$DomainUrl/downloadFile/${fileModle.id}"));
    final bytes = response.bodyBytes;
    return storeFilesFromBytes(fileModle, bytes);
  }

  storeFilesFromBytes(FileModle fileModle, List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final fileId = File("${dir.path}/${fileModle.id}");
    await fileId.writeAsBytes(bytes, flush: true);
    return fileId;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InitilizePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InititlizedCheck
          ? PDFView(
              filePath: pdfFile.path,
              fitEachPage: false,
            )
          : Container(),
    );
  }
}
