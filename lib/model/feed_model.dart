// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final feedModel = feedModelFromJson(jsonString);

import 'dart:convert';

FeedModel feedModelFromJson(String str) => FeedModel.fromJson(json.decode(str));

String feedModelToJson(FeedModel data) => json.encode(data.toJson());

class FeedModel {
  final List<Feed> feed;

  FeedModel({
    required this.feed,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        feed: List<Feed>.from(json["feed"].map((x) => Feed.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "feed": List<dynamic>.from(feed.map((x) => x.toJson())),
      };
}

class Feed {
  final int id;
  final String username;
  final String profileImage;
  final String postImage;
  final String caption;
  final int likes;
  final int comments;
  final String description;
  final String department;
  final List<CommentContent> commentContent;
  final String? biyografi;

  Feed({
    required this.id,
    required this.username,
    required this.profileImage,
    required this.postImage,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.description,
    required this.department,
    this.biyografi,
    required this.commentContent,
  });

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["id"],
        username: json["username"],
        profileImage: json["profile_image"],
        postImage: json["post_image"],
        caption: json["caption"],
        likes: json["likes"],
        comments: json["comments"],
        description: json["description"],
        department: json["department"],
        biyografi: json["biyografi"],
        commentContent: List<CommentContent>.from(
            json["comment_content"].map((x) => CommentContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profile_image": profileImage,
        "post_image": postImage,
        "caption": caption,
        "likes": likes,
        "comments": comments,
        "description": description,
        "department": department,
        "biyografi": biyografi,
        "comment_content":
            List<dynamic>.from(commentContent.map((x) => x.toJson())),
      };
}

class CommentContent {
  final int id;
  final String username;
  final String content;

  CommentContent({
    required this.id,
    required this.username,
    required this.content,
  });

  factory CommentContent.fromJson(Map<String, dynamic> json) => CommentContent(
        id: json["id"],
        username: json["username"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "content": content,
      };

  @override
  String toString() =>
      'CommentContent(id: $id, username: $username, content: $content)';
}
