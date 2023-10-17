// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum TabItem { Kullanicilar, Profil, Akran }

class TabItemData {
  final String title;
  final IconData icon;
  TabItemData({
    required this.title,
    required this.icon,
  });
  static Map<TabItem, TabItemData> tumTablar = {
    TabItem.Kullanicilar: TabItemData(title: "Kullanıcılar", icon: Icons.home),
    TabItem.Akran:
        TabItemData(title: "Akış", icon: Icons.supervised_user_circle),
    TabItem.Profil: TabItemData(title: "Profil", icon: Icons.person),
  };
}
