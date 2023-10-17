import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kursgirissayfasifirebase/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:kursgirissayfasifirebase/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:video_player/video_player.dart';

import 'data/postlar_json.dart';

//import '../post_ve_dashboard/postlar_json.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late VideoPlayerController _controller;
  bool isPhoto = true;

  File? _profil_Foto;
  late TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _kameradanFotoCek() async {
    XFile? yeni_Resim2 =
        (await ImagePicker().pickImage(source: ImageSource.camera));
    File yeni_Resim = File(yeni_Resim2!.path);
    setState(() {
      _profil_Foto = yeni_Resim;
      Navigator.of(context).pop();
    });
  }

  Future<void> _galeridenSec() async {
    var yeni_Resim2 =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File yeni_Resim = File(yeni_Resim2!.path);
    setState(() {
      _profil_Foto = yeni_Resim;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    _textEditingController.text = userViewModel.userModel!.userName.toString();

    debugPrint("profil sayfasında çekilen user değerleri " +
        userViewModel.userModel.toString());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: getAppBar(userViewModel),
      ),
      body: getBody(),
    );
  }

  Future<bool?> _cikisYap(BuildContext context) async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    var result = await userViewModel.signOut();
    return result;
  }

  Future _cikisIcinOnayIste(BuildContext context) async {
    final sonuc = await const PlatformDuyarliWidgetAlertDialog(
            baslik: "Emin misiniz?",
            icerik: "Çıkış yapmak mı istiyorsunuz",
            anaButonYazisi: "Evet",
            iptalButonYazisi: "Vazgeç")
        .goster(context);
    if (sonuc == true) {
      _cikisYap(context);
    } else {}
  }

  Future<void> _userNameGuncelle(BuildContext context) async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    if (userViewModel.userModel!.userName != _textEditingController.text) {
      var updateResult = await userViewModel.updateUserName(
          userViewModel.userModel!.userId!, _textEditingController.text);
      if (updateResult == true) {
        // ignore: use_build_context_synchronously
        const PlatformDuyarliWidgetAlertDialog(
          anaButonYazisi: "tamam",
          baslik: "Başarılı",
          icerik: "userName değiştirildi",
        ).goster(context);
      } else {
        _textEditingController.text =
            userViewModel.userModel!.userName.toString();
        // ignore: use_build_context_synchronously
        const PlatformDuyarliWidgetAlertDialog(
          anaButonYazisi: "tamam",
          baslik: "Hata",
          icerik: "username zaten kullanımda farklı bir username deneyiniz ",
        ).goster(context);
      }
    }
  }

  Future<void> _profilFotoGuncelle() async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    if (_profil_Foto != null) {
      var url = await userViewModel.uploadFile(
          userViewModel.userModel!.userId, "profil_foto", _profil_Foto);
      debugPrint("gelen Url$url");
    }
  }

  Widget getAppBar(UserViewModel userViewModel) {
    return AppBar(
        actions: [
          ElevatedButton.icon(
            label: Text(""),
            icon: Icon(Icons.more_vert),
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 160,
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Çıkış'),
                          onTap: () {
                            _cikisIcinOnayIste(context);
                            // Logout işlemleri
                            //Navigator.pop(context); // BottomSheet'i kapat
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.error_outline),
                          title: Text('Bildir'),
                          onTap: () {
                            _cikisIcinOnayIste(context);
                            // Logout işlemleri
                            //Navigator.pop(context); // BottomSheet'i kapat
                          },
                        ),
                      ],
                    ),
                  );
                },
              );

              //_cikisIcinOnayIste(context);
            },
          )
        ],
        elevation: 30,
        backgroundColor: Color.fromARGB(255, 23, 23, 23),
        flexibleSpace: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 180,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text("Fotoğraf Çek"),
                              onTap: () {
                                _kameradanFotoCek();
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.image),
                              title: const Text("Galeriden Seç"),
                              onTap: () {
                                _galeridenSec();
                              },
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Stack(children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: _profil_Foto == null
                        ? NetworkImage(
                            userViewModel.userModel!.profilURL.toString())
                        : Image.file(File(_profil_Foto!.path)).image,
                  ),
                  const Positioned(
                    top: 115,
                    left: 115,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 35,
                    ), // Sol üst köşedeki ikon
                  ),
                ]),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  userViewModel.userModel!.email.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    labelText: "Kullanıcı Adı",
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 35,
                child: ElevatedButton(
                  child: Text("Kaydet"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {
                    _userNameGuncelle(context);
                    _profilFotoGuncelle();
                  },
                ),
              ),
            ],
          ),
        )));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "Gönderiler",
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "8",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Takipci",
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "250",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "takip",
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "190",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isPhoto = true;
                      });
                    },
                    icon: Icon(
                      Icons.photo_album_outlined,
                      size: 30,
                      color: isPhoto ? Color(0xFF25A0B0) : Color(0xFF3a3a3a),
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isPhoto = false;
                      });
                    },
                    icon: Icon(
                      Icons.video_library,
                      size: 30,
                      color: !isPhoto ? Color(0xFF25A0B0) : Color(0xFF3a3a3a),
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            isPhoto
                ? Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: List.generate(postList.length, (index) {
                      return Container(
                        width: (size.width - 60) / 2,
                        height: (size.width - 60) / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(postList[index]),
                                fit: BoxFit.cover)),
                      );
                    }),
                  )
                : Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: List.generate(videoList.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          playVideo(context, videoList[index]['videoUrl']);
                        },
                        child: Container(
                          width: (size.width - 60) / 2,
                          height: (size.width - 60) / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(videoList[index]['img']),
                                  fit: BoxFit.cover)),
                          child: const Center(
                            child: Icon(
                              Icons.play_circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  )
          ],
        ),
      ),
    );
  }

  playVideo(BuildContext context, videoUrl) {
    _controller = VideoPlayerController.network(videoUrl);

    _controller.addListener(() {});
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )));
  }
}
