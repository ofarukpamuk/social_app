/* import 'package:flutter/material.dart';
import 'package:kursgirissayfasifirebase/home_page.dart';
import 'package:kursgirissayfasifirebase/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../common_widget/social_login_button.dart';
import '../../model/user_model.dart';

enum FormType {
  REGISTER,
  LOGIN,
}

class EmailveSifreloginPage extends StatefulWidget {
  const EmailveSifreloginPage({super.key});

  @override
  State<EmailveSifreloginPage> createState() => _EmailveSifreloginPageState();
}

class _EmailveSifreloginPageState extends State<EmailveSifreloginPage> {
  String? _email;
  String? _sifre;
  String? _butonText;
  String? _linkText;
  Enum _formType = FormType.LOGIN;
  final _formkey = GlobalKey<FormState>();

  void _formSubmit() async {
    _formkey.currentState?.save();
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    if (_formType == FormType.LOGIN) {
      UserModel? girisYapanUser =
          await userViewModel.signInwithEmailandPassword(_email!, _sifre!);
      if (girisYapanUser != null) {
        debugPrint('oturum açan user ${girisYapanUser.userId}');
      }
    } else {
      UserModel? olusturulanUser =
          await userViewModel.createUserwithEmailandPassword(_email!, _sifre!);
      if (olusturulanUser != null) {
        debugPrint('oturum açan user ${olusturulanUser.userId}');
      }
    }
  }

  void _degistir() {
    setState(() {
      _formType =
          _formType == FormType.LOGIN ? FormType.REGISTER : FormType.LOGIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    _butonText = _formType == FormType.LOGIN ? "Giris Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.LOGIN
        ? "Hesabınız yok mu? kayıt olun "
        : "Hesabınız var mı? Giris Yapın";
    final userViewModel = Provider.of<UserViewModel>(context);

    if (userViewModel.userModel != null) {
      Future.delayed(const Duration(milliseconds: 250), () {
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade800, side: BorderSide.none),
              onPressed: () {},
              child: const Text(
                "CikisYap",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
          title: const Text("giriş kayit "),
        ),
        body: userViewModel.state == ViewState.IDLE
            ? SingleChildScrollView(
                // controller: controller,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                          initialValue: "farukk3032@gmail.com",
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            /* errorText: userViewModel.emailHataMesaji != null
                                ? userViewModel.emailHataMesaji
                                : "", */
                            prefixIcon: const Icon(Icons.email),
                            hintText: 'Email',
                            labelText: 'Email',
                            border: const OutlineInputBorder(),
                          ),
                          onSaved: (mail) {
                            _email = mail;
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        initialValue: "faruk032",
                        obscureText: true,
                        decoration: InputDecoration(
                          /* errorText: userViewModel.sifreHataMesaji != null
                              ? userViewModel.sifreHataMesaji
                              : null, */
                          prefixIcon: const Icon(Icons.mail),
                          hintText: 'Sifre',
                          labelText: 'Sifre',
                          border: const OutlineInputBorder(),
                        ),
                        onSaved: (sifre) {
                          _sifre = sifre;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SocialLoginButton(
                        butonText: _butonText,
                        butonColor: Theme.of(context).primaryColor,
                        radius: 10,
                        onPressed: () => _formSubmit(),
                        butonIcon: const Icon(Icons.login),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _degistir();
                          },
                          child: Text(_linkText.toString()))
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kursgirissayfasifirebase/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:kursgirissayfasifirebase/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import '../../common_widget/social_login_button.dart';
import '../../model/user_model.dart';
import 'hata_exception.dart';

enum FormType {
  REGISTER,
  LOGIN,
}

class EmailveSifreloginPage extends StatefulWidget {
  const EmailveSifreloginPage({Key? key});

  @override
  State<EmailveSifreloginPage> createState() => _EmailveSifreloginPageState();
}

class _EmailveSifreloginPageState extends State<EmailveSifreloginPage> {
  String topImage = "assets/images/logo.png";
  bool _showPassword = false;
  String? _email;
  String? _sifre;
  String? _butonText;
  String? _linkText;
  FormType _formType = FormType.LOGIN;
  final _formkey = GlobalKey<FormState>();

  void _formSubmit() async {
    _formkey.currentState!.save();
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    if (_formType == FormType.LOGIN) {
      try {
        UserModel? girisYapanUser =
            await userViewModel.signInwithEmailandPassword(_email!, _sifre!);
        if (girisYapanUser != null) {
          debugPrint('oturum açan user ${girisYapanUser.userId}');
        }
      } on PlatformException catch (e) {
        debugPrint(
            "widget hata oturum açarken yakalandı ${Hatalar.goster(e.code.toString())}");
        PlatformDuyarliWidgetAlertDialog(
                baslik: "Oturum Açma Oluşturma HATA",
                icerik: Hatalar.goster(e.code.toString()),
                anaButonYazisi: "Tamam")
            .goster(context);
      }
    } else {
      try {
        UserModel? olusturulanUser = await userViewModel
            .createUserwithEmailandPassword(_email!, _sifre!);
        if (olusturulanUser != null) {
          debugPrint('oturum açan user ${olusturulanUser.userId}');
        }
      } on FirebaseAuthException catch (e) {
        debugPrint(e.code.toString() + " efsd f");
        PlatformDuyarliWidgetAlertDialog(
                baslik: "Kullanıcı Oluşturma HATA",
                icerik: Hatalar.goster(e.code),
                anaButonYazisi: "Tamam")
            .goster(context);
      }
    }
  }

  void _degistir() {
    setState(() {
      _formType =
          _formType == FormType.LOGIN ? FormType.REGISTER : FormType.LOGIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    _butonText = _formType == FormType.LOGIN ? "Giriş Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.LOGIN
        ? "Hesabınız yok mu? Kayıt olun"
        : "Hesabınız var mı? Giriş yapın";
    final userViewModel = Provider.of<UserViewModel>(context);

    if (userViewModel.userModel != null) {
      Future.delayed(Duration(milliseconds: 250), () {
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Giriş Kayıt"),
        centerTitle: true,
      ),
      body: userViewModel.state == ViewState.IDLE
          ? SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    topImageContainer(topImage),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                      child: TextFormField(
                        initialValue: "farukk3032@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: const Text("Email"),
                          contentPadding: EdgeInsets.symmetric(
                            // yatay ve dikeyde padding vermek için
                            vertical: 15.0,
                            horizontal: 30.0,
                          ),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 30,
                          ),
                          errorText: userViewModel.emailHataMesaji,
                          hintText: "Email",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        onSaved: (mail) {
                          _email = mail;
                        },
                        validator: (mail) {
                          if (mail!.isEmpty) {
                            return 'Email alanı boş bırakılamaz.';
                          } else if (!mail.contains('@')) {
                            return 'Geçerli bir email adresi girin.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: TextFormField(
                        initialValue: "",
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(
                                color:
                                    _showPassword ? Colors.blue : Colors.grey,
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              }),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.white,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Şifre',
                          labelText: 'Şifre',
                          border:
                              null, // Çerçeveyi kaldırmak için null olarak ayarlandı
                          errorText: userViewModel.sifreHataMesaji,
                        ),
                        onSaved: (sifre) {
                          _sifre = sifre;
                        },
                        validator: (sifre) {
                          if (sifre!.isEmpty) {
                            return 'Şifre alanı boş bırakılamaz.';
                          } else if (sifre.length < 6) {
                            return 'Şifre en az 6 karakter uzunluğunda olmalıdır.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    SocialLoginButton(
                      butonText: _butonText!,
                      butonColor: Theme.of(context).primaryColor,
                      radius: 10,
                      onPressed: _formSubmit,
                      butonIcon: const Icon(Icons.login),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(139, 211, 241, 1)),
                      onPressed: _degistir,
                      child: Text(
                        _linkText!,
                        style: TextStyle(color: Colors.grey.shade900),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
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
 
/* import 'package:flutter/material.dart';
import 'package:kursgirissayfasifirebase/home_page.dart';
import 'package:kursgirissayfasifirebase/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../common_widget/social_login_button.dart';
import '../../model/user_model.dart';

enum FormType {
  REGISTER,
  LOGIN,
}

class EmailveSifreloginPage extends StatefulWidget {
  const EmailveSifreloginPage({Key? key});

  @override
  State<EmailveSifreloginPage> createState() => _EmailveSifreloginPageState();
}

class _EmailveSifreloginPageState extends State<EmailveSifreloginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  String? _butonText;
  String? _linkText;
  FormType _formType = FormType.LOGIN;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    if (_formType == FormType.LOGIN) {
      _emailController.text = "farukk3032@gmail.com";
      _passwordController.text = "faruk032";
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _formSubmit() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      if (_formType == FormType.LOGIN) {
        UserModel? girisYapanUser =
            await userViewModel.signInwithEmailandPassword(
                _emailController.text, _passwordController.text);
        if (girisYapanUser != null) {
          debugPrint('oturum açan user ${girisYapanUser.userId}');
        }
      } else {
        UserModel? olusturulanUser =
            await userViewModel.createUserwithEmailandPassword(
                _emailController.text, _passwordController.text);
        if (olusturulanUser != null) {
          debugPrint('oturum açan user ${olusturulanUser.userId}');
        }
      }

      _emailController.clear();
      _passwordController.clear();
    }
  }

  void _degistir() {
    setState(() {
      _formType =
          _formType == FormType.LOGIN ? FormType.REGISTER : FormType.LOGIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    _butonText = _formType == FormType.LOGIN ? "Giriş Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.LOGIN
        ? "Hesabınız yok mu? Kayıt olun"
        : "Hesabınız var mı? Giriş yapın";
    final userViewModel = Provider.of<UserViewModel>(context);

    if (userViewModel.userModel != null) {
      Future.delayed(Duration(milliseconds: 250), () {
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade800,
              side: BorderSide.none,
            ),
            onPressed: () {},
            child: const Text(
              "Çıkış Yap",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        title: const Text("Giriş Kayıt"),
      ),
      body: userViewModel.state == ViewState.IDLE
          ? SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: 'Email',
                        labelText: 'Email',
                        border: const OutlineInputBorder(),
                        errorText: userViewModel.emailHataMesaji,
                      ),
                      onSaved: (mail) {
                        _emailController.text = mail!;
                      },
                      validator: (mail) {
                        if (mail!.isEmpty) {
                          return 'Email alanı boş bırakılamaz.';
                        } else if (!mail.contains('@')) {
                          return 'Geçerli bir email adresi girin.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Şifre',
                        labelText: 'Şifre',
                        border: const OutlineInputBorder(),
                        errorText: userViewModel.sifreHataMesaji,
                      ),
                      onSaved: (sifre) {
                        _passwordController.text = sifre!;
                      },
                      validator: (sifre) {
                        if (sifre!.isEmpty) {
                          return 'Şifre alanı boş bırakılamaz.';
                        } else if (sifre.length < 6) {
                          return 'Şifre en az 6 karakter uzunluğunda olmalıdır.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    SocialLoginButton(
                      butonText: _butonText!,
                      butonColor: Theme.of(context).primaryColor,
                      radius: 10,
                      onPressed: _formSubmit,
                      butonIcon: const Icon(Icons.login),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _degistir,
                      child: Text(_linkText!),
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
 */