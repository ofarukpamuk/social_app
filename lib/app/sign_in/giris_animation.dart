import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kursgirissayfasifirebase/app/landing_page.dart';

class HeartbeatAnimationPage extends StatefulWidget {
  final String imagePath = "assets/images/logo.png";

  const HeartbeatAnimationPage({super.key});

  @override
  _HeartbeatAnimationPageState createState() => _HeartbeatAnimationPageState();
}

class _HeartbeatAnimationPageState extends State<HeartbeatAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Animasyon kontrolcüsünü oluştur
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Opaklık animasyonunu oluştur
    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 1,
      ),
    ]).animate(_animationController);

    // Animasyonu başlat
    _animationController.repeat(reverse: true);

    // Timer ile sayfanın 3 saniye sonra yönlendirilmesini sağla
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Kalp atışı animasyonu
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Image.asset(
                    widget.imagePath,
                    width: 275.0,
                    height: 220.0,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
