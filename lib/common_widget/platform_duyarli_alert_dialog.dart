import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'platform_duyarli_widget.dart';

class PlatformDuyarliWidgetAlertDialog extends PlatformDuyarliWidget {
  final String baslik;
  final String icerik;
  final String anaButonYazisi;
  final String iptalButonYazisi;

  const PlatformDuyarliWidgetAlertDialog(
      {super.key,
      required this.baslik,
      required this.icerik,
      required this.anaButonYazisi,
      this.iptalButonYazisi = ""});

  Future<bool> goster(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => this,
          )
        : await showDialog(
            context: context,
            builder: (context) => this,
            barrierDismissible: false);
  }

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      content: Text(icerik),
      title: Text(baslik),
      actions: _dialogButonlariniAyarla(context),
    );
  }

  @override
  Widget buildIOSWidget(BuildContext context) {
    return CupertinoAlertDialog(
      content: Text(icerik),
      title: Text(baslik),
      actions: _dialogButonlariniAyarla(context),
    );
  }

  List<Widget> _dialogButonlariniAyarla(BuildContext context) {
    final tumButonlar = <Widget>[];
    if (Platform.isIOS) {
      if (iptalButonYazisi.length > 1) {
        tumButonlar.add(
          CupertinoDialogAction(
            child: Text(iptalButonYazisi),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        );
      }

      tumButonlar.add(
        CupertinoDialogAction(
          child: Text(anaButonYazisi),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    } else {
      if (iptalButonYazisi.length > 1) {
        tumButonlar.add(
          ElevatedButton(
            child: Text(iptalButonYazisi),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        );
      }
      tumButonlar.add(
        ElevatedButton(
          child: Text(anaButonYazisi),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    }
    return tumButonlar;
  }
}
