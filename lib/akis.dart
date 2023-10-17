import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kursgirissayfasifirebase/post_ve_dashboard/post_widget.dart';
import 'package:kursgirissayfasifirebase/services/feed_controller.dart';

import 'common_widget/icerik_icon_more_horiz.dart';
import 'mentor_form.dart';
import 'model/feed_model.dart';

class Akis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 165, right: 165),
        child: Container(
          height: 55,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.09),
              spreadRadius: 2.2,
            )
          ], color: Colors.grey[900], borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  /*  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuDashboard(),
                      )); */
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.grey,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ), */
      appBar: AppBar(
          elevation: 30,
          backgroundColor: Color.fromARGB(255, 23, 23, 23),
          flexibleSpace: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Gönderiler Sayfası",
                  style: TextStyle(fontSize: 25, color: Colors.grey.shade400),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ))),
      // backgroundColor: Color.fromARGB(69, 67, 76, 75),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: PostWidget(),
            )
          ],
        ),
      ),
    );
  }
}

class Danismanlar extends StatefulWidget {
  const Danismanlar({super.key});

  @override
  State<Danismanlar> createState() => _DanismanlarState();
}

class _DanismanlarState extends State<Danismanlar> {
  late Future<List<Feed>> _feedListFuture;

  @override
  void initState() {
    super.initState();
    _feedListFuture = FeedController.getFeedList();
  }

  @override
/*   Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.09),
                    spreadRadius: 2.2,
                  ),
                ],
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            //width: 48,
                            child: const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/foto6.PNG'),
                              radius: 26,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Sevval Önal",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.grey),
                                ),
                                Text(
                                  "Bilgisayar mühendisliği",
                                  style: TextStyle(color: Colors.white54),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          MoreHoriz.buildCustomBottomSheetFeedcomplaint(
                              context);
                        },
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Bilgisayar mühensisliği 4. sınıf",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      height: 180,
                      width: double.maxFinite,
                      child: Text(
                        "Ben okulumuza 2019 da katıldım \nilgi alanlarım: \nAlgoritma tasarımı,\nVeri analizi,\nMobil uygulama geliştirme."
                        "\nProgramlama dilleri: python, c, Java, Dart\n"
                        "Yabancı dil: B1-B2 ingilizce ",
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                              )
                            ],
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                MyPopupWindow.show(context);
                              },
                              icon: const Icon(Icons.forward_to_inbox_rounded,
                                  size: 24, color: Colors.blue),
                            ),
                            const Text(
                              "Konu ilet",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.mood,
                                size: 24,
                                color: Colors.yellow,
                              ),
                            ),
                            const Text(
                              "150",
                              style: TextStyle(color: Colors.grey),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.mood_bad,
                                size: 24,
                                color: Colors.yellow,
                              ),
                            ),
                            const Text(
                              "2",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
} */
  Widget build(BuildContext context) {
    List<String> fotolist = [
      "https://st1.myideasoft.com/shop/mr/95/myassets/products/798/dijital-vitrin-bay-doktor-8.jpg?revision=1648115808",
      "https://cdn.pixabay.com/photo/2016/04/13/19/20/binary-1327492_1280.jpg",
      "https://www.teknozum.com/wp-content/uploads/2019/12/whatsapp-profil-foto%C4%9Fraflar%C4%B1-17-1024x1024.jpg"
    ];
    return FutureBuilder<List<Feed>>(
      future: _feedListFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Feed>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Yükleniyor göstergesi
        } else if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}'); // Hata mesajı
        } else {
          final feedList = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: feedList.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final feed = feedList[index];
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.09),
                          spreadRadius: 2.2,
                        ),
                      ],
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  //width: 48,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(fotolist[index]),
                                    radius: 26,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        feed.username.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        feed.department.toString(),
                                        style: TextStyle(color: Colors.white54),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                MoreHoriz.buildCustomBottomSheetFeedcomplaint(
                                    context);
                              },
                              icon: const Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          feed.department.toString(),
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            height: 180,
                            width: double.maxFinite,
                            child: Text(
                              feed.biyografi!.toString(),
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade400),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 2,
                                    )
                                  ],
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      MyPopupWindow.show(context);
                                    },
                                    icon: const Icon(
                                        Icons.forward_to_inbox_rounded,
                                        size: 24,
                                        color: Colors.blue),
                                  ),
                                  const Text(
                                    "Konu ilet",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.mood,
                                      size: 24,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  const Text(
                                    "150",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.mood_bad,
                                      size: 24,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  const Text(
                                    "2",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}

class MyPopupWindow {
  static Future<void> show(BuildContext context) async {
    String? subject;
    String? content;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('Akrana Sor'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 16),
                    labelText: 'Konu',
                  ),
                  onChanged: (value) {
                    subject = value;
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'İçerik',
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                  onChanged: (value) {
                    content = value;
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('İptal'),
              ),
              ElevatedButton(
                onPressed: () {
                  // İşlenecek verileri burada kullanabilirsiniz (subject ve content).
                  print('Konu: $subject');
                  print('İçerik: $content');

                  Navigator.of(context).pop();
                },
                child: const Text('Gönder'),
              ),
            ],
          ),
        );
      },
    );
  }
}
