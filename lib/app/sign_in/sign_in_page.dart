// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kursgirissayfasifirebase/app/sign_in/email_sifre_giris_ve_kayit.dart';
import 'package:kursgirissayfasifirebase/common_widget/social_login_button.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../../viewmodel/user_view_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  Future<void> _googleIleGiris(BuildContext context) async {
    try {
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      UserModel? userModel = await userViewModel.signWithGoogle();
      if (userModel != null)
        debugPrint('Anonim giriş yapıldı: ${userModel.userId}');
    } catch (e) {
      // Giriş başarısız, hata mesajı e.message üzerinden erişilebilir
      debugPrint('Anonim giriş yapılamadı: $e');
    }
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      UserModel? userModel = await userViewModel.signInAnonymously();
      debugPrint('Anonim giriş yapıldı: ${userModel?.userId}');
    } catch (e) {
      // Giriş başarısız, hata mesajı e.message üzerinden erişilebilir
      debugPrint('Anonim giriş yapılamadı: $e');
    }
  }

  void _emailveSifreGiris(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const EmailveSifreloginPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    String topImage = "assets/images/logo.png";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                topImageContainer(topImage),
                SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 60,
                  child: Text(
                    "Hoşgeldiniz...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 187, 187, 187),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SocialLoginButton(
                  butonIcon:
                      Image.asset("assets/images/google-favicon-logo-20.png"),
                  butonColor: Colors.white,
                  butonText: "Gmail ile Giriş Yap",
                  radius: 16,
                  textColor: Colors.black,
                  onPressed: () {
                    _googleIleGiris(context);
                  },
                ),
                SocialLoginButton(
                  butonIcon: const Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 28,
                  ),
                  butonColor: Colors.purple,
                  butonText: "Email ve Şifre ile Giriş Yap",
                  radius: 16,
                  textColor: Colors.white,
                  onPressed: () {
                    _emailveSifreGiris(context);
                  },
                ),
                SocialLoginButton(
                  butonIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                  butonColor: Color.fromARGB(255, 12, 46, 74),
                  butonText: "Anonim Giriş Yap",
                  radius: 16,
                  textColor: Colors.white,
                  onPressed: () {
                    _signInAnonymously(context);
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Container topImageContainer(String topImage) {
    return Container(
      height: 200,
      width: 180,
      //height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage(topImage),
        ),
      ),
    );
  }
}
