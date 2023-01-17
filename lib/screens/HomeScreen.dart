

import 'dart:developer';
import 'dart:io';

import 'package:drive_clone_app/model/File_modle.dart';
import 'package:drive_clone_app/screens/uploadScreen.dart';
import 'package:drive_clone_app/service/Apiservice.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/HomePage_provider.dart';

class HomeScreen extends StatelessWidget {

  static List<FileModle> _list1 = [];
  bool  state = false;
  // static List<FileModle> _searchresult = [];

  // TextEditingController controller = new TextEditingController();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   final provider = Provider.of<HomePage_provider>(context, listen: false);
  //   provider.getAllFilesProvider(_list1);
  // }
  @override
  Widget build(BuildContext context) {
    print('recall');
    final myData = Provider.of<HomePage_provider>(context);
    print('Before tap: ${myData.state}');
    log('build');
    return Scaffold(
      body: Consumer<HomePage_provider>(
        builder: (context,model,child){
           return  SafeArea(
             child: Column(
               children: [
                 _getSearch(context),
                 SizedBox(height: 5,),
                 Expanded(
                   child: FutureBuilder(
                       future:  model.getFileList() ,
                       builder:(context,snapshot){
                         if(snapshot.hasData){
                           return ListView.builder(
                               itemCount: snapshot.data?.length,
                               itemBuilder: (context, i) {
                                 FileModle filemodelU = snapshot.data![i];
                                 return _getList(filemodelU);
                               });



                         }else if (snapshot.hasError) {
                           return Text(snapshot.error.toString());
                         }
                         else {
                           return Center(
                             child: CircularProgressIndicator(),
                           );
                         }
                       }
                   ),
                 ),
                 SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(right: 15,bottom: 15),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child:  FloatingActionButton(
                      backgroundColor: Colors.black45,
                      child: Icon(Icons.cloud_upload),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => uploadScreen()));
                      }
                      ,
                  )
                   ),
                )
               ],

             ),
           );
        },

      ),

    );
    // return SafeArea(
    //   child: Center(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //          Container(
    //                 padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),
    //                 child: Material(
    //                   elevation: 2,
    //                   borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   child: SizedBox(
    //                     height: 50,
    //                     child: SafeArea(
    //                       child: TextFormField(
    //                         controller: myProvider.textController,
    //                         decoration: InputDecoration(
    //                           hintText: "Search in Drive",
    //                           border: InputBorder.none,
    //                           icon: Container(
    //                               margin: EdgeInsets.only(left: 10),
    //                               child: Icon(Icons.dehaze)),
    //
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //
    //
    //        SizedBox(height: 5,),
    //
    //
    //         new Expanded(
    //           child: _searchresult.length != 0 || controller.text.isNotEmpty
    //               ? new ListView.builder(
    //               itemCount: _searchresult.length,
    //               itemBuilder: (context, i) {
    //                 FileModle filemodel = _searchresult[i];
    //                 return _getList(filemodel);
    //               })
    //               : ListView.builder(
    //               itemCount: _list1.length,
    //               itemBuilder: (context, i) {
    //                 FileModle filemodelU = _list1[i];
    //                 return _getList(filemodelU);
    //               }),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }


  // onChangedtext(String s) async {
  //   _searchresult.clear();
  //   // if (s.isEmpty) {
  //   //   setState(() {});
  //   //   return;
  //   // }
  //   _list1.forEach((user) {
  //     if (user.name.toString().contains(s)||user.size.toString().contains(s)||user.type.toString().contains(s)) {
  //       _searchresult.add(user);
  //     }
  //   });
  //   // setState(() {});
  // }
}
Widget _getList(FileModle fileModle){
  return SafeArea(
    child: Center(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Card(
                child: ListTile(
                  title: Text(fileModle.name.toString()),
                  subtitle: Text(fileModle.size.toString()),
                  trailing: fileImage(fileModle.type.toString()),

                ),
              ),
            )
          ],
        ),

      ),
    ),
  );

}
Widget _getSearch(BuildContext context){
  return  Container(
    padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: SizedBox(
        height: 50,
        child: SafeArea(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Search in Drive",
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              //


            ),
            onChanged: (value){
              context.read<HomePage_provider>().fliterSearch(value);
            },
          ),
        ),
      ),
    ),
  );
}

fileImage(String filename){
  if(filename.contains('Docs')){
    return Image.asset("assets/google-docs.png");
  }else if(filename.contains('png')||filename.contains('jpg')){
    return Image.asset("assets/photo.png");
  }else if(filename.contains('pdf')){
    return Image.asset("assets/pdf.png");
  }else if(filename == 'sheets'){
    return Image.asset("assets/google-sheets.png");
  }else if(filename == 'video'){
    return Image.asset("assets/photographic-flim.png");
  }else{
    return Image.asset("assets/pdf.png", color: Colors.blue,);
  }
}
