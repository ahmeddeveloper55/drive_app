import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/File_modle.dart';
import '../providers/HomePage_provider.dart';
import '../screens/HomeScreen.dart';
import '../screens/View_Files.dart';
import '../Controller/Apiservice.dart';

class CustomSlideableWidget extends StatelessWidget {
  const CustomSlideableWidget(
      {Key? key,
      required this.filemodelU,
      required this.apiservice,
      required this.Index,
      required this.model})
      : super(key: key);

  final FileModle filemodelU;
  final Apiservice apiservice;
  final int Index;
  final HomePage_provider model;

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                model.toggle();
                if (model.favorites.contains(filemodelU)) {
                  model.removetoFav(filemodelU);
                } else {
                  model.addtoFav(filemodelU);
                }
              },
              label: 'Star',
              icon: model.isFav ? Icons.star : Icons.star_border,
              backgroundColor: Color(0xFFFFDD03),
            ),
            SlidableAction(
              onPressed: (context) {
                print(Index);
                apiservice.DonwloadFile(filemodelU);
              },
              label: 'Download',
              icon: Icons.download_outlined,
              backgroundColor: Color(0xff448c46),
            ),
          ],
        ),
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          dismissible: DismissiblePane(
            key: Key(filemodelU.id),
            onDismissed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete Item'),
                      content: Text('Are sure You want to delete Item'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel')),
                        TextButton(
                            onPressed: () {
                              model.deleteFilefromApi(Index);
                              Navigator.of(context).pop();
                            },
                            child: Text('Yes')),
                      ],
                    );
                  });
            },
          ),
          children: [
            SlidableAction(
              onPressed: (context) => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete Item'),
                      content: Text('Are sure You want to delete Item'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel')),
                        TextButton(
                            onPressed: () {
                              model.deleteFilefromApi(Index);
                              Navigator.of(context).pop();
                            },
                            child: Text('Yes')),
                      ],
                    );
                  }),
              label: 'Delete',
              icon: Icons.delete,
              backgroundColor: Color(0xFFCF0303),
            ),
            SlidableAction(
              onPressed: (context) =>
                  _ShowUpdateDailog(context, filemodelU, model),
              label: 'Update',
              icon: Icons.update,
              backgroundColor: Color(0xFFFFDD03),
            ),
          ],
        ),
        child: _getList(filemodelU, context));
  }

  Future<void> _ShowUpdateDailog(BuildContext context, FileModle fileModle,
      HomePage_provider fileProvider) {
    final nameController = TextEditingController(text: fileModle.name);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update File Name'),
            content: TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'enter new name'),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("cancel")),
              TextButton(
                onPressed: () async {
                  final newName = nameController.text;
                  if (newName.isNotEmpty) {
                    fileProvider.updateFileName(fileModle.id, newName);
                  }
                  Navigator.pop(context);
                },
                child: const Text("Update"),
              ),
            ],
          );
        });
  }

  Widget _getList(FileModle fileModle, BuildContext context) {
    final size = MediaQuery.of(context).size;
    final convertedFileSize = formatFileSize(fileModle.size);
    return SafeArea(
      child: Center(
        child: Container(
          padding: EdgeInsets.only(
              left: size.width * 0.02,
              right: size.width * 0.02,
              top: size.width * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => View_Files(fileModle))),
                child: Container(
                  child: Card(
                    child: ListTile(
                      title: Text(fileModle.name.toString()),
                      subtitle: Text(convertedFileSize),
                      trailing: fileImage(fileModle.name.toString()),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// formatFileSize :  is the funtions that will take bytes , size of files that stored  on  PostgresSql as bytes and Converted Dynamically to Proper Size
  /// if it is less than 1024 bytes will be Bytes as it is , if it is less than 1024^2 will be kiloBytes and so on .
  /// toStringAsFixed this funtion will take any double on string format  , and take parameter as decimalPlaces , fixed to that , examples : (4321.12345678).toStringAsFixed(2);  // 4321.12
  String formatFileSize(int bytes, [int decimalPlaces = 2]) {
    if (bytes < 1024) {
      return "$bytes B";
    } else if (bytes < 1024 * 1024) {
      double kilobytes = bytes / 1024;
      return '${kilobytes.toStringAsFixed(decimalPlaces)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      double megaBytes = bytes / (1024 * 1024);
      return '${megaBytes.toStringAsFixed(decimalPlaces)} MB';
    } else {
      double gigabytes = bytes / (1024 * 1024 * 1024);
      return '${gigabytes.toStringAsFixed(decimalPlaces)} GB';
    }
  }
}
