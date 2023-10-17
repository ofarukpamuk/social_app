import 'package:flutter/material.dart';
import 'package:kursgirissayfasifirebase/search/search_metod.dart';
import 'package:kursgirissayfasifirebase/search/user_controllerr.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final _storageController = StorageController();

  @override
  void initState() {
    super.initState();
    StorageController.saveSearchResultsToFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arama'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            final query = await showSearch<String>(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
        ),
      ),
    );
  }
}
