import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_instagram_storyboard/flutter_instagram_storyboard.dart';
import 'package:kursgirissayfasifirebase/app/profil.dart';
import 'package:kursgirissayfasifirebase/search/search_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../akis.dart';
import '../bildirim_notification_page.dart';
import '../mentor_form.dart';
import '../viewmodel/user_view_model.dart';
import 'chat_page.dart';

final TextStyle menuTextStyle = TextStyle(color: Colors.white, fontSize: 20);

class KullanicilarPage extends StatefulWidget {
  const KullanicilarPage({super.key});

  @override
  State<KullanicilarPage> createState() => _KullanicilarPageState();
}

class _KullanicilarPageState extends State<KullanicilarPage>
    with SingleTickerProviderStateMixin {
  File? _profil_Foto;
  String googleAddress = 'https://servis.erzurum.edu.tr/yemeklistesi/';
  static const double _borderRadius = 60.0;
  // iç menunun de scale olarak kücülmesi için kullanacagımız animasyon için dahil ettigimiz sınıf
  int _selectedItemIndex = 0;
  late double ekranYuksekligi, ekranGenisligi;
  bool menuAcikmi = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _scaleMenuAnimation;
  late Animation<Offset>
      _menuOffsetAnimation; // yazıların da menuye gore hareket etmesi için yeni bir animasyon tanımladık
  //double deger vemeyeceğiz çünkü yazıların soldan gelmesini falan sağlamak için ofset kullanmak daha mantıklı

  final Duration _duration = Duration(milliseconds: 350);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.6).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint));
    _scaleMenuAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Curves.easeInOutQuint)); // yazı anşmasyonu
    _menuOffsetAnimation = Tween(
            begin: Offset(-1, 0), end: Offset(0, 0)) // ofset rotasyon alır
        .animate(CurvedAnimation(
            parent: _controller,
            curve: Curves
                .easeIn)); // curveler efektli geçişler sağlar lineer geçişler sağlamaz yani
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    ekranYuksekligi = MediaQuery.of(context).size.height;
    ekranGenisligi = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        // status barın altına geçmek için ekranda kullanılabilir yerler, kapsayan widget
        child: Stack(
          children: <Widget>[
            menuOlustur(context, userViewModel),
            dashBoardOlustur(context),
          ],
        ),
      ),
    );
  }

  Widget menuOlustur(BuildContext context, UserViewModel userViewModel) {
    return SlideTransition(
      // animasyonu soldan saga getirmek için   widget
      position: _menuOffsetAnimation,
      child: ScaleTransition(
        scale: _scaleMenuAnimation,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 50, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: _profil_Foto == null
                                  ? NetworkImage(userViewModel
                                      .userModel!.profilURL
                                      .toString())
                                  : Image.file(File(_profil_Foto!.path)).image,
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilPage(),
                            ));
                      },
                      child: Text(
                        userViewModel.userModel!.userName.toString(),
                        style: menuTextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      userViewModel.userModel!.email.toString(),
                      style: TextStyle(fontSize: 15, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Align(
                // stacklerde align kullanılır
                alignment: Alignment.centerLeft, // ekranı soldan ortala
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 55,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Ders Notları",
                      style: menuTextStyle,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Harf Notu Hesabı",
                      style: menuTextStyle,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _launchURL(googleAddress);
                      },
                      child: Text(
                        "Etu Yemek listesi",
                        style: menuTextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      child: Text(
                        "Akran Ol",
                        style: menuTextStyle,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => KariyerFormu()));
                      },
                    ),
                    const SizedBox(
                      height: 110,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                )); */
                          },
                          icon: Icon(
                            size: 30,
                            Icons.logout_outlined,
                            color: Colors.white70,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                )); */
                          },
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _cikisYap(context);
                              });
                            },
                            child: const Text('Çıkış yap',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashBoardOlustur(BuildContext context) {
    return AnimatedPositioned(
      // elemanlarımız stack yapısında oldugu için üst üste geliyor alttaki sayfayı açığa cıkartmak için bu widgeti kullanacağızz
      curve: Curves.easeInOutQuint,
      duration:
          _duration, // acılır ekranın kaç saniyede acılacagı zorunu bir parametredir required,
      top: 0,
      bottom: 0,
      left: menuAcikmi ? 0.28 * ekranGenisligi : 0,
      right: menuAcikmi ? -0.4 * ekranGenisligi : 0,
      child: ScaleTransition(
        // iç sayfanın buyuyup kuculmesini kontrol edecek
        scale: _scaleAnimation,
        child: Material(
          // gölgelik vs özellikleri kullanabilmek için material widget kullandık
          borderRadius: menuAcikmi
              ? BorderRadius.all(Radius.circular(40))
              : null, // kenarı oval yapma menu açıksa kapalıysa oval yap
          elevation: 8.0,
          color: Colors.grey.shade900,
          child: SingleChildScrollView(
            // olusturulan listenin taşma yapmaması aşagı dogru genişlemesi için
            child: Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        // icona tıklama özelliği getirmek için
                        onTap: () {
                          setState(() {
                            if (menuAcikmi) // menu acık ise animasyonu geri al
                              _controller.reverse();
                            else
                              _controller
                                  .forward(); // animasyonu uygula menu kapalıysa
                            menuAcikmi = !menuAcikmi;
                          });
                        },
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 67,
                      ),
                      const Text(
                        "Etu Akran",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationPagess()),
                          );
                        },
                        icon: const Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Searchpage()),
                          );
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(),
                              ));
                        },
                        icon: Icon(
                          size: 30,
                          Icons.message_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Duyurular",
                    style: TextStyle(),
                  ),
                  storywidgett(),
                  // Story(),
                  //HomePage(),
                  //PostWidget(),
                  Danismanlar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listelemani(String imagePath) {
    return Column(
      children: [
        Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: DecorationImage(
                  image: AssetImage(imagePath), fit: BoxFit.cover)),
        ),
      ],
    );
  }

  Widget alt_Menu() {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
            )
          ],
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KullanicilarPage(),
                  ));
            },
            icon: Icon(
              size: 30,
              Icons.home,
              color: Colors.grey,
            ),
          ),

          IconButton(
            onPressed: () {
              /* Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  //akran_prog();
                },
              )); */
            },
            icon: Icon(
              Icons.people_rounded,
              color: Colors.grey,
              size: 30,
            ),
          ),

          //buildNavBarItem(Icons.arrow_left_rounded, -1),
          GestureDetector(child: buildNavBarItem(Icons.notifications, 2)),

          GestureDetector(child: buildNavBarItem(Icons.local_activity, 3)),

          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilPage(),
                  ));
            },
            icon: Icon(
              size: 30,
              Icons.person,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 50,
        child: icon != null
            ? Icon(
                icon,
                size: 30,
                color: index == _selectedItemIndex
                    ? Colors.black
                    : Colors.grey[700],
              )
            : Container(),
      ),
    );
  }

  Widget storywidgett() {
    return StoryListView(
      listHeight: 135.0,
      pageTransform: const StoryPage3DTransform(),
      buttonDatas: [
        StoryButtonData(
          timelineBackgroundColor: Colors.red,
          buttonDecoration: buildButtonDecoration('assets/images/foto1.PNG'),
          child: buildButtonChild(''),
          borderDecoration: buildBorderDecoration(Colors.red),
          segmentDuration: const Duration(seconds: 3),
          storyPages: [
            createDummyPage(
              imageName: "assets/images/foto1.PNG",
              addBottomBar: false,
            ),
          ],
        ),
        StoryButtonData(
          timelineBackgroundColor: Colors.blue,
          buttonDecoration: buildButtonDecoration('assets/images/foto2.PNG'),
          borderDecoration:
              buildBorderDecoration(const Color.fromARGB(255, 134, 119, 95)),
          child: Container(),
          storyPages: [
            createDummyPage(
              imageName: "assets/images/foto2.PNG",
              addBottomBar: false,
            ),
          ],
          segmentDuration: const Duration(seconds: 3),
        ),
        StoryButtonData(
          timelineBackgroundColor: Colors.orange,
          borderDecoration: buildBorderDecoration(Colors.orange),
          buttonDecoration: buildButtonDecoration('assets/images/foto3.PNG'),
          child: Container(),
          storyPages: [
            createDummyPage(
              imageName: "assets/images/foto3.PNG",
              addBottomBar: false,
            ),
          ],
          segmentDuration: const Duration(seconds: 5),
        ),
        StoryButtonData(
          timelineBackgroundColor: Colors.red,
          buttonDecoration: buildButtonDecoration('assets/images/foto4.PNG'),
          child: Container(),
          borderDecoration: buildBorderDecoration(Colors.red),
          storyPages: [
            createDummyPage(
              imageName: "assets/images/foto4.PNG",
              addBottomBar: false,
            ),
          ],
          segmentDuration: const Duration(seconds: 3),
        ),
        StoryButtonData(
          buttonDecoration: buildButtonDecoration('assets/images/foto5.PNG'),
          borderDecoration:
              buildBorderDecoration(const Color.fromARGB(255, 134, 119, 95)),
          child: buildButtonChild(''),
          storyPages: [
            createDummyPage(
              imageName: "assets/images/foto2.PNG",
              addBottomBar: false,
            ),
            createDummyPage(
              imageName: "assets/images/foto3.PNG",
              addBottomBar: false,
            ),
            createDummyPage(
              imageName: "assets/images/foto4.PNG",
              addBottomBar: false,
            ),
          ],
          segmentDuration: const Duration(seconds: 3),
        ),
        StoryButtonData(
          isVisibleCallback: () {
            return false;
          },
          timelineBackgroundColor: Colors.orange,
          borderDecoration: buildBorderDecoration(Colors.orange),
          buttonDecoration: buildButtonDecoration('assets/images/foto3.PNG'),
          child: buildButtonChild('assets/images/foto4.PNG'),
          storyPages: [
            createDummyPage(
              imageName: "assets/images/foto3.PNG",
            ),
          ],
          segmentDuration: const Duration(seconds: 5),
        ),
      ],
    );
  }

  Widget createDummyPage({
    //required String text,
    required String imageName,
    bool addBottomBar = true,
  }) {
    return StoryPageScaffold(
      bottomNavigationBar: addBottomBar
          ? SizedBox(
              width: double.infinity,
              height: kBottomNavigationBarHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            _borderRadius,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              imageName,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonChild(String text) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100.0,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 11.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  BoxDecoration buildButtonDecoration(
    String imageName,
  ) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(_borderRadius),
      image: DecorationImage(
        image: AssetImage(imageName),
        fit: BoxFit.cover,
      ),
    );
  }

  BoxDecoration buildBorderDecoration(Color color) {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(_borderRadius),
      ),
      border: Border.fromBorderSide(
        BorderSide(
          color: color,
          width: 1.75,
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      if (!await launch(url)) {
        //mode: LaunchMode.inAppWebView;
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      // Hata yakalandığında burada işlenebilir veya raporlanabilir
      print('URL açılırken bir hata oluştu: $e');
    }
  }

  Future<bool?> _cikisYap(BuildContext context) async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    var result = await userViewModel.signOut();
    return result;
  }
}
