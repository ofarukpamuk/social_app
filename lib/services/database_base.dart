import 'package:kursgirissayfasifirebase/model/user_model.dart';

abstract class DbBase {
  Future<bool> saveUser(UserModel user);
  Future<UserModel?> readUser(String userID);
  Future<bool> updateUserName(String userID, String yeniUserName);
}
