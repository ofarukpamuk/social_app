import 'package:kursgirissayfasifirebase/model/user_model.dart';
import 'package:kursgirissayfasifirebase/services/auth_base.dart';

class FakeAuthService implements AuthBase {
  final _userId = "132132132132132132132";
  @override
  Future<UserModel?> currentUser() async {
    return await Future.value(
      UserModel(userId: _userId, email: "fakeuser@fakeuser.mail.com"),
    );
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () => UserModel(userId: _userId, email: "fakeuser@fakeuser.mail.com"),
    );
  }

  @override
  Future<bool?> signOut() async {
    return await Future.value(true);
  }

  @override
  Future<UserModel?> signWithGoogle() async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () => UserModel(
          userId: "google_user _ID_464+61+61",
          email: "fakeuser@fakeuser.mail.com"),
    );
  }

  @override
  Future<UserModel?> createUserwithEmailandPassword(
      String email, String sifre) async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () => UserModel(
          userId: "created_user_ID_464+61+61",
          email: "fakeuser@fakeuser.mail.com"),
    );
  }

  @override
  Future<UserModel?> signInwithEmailandPassword(
      String email, String sifre) async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () => UserModel(
          userId: "created_user_ID_464+61+61",
          email: "fakeuser@fakeuser.mail.com"),
    );
  }
}
