// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kursgirissayfasifirebase/akis.dart';
import 'package:kursgirissayfasifirebase/app/kullanicilar.dart';
import 'package:kursgirissayfasifirebase/app/my_custom_bottom_navi.dart';
import 'package:kursgirissayfasifirebase/app/profil.dart';
import 'package:kursgirissayfasifirebase/app/tab_items.dart';
import 'package:kursgirissayfasifirebase/model/user_model.dart';

class HomePage extends StatefulWidget {
  final UserModel? userModel;

  const HomePage({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.Kullanicilar;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.Kullanicilar: GlobalKey<NavigatorState>(),
    TabItem.Profil: GlobalKey<NavigatorState>(),
    TabItem.Akran: GlobalKey<NavigatorState>(),
  };
  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.Kullanicilar: KullanicilarPage(),
      TabItem.Akran: Akis(),
      TabItem.Profil: ProfilPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await navigatorKeys[_currentTab]!.currentState!.maybePop();
      },
      child: Container(
        child: MyCustomBottomNavigator(
          navigatorKeys: navigatorKeys,
          sayfaOlusturucu: tumSayfalar(),
          currentTab: _currentTab,
          onSelectedTab: (secilentab) {
            if (secilentab == _currentTab) {
              navigatorKeys[secilentab]
                  ?.currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                _currentTab = secilentab;
              });
            }

            debugPrint("secilen tab item " + secilentab.toString());
          },
        ),
      ),
    );
  }
}
/* Future<bool?> _cikisYap(UserViewModel userViewModel) async {
    var result = await userViewModel.signOut();
    return result;
  } */