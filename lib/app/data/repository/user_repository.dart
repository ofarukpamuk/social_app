import 'dart:io';
import 'package:kursgirissayfasifirebase/locator.dart';
import 'package:kursgirissayfasifirebase/model/user_model.dart';
import 'package:kursgirissayfasifirebase/services/auth_base.dart';
import 'package:kursgirissayfasifirebase/services/fake_auth_service.dart';
import 'package:kursgirissayfasifirebase/services/firebase_storage_Service.dart';
import 'package:kursgirissayfasifirebase/services/firestore_db_service.dart';
import '../../../services/firebase_auth_service.dart';

enum AppMode {
  // uygulamanın durumu için yazdık veri tabanı kodu yazılmış ise relase yazılmamışsa debug mode
  // ignore: constant_identifier_names
  DEBUG,
  // ignore: constant_identifier_names
  RELASE
}

class UserRepository implements AuthBase {
  FirebaseAuthService firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthService fakeAuthService = locator<FakeAuthService>();
  FireStoreDbService firestoreDbService = locator<FireStoreDbService>();
  FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();

  AppMode appMode = AppMode.RELASE;
  @override
  Future<UserModel?> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await fakeAuthService.currentUser();
    } else {
      UserModel? usermodel = await firebaseAuthService.currentUser();
      return await firestoreDbService.readUser(usermodel?.userId);
    }
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    if (appMode == AppMode.DEBUG) {
      return await fakeAuthService.signInAnonymously();
    } else {
      return await firebaseAuthService.signInAnonymously();
    }
  }

  @override
  Future<bool?> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await fakeAuthService.signOut();
    } else {
      return await firebaseAuthService.signOut();
    }
  }

  @override
  Future<UserModel?> signWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await fakeAuthService.signWithGoogle();
    } else {
      UserModel? usermodel = await firebaseAuthService.signWithGoogle();
      bool sonuc = await firestoreDbService.saveUser(usermodel!);
      if (sonuc == true) {
        return usermodel;
      } else {
        return null;
      }
    }
  }

  @override
  Future<UserModel?> createUserwithEmailandPassword(
      String email, String sifre) async {
    if (appMode == AppMode.DEBUG) {
      return await fakeAuthService.createUserwithEmailandPassword(email, sifre);
    } else {
      UserModel? usermodel = await firebaseAuthService
          .createUserwithEmailandPassword(email, sifre);
      bool sonuc = await firestoreDbService.saveUser(usermodel);
      if (sonuc == true && usermodel != null) {
        return await firestoreDbService.readUser(usermodel.userId!);
      } else {
        return null;
      }
    }
  }

  @override
  Future<UserModel?> signInwithEmailandPassword(
      String email, String sifre) async {
    if (appMode == AppMode.DEBUG) {
      return await fakeAuthService.signInwithEmailandPassword(email, sifre);
    } else {
      UserModel? uModel =
          await firebaseAuthService.signInwithEmailandPassword(email, sifre);
      if (uModel != null) {
        return await firestoreDbService.readUser(uModel.userId!);
      } else {
        return null;
      }
    }
  }

  Future<bool> updateUserName(String userIde, String yeniUserName) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await firestoreDbService.updateUserName(userIde, yeniUserName);
    }
  }

  Future<String> uploadFile(
      String? userId, String fileType, File? profil_foto) async {
    if (appMode == AppMode.DEBUG) {
      return "dosya indirme linki ";
    } else {
      String profilFotoURL = await _firebaseStorageService.uploadFile(
          userId!, fileType, profil_foto!);

      await firestoreDbService.updateProfilFoto(userId, profilFotoURL);

      return profilFotoURL;
    }
  }
}
