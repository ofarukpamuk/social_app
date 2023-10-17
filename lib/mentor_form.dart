/* /* import 'package:flutter/material.dart';
import 'package:email_launcher/email_launcher.dart';

class BiyografiFormu extends StatefulWidget {
  @override
  _BiyografiFormuState createState() => _BiyografiFormuState();
}

class _BiyografiFormuState extends State<BiyografiFormu> {
  final _formKey = GlobalKey<FormState>();
  String _adSoyad = '';
  String _telefonNo = '';
  String _okulNo = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _sendEmail();
    }
  }

  void _sendEmail() async {
    final emailAddress =
        'faruk.pmk6637@gmail.com'; // Kariyer Merkezi e-posta adresi

    final emailBody =
        'Ad Soyad: $_adSoyad\nTelefon No: $_telefonNo\nOkul No: $_okulNo';

    final Email email = Email(
      body: emailBody,
      subject: 'Kariyer Merkezi Formu - Biyografi',

      bcc: [
        emailAddress
      ], // İstenilen bcc alıcılarının e-posta adreslerini içeren bir liste
    );

    await EmailLauncher.launch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biyografi Formu'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Ad Soyad'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen adınızı ve soyadınızı girin';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _adSoyad = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Telefon No'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen telefon numaranızı girin';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _telefonNo = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Okul No'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen okul numaranızı girin';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _okulNo = value!;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Danışman Olmak İstiyorum'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _sendEmail,
                  child: Text('Formu Kariyer Merkezi\'ne Gönder'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 */
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class CareerFormPage extends StatefulWidget {
  @override
  _CareerFormPageState createState() => _CareerFormPageState();
}

class _CareerFormPageState extends State<CareerFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _schoolNoController = TextEditingController();

  Future<void> _sendFormToCareerCenter() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final Email email = Email(
      body:
          'Ad Soyad: ${_nameController.text}\nTelefon No: ${_phoneController.text}\nOkul No: ${_schoolNoController.text}',
      subject: 'Kariyer Merkezi Formu - Biyografi',
      recipients: ['kariyer@.com'], // Kariyer Merkezi e-posta adresi
    );

    await FlutterEmailSender.send(email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _schoolNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kariyer Merkezi Formu'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Ad Soyad'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen adınızı ve soyadınızı girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Telefon No'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen telefon numaranızı girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _schoolNoController,
                decoration: InputDecoration(labelText: 'Okul No'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen okul numaranızı girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _sendFormToCareerCenter,
                child: Text('Formu Kariyer Merkezine Gönder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

class KariyerFormu extends StatefulWidget {
  @override
  _KariyerFormuState createState() => _KariyerFormuState();
}

class _KariyerFormuState extends State<KariyerFormu> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _adController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();
  TextEditingController _okulController = TextEditingController();
  TextEditingController _biyografiController =
      TextEditingController(); // Yeni eklenen alan

  @override
  void dispose() {
    _adController.dispose();
    _telefonController.dispose();
    _okulController.dispose();
    _biyografiController.dispose(); // Yeni eklenen alanın dispose metodu
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text('Kariyer Formu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _adController,
                  decoration: InputDecoration(
                    labelText: 'Adınız',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen adınızı girin';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _telefonController,
                  decoration: const InputDecoration(
                    labelText: 'Telefon Numarası',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen telefon numaranızı girin';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _okulController,
                  decoration: const InputDecoration(
                    labelText: 'Okul no',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen okulunuzu girin';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLines: null,
                  controller:
                      _biyografiController, // Yeni eklenen alanın controller'ı
                  decoration: const InputDecoration(
                    labelText: 'Biyografi',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen biyografinizi girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      kariyerFormuGonder();
                    }
                  },
                  child: const Text('Kariyer Merkezine Gönder'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void kariyerFormuGonder() async {
    String kullaniciAdi = 'omer.deneme.email@gmail.com';
    String sifre = 'Deneme.1234';

    final smtpSunucusu = gmail(kullaniciAdi, sifre);

    final mesaj = Message()
      ..from = Address(kullaniciAdi, 'omer pamuk')
      ..recipients.add('omer.deneme.email@gmail.com')
      ..subject = 'Kariyer Formu Gönderimi'
      ..text = '''
      Ad: ${_adController.text}
      Telefon Numarası: ${_telefonController.text}
      Okul: ${_okulController.text}
      Biyografi: ${_biyografiController.text} // Yeni eklenen alanın değeri
      ''';

    try {
      final gonderimRaporu = await send(mesaj, smtpSunucusu);
      print('Mesaj gönderildi: ' + gonderimRaporu.toString());
    } catch (e) {
      showSuccessDialog(context);
      print(e);
    }
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('İşlem Başarılı'),
          content: Text('İşlem başarıyla tamamlandı.'),
          actions: [
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
