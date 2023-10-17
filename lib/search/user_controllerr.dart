import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kursgirissayfasifirebase/search/search_model.dart';

class StorageController {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> saveSearchResult(SearchResult searchResult) async {
    final jsonStr = jsonEncode(searchResult.toJson());
    await storage.write(key: 'searchResult', value: jsonStr);
  }

  Future<SearchResult?> getSearchResult() async {
    final jsonStr = await storage.read(key: 'searchResult');
    if (jsonStr == null) {
      return null;
    } else {
      final jsonMap = jsonDecode(jsonStr);
      return SearchResult.fromJson(jsonMap);
    }
  }

  Future<void> deleteSearchResult() async {
    await storage.delete(key: 'searchResult');
  }

  static Future<void> saveSearchResultsToFile() async {
    final storageController = StorageController();

    final searchResults = [
      SearchResult(
        keyword: 'Ali',
        searchDate: DateTime.now(),
      ),
      SearchResult(
        keyword: 'Ahmet',
        searchDate: DateTime.now(),
      ),
      SearchResult(
        keyword: 'Mehmet',
        searchDate: DateTime.now(),
      ),
      SearchResult(
        keyword: 'Ayşe',
        searchDate: DateTime.now(),
      ),
      SearchResult(
        keyword: 'Buse',
        searchDate: DateTime.now(),
      ),
    ];
    for (var i = 0; i < searchResults.length; i++) {
      await storageController
          .saveSearchResult(searchResults[i])
          .then((_) => print('Arama sonuçları dosyaya kaydedildi.'))
          .catchError((error) => print('Hata oluştu: $error'));
    }
  }
}
