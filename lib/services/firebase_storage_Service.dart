import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:kursgirissayfasifirebase/services/storage_base.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference? _storageRefarence;

  @override
  /* Future<String> uploadFile(
      String userID, String fileType, XFile yuklenecekDosya) async {
    String? downloadURL;

    _storageRefarence = _firebaseStorage.ref().child(userID).child(fileType);

    UploadTask uploadTask = _storageRefarence!.putFile(yuklenecekDosya);

    await uploadTask.whenComplete(
      () async {
        downloadURL = await _storageRefarence!.getDownloadURL();
      },
    );

    return downloadURL!.toString();
  }
 */
  Future<String> uploadFile(
      String userID, String fileType, File yuklenecekDosya) async {
    String? downloadURL;

    _storageRefarence = _firebaseStorage
        .ref()
        .child(userID)
        .child(fileType)
        .child("profil_foto.png");

    UploadTask uploadTask =
        _storageRefarence!.putFile(File(yuklenecekDosya.path));

    await uploadTask.whenComplete(() async {
      downloadURL = await _storageRefarence!.getDownloadURL();
    });

    return downloadURL!.toString();
  }
}
