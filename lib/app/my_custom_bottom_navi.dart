// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:kursgirissayfasifirebase/app/tab_items.dart';

class MyCustomBottomNavigator extends StatelessWidget {
  const MyCustomBottomNavigator({
    Key? key,
    required this.currentTab,
    required this.onSelectedTab,
    required this.sayfaOlusturucu,
    required this.navigatorKeys,
  }) : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> sayfaOlusturucu;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _navItemOlustur(TabItem.Kullanicilar),
          _navItemOlustur(TabItem.Profil),
          _navItemOlustur(TabItem.Akran),
        ],
        onTap: (value) {
          onSelectedTab(TabItem.values[value]);
        },
      ),
      tabBuilder: (context, index) {
        final olusacakSayfaIndexi = TabItem.values[index];

        return CupertinoTabView(
          builder: (context) {
            return sayfaOlusturucu[olusacakSayfaIndexi]!;
          },
          navigatorKey: navigatorKeys[olusacakSayfaIndexi],
        );
      },
    );
  }

  BottomNavigationBarItem _navItemOlustur(TabItem tabItem) {
    final olusturulacakTab = TabItemData.tumTablar[tabItem];
    return BottomNavigationBarItem(
        icon: Icon(olusturulacakTab?.icon),
        label: olusturulacakTab?.title.toString());
  }
}
