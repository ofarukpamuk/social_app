import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kursgirissayfasifirebase/model/user_model.dart';
import 'package:kursgirissayfasifirebase/services/auth_base.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<UserModel?> currentUser() async {
    try {
      // ignore: await_only_futures
      User? user = await _firebaseAuth.currentUser;
      UserModel? result = _userFromFirebase(user: user);

      return result;
    } catch (e) {
      debugPrint('Hata: $e');
      return null;
    }
  }

  UserModel? _userFromFirebase({User? user}) {
    if (user == null) {
      return null;
    } else {
      return UserModel(userId: user.uid, email: user.email);
    }
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      debugPrint("Geçici hesapla oturum açıldı.");

      return _userFromFirebase(user: userCredential.user);
    } catch (e) {
      debugPrint("anonim giriş hatası");
      return null;
    }
  }

  @override
  Future<bool?> signOut() async {
    try {
      final _googleSignIn = GoogleSignIn();

      await _googleSignIn.signOut();

      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint('Hata: $e');
      return false;
    }
  }

  @override
  Future<UserModel?> signWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;

      if (_googleAuth.accessToken != null && _googleAuth.idToken != null) {
        UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          accessToken: _googleAuth.accessToken,
          idToken: _googleAuth.idToken,
        ));
        User? user = userCredential.user;
        return _userFromFirebase(user: user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  /* Future<UserModel?> createUserwithEmailandPassword(
      String email, String sifre) async {
    try {
      UserCredential? userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: sifre);
      debugPrint("email şifre hesapla oturum açıldı.");
      return _userFromFirebase(user: userCredential.user);
    } on PlatformException catch (e) {
      debugPrint(e.code + " sfsfsdfsf");
      return null;
    }
  } */
  @override
  Future<UserModel?> createUserwithEmailandPassword(
      String email, String sifre) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: sifre);
    debugPrint("email şifre hesapla oturum açıldı.");
    return _userFromFirebase(user: userCredential.user);
  }

  @override
  Future<UserModel?> signInwithEmailandPassword(
      String email, String sifre) async {
    UserCredential? userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: sifre);
    debugPrint("email şifre oturum açıldı.");
    return _userFromFirebase(user: userCredential.user);
  }
}
