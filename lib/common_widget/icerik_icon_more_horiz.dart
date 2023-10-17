import 'package:flutter/material.dart';

class MoreHoriz {
  static Future buildCustomBottomSheetFeedcomplaint(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.report),
                title: Text('Şikayet Et'),
                onTap: () {
                  // Şikayet etme işlemleri
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.block),
                title: Text('Engelle'),
                onTap: () {
                  // Engelleme işlemleri
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.visibility_off),
                title: Text('Görmek İstemiyorum'),
                onTap: () {
                  // Görmek istememe işlemleri
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
