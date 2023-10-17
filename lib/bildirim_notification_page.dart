import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kursgirissayfasifirebase/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class NotificationPagess extends StatefulWidget {
  NotificationPagess({Key? key}) : super(key: key);

  @override
  _NotificationPagessState createState() => _NotificationPagessState();
}

class _NotificationPagessState extends State<NotificationPagess> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
        appBar:
            AppBar(backgroundColor: Colors.transparent, elevation: 0, actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 6),
            child: CircleAvatar(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      userViewModel.userModel!.profilURL.toString(),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: CircleAvatar(
                  child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://www.neoldu.com/d/other/unsuz-turk-erkekler1-001.jpg",
                            ),
                          )))),
              title: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Ali ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: 'Seni Takip Etti',
                )
              ])),
              subtitle: Text('9 dk önce '),
              trailing: Icon(Icons.delete, color: Colors.grey),
            ),
            ListTile(
              leading: CircleAvatar(
                child: CircleAvatar(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://im.haberturk.com/2017/11/09/ver1513694954/1707222_620x410.jpg",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              title: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Aslı',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: ' Bir Gönderi Paylaştı ',
                )
              ])),
              subtitle: Text('47 dakika önce '),
              trailing: Icon(Icons.delete, color: Colors.grey),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCHj91c9W7npi0MICRTelv0EW3YD_ftEdL5JDA-4z963lSKLWn4BO2rdSeN1q0tKYBLYw&usqp=CAU",
                      ),
                    ),
                  ),
                ),
              ),
              title: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Burak',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: ' Takip İsteğini Kabul Etti',
                )
              ])),
              subtitle: Text('9 dakika önce '),
              trailing: Icon(Icons.delete, color: Colors.grey),
            ),
          ],
        ));
  }
}
