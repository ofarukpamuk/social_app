// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String? butonText;
  final Color? butonColor;
  final Color? textColor;
  final double? radius;
  final double? textsize;
  final double? yukseklik;
  final Widget? butonIcon;
  final VoidCallback onPressed;

  const SocialLoginButton({
    Key? key,
    this.butonText,
    this.textsize = 15,
    this.radius,
    this.butonColor,
    this.textColor,
    this.yukseklik,
    this.butonIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: butonColor!,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius!),
            )),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 12,
              // ignore: sort_child_properties_last
              child: butonIcon!,
              backgroundColor: Colors.transparent,
            ), // İkonu belirtin
            const SizedBox(
                width: 15), // İkon ve metin arasında bir boşluk ekleyin
            Text(
              butonText!,
              style: TextStyle(
                  color: textColor ?? Colors.white, fontSize: textsize ?? 16),
            ), // Butonun metnini belirtin
          ],
        ));
  }
}
