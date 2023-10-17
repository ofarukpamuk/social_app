import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kursgirissayfasifirebase/app/landing_page.dart';
import 'package:kursgirissayfasifirebase/locator.dart';
import 'package:kursgirissayfasifirebase/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

import 'app/sign_in/giris_animation.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase'i başlatıyoruz
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserViewModel>(
      create: (context) => UserViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const HeartbeatAnimationPage(),
      ),
    );
  }
}
