import 'package:kursgirissayfasifirebase/model/user_model.dart';

abstract class AuthBase {
  Future<UserModel?> currentUser();
  Future<UserModel?> signInAnonymously();
  Future<UserModel?> signWithGoogle();
  Future<bool?> signOut();
  Future<UserModel?> signInwithEmailandPassword(String email, String sifre);
  Future<UserModel?> createUserwithEmailandPassword(String email, String sifre);
}
