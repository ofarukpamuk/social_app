// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kursgirissayfasifirebase/app/kullanicilar.dart';

import 'package:kursgirissayfasifirebase/search/search_model.dart';
import 'package:kursgirissayfasifirebase/search/user_controllerr.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  List<SearchResult>? allSearchResults = [
    SearchResult(
      keyword: 'Ali',
      searchDate: DateTime.now(),
    ),
  ];
  CustomSearchDelegate();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query.isEmpty ? null : query = '';
        },
        icon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return KullanicilarPage();
              },
            ));
          },
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, '');
      },
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.grey,
        size: 24,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<SearchResult>? filteredList = allSearchResults!
        .where((gorev) =>
            gorev.keyword.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filteredList.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              var _oankiListeElemani = filteredList[index];
              return Dismissible(
                background: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text('Aramayı sil')
                  ],
                ),
                key: Key(_oankiListeElemani.keyword),
                onDismissed: (direction) async {
                  filteredList.removeAt(index);
                  await StorageController()
                      .saveSearchResult(_oankiListeElemani);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      trailing: Text(
                          _oankiListeElemani.searchDate.year.toString() +
                              " : " +
                              _oankiListeElemani.searchDate.month.toString() +
                              " : " +
                              _oankiListeElemani.searchDate.day.toString() +
                              " : " +
                              _oankiListeElemani.searchDate.hour.toString()),
                      title: Text(_oankiListeElemani.keyword),
                      shape: RoundedRectangleBorder(),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 2,
                      indent: 10,
                      endIndent: 20,
                    ),
                  ],
                ),
              );
            },
            itemCount: filteredList.length,
          )
        : Center(
            child: Text('Sonuc Bulunamadı'),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
