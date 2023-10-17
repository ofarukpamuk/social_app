// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kursgirissayfasifirebase/locator.dart';
import 'package:kursgirissayfasifirebase/model/user_model.dart';
import 'package:kursgirissayfasifirebase/app/data/repository/user_repository.dart';
import 'package:kursgirissayfasifirebase/services/auth_base.dart';

enum ViewState {
  // viewstate ya bıştatır ya da meşguldur(busy) int veri çekiyordur vs
  // ignore: constant_identifier_names
  IDLE,
  // ignore: constant_identifier_names
  Busy
}

class UserViewModel with ChangeNotifier implements AuthBase {
  //, durum, bilgilerini, değiştirmek, için, yine, bizim, bu, fonksiyonlara, ihtiyacımız, var, o, yüzden, kalıtım, alıp, bu, metotları, override, etmemiz, gerekiyor {

  ViewState _viewState = ViewState.IDLE;
  // repo ile konuşması gerekiyor repodan bir nesne ürettik.
  UserRepository userRepository = locator<UserRepository>();
  UserModel? _userModel;
  String? emailHataMesaji;
  String? sifreHataMesaji;

  UserModel? get userModel => _userModel;
  ViewState get state => _viewState;

  set state(ViewState value) {
    _viewState = value;
    notifyListeners(); // state değişimini bildir
  }

  UserViewModel() {
    currentUser();
  }

  @override
  Future<UserModel?> currentUser() async {
    try {
      state = ViewState.Busy;
      // kullanıcı verisi çekilirken state durumunu meşgul yap
      _userModel = await userRepository.currentUser();

      return _userModel;
    } catch (e) {
      debugPrint('Hata: $e');

      return null;
    } finally {
      state = ViewState.IDLE; //state artık boş.
    }
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    try {
      state = ViewState.Busy;
      // kullanıcı verisi çekilirken state durumunu meşgul yap
      _userModel = await userRepository.signInAnonymously();

      return _userModel;
    } catch (e) {
      debugPrint('Hata: $e');

      return null;
    } finally {
      state = ViewState.IDLE; //state artık boş.
    }
  }

  @override
  Future<bool?> signOut() async {
    try {
      state = ViewState.Busy;
      // kullanıcı verisi çekilirken state durumunu meşgul yap
      _userModel = null;

      return await userRepository.signOut();
    } catch (e) {
      debugPrint('Hata: $e');

      return false;
    } finally {
      state = ViewState.IDLE; //state artık boş.
    }
  }

  @override
  Future<UserModel?> signWithGoogle() async {
    try {
      state = ViewState.Busy;
      // kullanıcı verisi çekilirken state durumunu meşgul yap
      _userModel = await userRepository.signWithGoogle();

      return _userModel;
    } catch (e) {
      debugPrint('Hata: $e');

      return null;
    } finally {
      state = ViewState.IDLE; //state artık boş.
    }
  }

  @override
  Future<UserModel?> createUserwithEmailandPassword(
      String email, String sifre) async {
    if (_emailSifreKontrol(email, sifre)) {
      try {
        state = ViewState.Busy;
        // kullanıcı verisi çekilirken state durumunu meşgul yap
        _userModel =
            await userRepository.createUserwithEmailandPassword(email, sifre);
        return _userModel;
      } finally {
        state = ViewState.IDLE;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> signInwithEmailandPassword(
      String email, String sifre) async {
    try {
      if (_emailSifreKontrol(email, sifre)) {
        state = ViewState.Busy;
        // kullanıcı verisi çekilirken state durumunu meşgul yap
        _userModel =
            await userRepository.signInwithEmailandPassword(email, sifre);

        return _userModel;
      } else {
        return null;
      }
    } finally {
      state = ViewState.IDLE; //state artık boş.
    }
  }

  bool _emailSifreKontrol(String email, String sifre) {
    var sonuc = true;
    if (sifre.length < 6) {
      sifreHataMesaji = "şifre en az 6 karakterden oluşmalıdır.";
      sonuc = false;
    }
    if (!email.contains("@")) {
      emailHataMesaji = "geçersiz email adresi";
      sonuc = false;
    }
    return true;
  }

  Future<bool> updateUserName(String userIde, String yeniUserName) async {
    //state = ViewState.Busy;
    bool result = await userRepository.updateUserName(userIde, yeniUserName);
    //state = ViewState.IDLE;
    if (result) {
      _userModel!.userName = yeniUserName;
    }
    return result;
  }

  Future<String> uploadFile(
      String? userId, String fileType, File? profil_foto) async {
    String indirmeLinki =
        await userRepository.uploadFile(userId, fileType, profil_foto);
    return indirmeLinki;
  }
}
