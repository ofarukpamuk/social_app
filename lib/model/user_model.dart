// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? userId;
  String? email;
  String? userName;
  String? profilURL;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? seviye;
  UserModel({
    required this.userId,
    required this.email,
    this.userName,
    this.profilURL,
    this.createdAt,
    this.updatedAt,
    this.seviye,
  });
  Map<String, dynamic> toMap() {
    return {
      'userId': userId!,
      'email': email!,
      'userName': userName ??
          email!.substring(0, email!.indexOf("@")) + randomSayiUret(),
      'profilURL': profilURL ??
          "https://media.licdn.com/dms/image/C4E12AQF4fIBtY1na8A/article-cover_image-shrink_720_1280/0/1632149528981?e=2147483647&v=beta&t=NUVx2I-0NXWnD55Lr0MRLs9YQEVFJxvV-Xe-dn7qthE",
      'createdAt':
          createdAt != null ? createdAt!.toUtc() : FieldValue.serverTimestamp(),
      'updatedAt':
          updatedAt != null ? updatedAt!.toUtc() : FieldValue.serverTimestamp(),
      'seviye': seviye ?? 1,
    };
  }

  factory UserModel.fromMap(Map<String?, dynamic> map) {
    return UserModel(
      userId: map['userId']!,
      email: map['email']!,
      userName: map['userName'],
      profilURL: map['profilURL'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
      seviye: map['seviye'],
    );
  }

  @override
  String toString() {
    return 'UserModel(userId: $userId, email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, updatedAt: $updatedAt, seviye: $seviye)';
  }

  String randomSayiUret() {
    int randomsayi = Random().nextInt(999999);
    return randomsayi.toString();
  }
}
