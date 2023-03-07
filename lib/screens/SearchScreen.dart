import 'package:drive_clone_app/providers/HomePage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/File_modle.dart';
import '../service/Apiservice.dart';
import '../widgets/CustomSlideableWidget.dart';

class ScearchScreen extends StatefulWidget {
  @override
  State<ScearchScreen> createState() => _ScearchScreenState();
}

class _ScearchScreenState extends State<ScearchScreen> {
  TextEditingController controller = new TextEditingController();
  List<FileModle> _list = [];
  List<FileModle> filteredList = [];
  Apiservice apiservice = Apiservice();
  HomePage_provider m = new HomePage_provider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final homeProvider = Provider.of<HomePage_provider>(context, listen: false);
    homeProvider.getSearchedList(_list);
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      // filteredList = _list;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print("inside search build");
    final ScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<HomePage_provider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: buildBody(provider),
          );
        },
      ),
    );
  }

  Widget _getSearch(BuildContext context, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: SizedBox(
          height: 50,
          child: SafeArea(
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Search in Drive",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        //
                      ),
                      onChanged: (string) {
                        onChangesString(string);
                      },
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        controller.clear();
                        onChangesString('');
                      },
                      icon: Icon(Icons.cancel)),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onChangesString(String string) {
    filteredList.clear();
    if (string.isEmpty) {
      setState(() {});
      return;
    }
    _list.forEach((user) {
      if (user.name.toLowerCase().contains(string.toLowerCase())) {
        filteredList.add(user);
      }
    });
    setState(() {});
  }

  Widget buildBody(HomePage_provider model) {
    return RefreshIndicator(
        onRefresh: _onRefresh,
        color: Colors.white70,
        backgroundColor: Colors.pink,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                Expanded(flex: 9, child: _getSearch(context, controller)),
              ],
            ),
            Expanded(
              child: filteredList.isNotEmpty || controller.text.isNotEmpty
                  ? ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, i) {
                    FileModle filemodelU = filteredList![i];
                    return CustomSlideableWidget(
                        filemodelU: filemodelU,
                        apiservice: apiservice,
                        Index: i,
                        model: model);
                  })
                  : const Center(
                child: Text('No Items Found'),
              ),
            )
          ],
        ));
  }

  }
