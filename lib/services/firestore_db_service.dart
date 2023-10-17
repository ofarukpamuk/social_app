import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kursgirissayfasifirebase/model/user_model.dart';
import 'package:kursgirissayfasifirebase/services/database_base.dart';

class FireStoreDbService implements DbBase {
  final FirebaseFirestore _fireStoreDb = FirebaseFirestore.instance;
  @override
  Future<bool> saveUser(UserModel? user) async {
    try {
      if (user != null) {
        await _fireStoreDb
            .collection("users")
            .doc(user.userId!)
            .set(user.toMap());
        return true;
      } else {
        return false;
      }

      /* ocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.userId!)
          .get();
      Map<String, dynamic> okunanUserVerileriMapi = snapshot.data()!;
      UserModel okunanUserModeller = UserModel.fromMap(okunanUserVerileriMapi); */
    } catch (e) {
      debugPrint("Kullanıcı kaydedilirken hata oluştu: $e");
      return false;
    }
  }

  //@override
  /*  Future<UserModel?> readUser(String? userID) async {
    try {
      if (userID != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshotOkunanaUser =
            await _fireStoreDb.collection('users').doc(userID).get();
        Map<String, dynamic> IdIleOkunanUser = snapshotOkunanaUser.data()!;
        UserModel okunanUserNesnesi = UserModel.fromMap(IdIleOkunanUser);
        return okunanUserNesnesi;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(
          "readUser fonksiyonunda hata var veritabanı kullanılmıyor ${e.toString()}");
    }
  } */
  @override
  Future<UserModel?> readUser(String? userID) async {
    try {
      DocumentSnapshot<Map<String, dynamic>>? documentSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc('userID')
              .get();
      if (documentSnapshot.exists) {
        // Kullanıcı verileri mevcutsa işlemleri burada gerçekleştirin
        Map<String, dynamic> userData = documentSnapshot.data()!;
        UserModel okunanUserNesnesi = UserModel.fromMap(userData);
        return okunanUserNesnesi;
      } else {
        debugPrint('Kullanıcı bulunamadı');
      }
    } catch (e) {
      debugPrint('Hata: $e');
    }
    return null;
  }

  @override
  Future<bool> updateUserName(String userID, String yeniUserName) async {
    var users = await _fireStoreDb
        .collection("users")
        .where("userName", isEqualTo: yeniUserName)
        .get();

    if (users.docs.length >= 1) {
      return false;
    } else {
      await _fireStoreDb
          .collection("users")
          .doc(userID)
          .update({"userName": yeniUserName});
      return true;
    }
  }

  Future<bool> updateProfilFoto(String? userId, String profilFotoURL) async {
    await _fireStoreDb
        .collection("users")
        .doc(userId!)
        .update({"profilURL": profilFotoURL});
    return true;
  }
}
