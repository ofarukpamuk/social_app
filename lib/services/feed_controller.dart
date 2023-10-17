import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../model/feed_model.dart';

class FeedController {
  FeedModel feedModel;

  FeedController(this.feedModel);

  Future<void> loadFeedData() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/feed.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    feedModel = FeedModel.fromJson(jsonData);
  }

  Future<void> updateFeed() async {
    final updatedJson = feedModelToJson(feedModel);
    // Write the updated JSON data to the file
    await writeJsonToFile(updatedJson);
  }

  Future<void> writeJsonToFile(String jsonString) async {
    final String filePath = 'assets/data/feed.json';
    final file = await rootBundle.load(filePath);
    final updatedFile = file.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    final fileToWrite = File('${directory.path}/$filePath');
    await fileToWrite.writeAsBytes(updatedFile);
  }

  static Future<List<Feed>> getFeedList() async {
    String jsonString = await rootBundle.loadString('assets/data/feed.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    List<dynamic> feedListJson = jsonData['feed'];

    List<Feed> feedList =
        feedListJson.map((json) => Feed.fromJson(json)).toList();

    return feedList;
  }
}
